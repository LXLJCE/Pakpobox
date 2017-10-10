//
//  PaxShopGoodDetailViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/25.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxShopGoodDetailViewController.h"
#import "PaxShopGoodDetailTableViewCell.h"
#import "PaxShopGoodDetail.h"
@interface PaxShopGoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *order_name;
@property (weak, nonatomic) IBOutlet UILabel *status_text;
@property (weak, nonatomic) IBOutlet UILabel *location_text;
@property (weak, nonatomic) IBOutlet UITableView *list;



@property (strong, nonatomic) NSMutableArray *goods;
@end

static NSString *cellID = @"PaxShopGoodDetailTableViewCell";
@implementation PaxShopGoodDetailViewController

- (NSMutableArray *)goods
{
    if(_goods == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _goods = model;
    }
    return _goods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.list registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    self.list.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self networkRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview DataSource , Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxShopGoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = self.goods[indexPath.row];
                  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goods.count !=0) {
        return 100;
    }else{
        return 44;
    }
    
}
- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_MyOrdersDetailWithTipMessage:PaxPleasewaitamomentLoad detailID:_detail_id Finish:^(id responseObject, NSError *error) {
        
        Weakself.order_name.text = responseObject[@"name"];
        Weakself.status_text.text = responseObject[@"order_status"];
        Weakself.location_text.text = [NSString stringWithFormat:@"%@\n%@",
                                       responseObject[@"express_list"][0][@"box"][@"name"],responseObject[@"express_list"][0][@"box"][@"address"]
                                       ];
        NSArray *items = responseObject[@"order_items"];
        
        NSString *code = [NSString stringWithFormat:@"http://47.90.16.40:18080/ebox/api/v1/barcode/express/402880855c15367c015c195fbf1b0017/%@",responseObject[@"express_list"][0][@"barcode"][@"id"]];
        for (NSDictionary *dict in items) {
            PaxShopGoodDetail *de = [PaxShopGoodDetail detailWith:dict[@"pic_url"] qrcode:code pin:responseObject[@"express_list"][0][@"validateCode"]];
            
            [Weakself.goods addObject:de];
        }
        [Weakself.list reloadData];
    }];
}
@end
