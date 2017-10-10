//
//  PaxMyOrders_SubViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyOrders_SubViewController.h"
#import "PaxCollectionTableViewCell.h"
#import "PaxCollect_QRCODEViewController.h"
#import "PaxCollectionModel.h"
@interface PaxMyOrders_SubViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray    *models;
@end
// cellID
static NSString *cellID = @"PaxCollectionTableViewCell";

@implementation PaxMyOrders_SubViewController

- (NSMutableArray *)models
{
    if(_models == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _models = model;
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = Pax_Bg_Grey;
    
    [self setupTableview];
    [self networkRequestCollect];
    
    
}



/**
 设置tableview
 */
- (void)setupTableview
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(24, 40 + 64, self.view.bounds.size.width- 2 * 24, self.view.bounds.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark - 数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    PaxCollectionModel *model = self.models[indexPath.row];
    model.expressNumber = model.expressNumber;
    cell.model = self.models[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PaxCollect_QRCODEViewController *cqvc = [[PaxCollect_QRCODEViewController alloc]init];
    cqvc.hidesBottomBarWhenPushed = true;
    
    cqvc.model = self.models[indexPath.row];
    [self.navigationController pushViewController:cqvc animated:true];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}







-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.tableView reloadData];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



/**
 取件的列表
 */
- (void)networkRequestCollect
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools]Pax_unpickListWithTipMessage:PaxPleasewaitamomentLoad andFinish:^(NSArray *responseObject, NSError *error) {
        
        
        
        if (responseObject.count == 0) {
            [PaxHUD Pax_showSuccessWithStatus:PaxSorrynocollectionouwant];
        }else{
            [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
        [Weakself.models addObjectsFromArray:[PaxCollectionModel mj_objectArrayWithKeyValuesArray:responseObject]];
        [Weakself.tableView reloadData];
        }
      
    }];
}
@end
