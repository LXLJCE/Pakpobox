//
//  PaxMyOdersDetailViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyOdersDetailViewController.h"
#import "PaxTimeLineViewController.h"
#import "PaxCollect_QRCODEViewController.h"
#import "PaxMapViewController.h"
#import "PaxCollectionModel.h"
#import "PaxMyOrderModel.h"

#import "PaxSpeakWithUsViewController.h"
@interface PaxMyOdersDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UILabel *order_name;
@property (weak, nonatomic) IBOutlet UILabel *order_status;
@property (weak, nonatomic) IBOutlet UILabel *fromAddress;
@property (weak, nonatomic) IBOutlet UILabel *pin_number;
@property (weak, nonatomic) IBOutlet UIImageView *qrImg;

@property (strong, nonatomic) NSDictionary *responseObject;

@end

@implementation PaxMyOdersDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_collectionBtn backColor:Pax_Orange cornerRadius:20 borderColor:Pax_Border_Grey borderWidth:0 isShadow:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)clickProgress:(id)sender {
//    [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
    PaxTimeLineViewController *time = [[PaxTimeLineViewController alloc]init];
    
    time.items = _responseObject[@"express_list"];
    
    [self.navigationController pushViewController:time animated:true];
}
- (IBAction)clickOpenMap:(id)sender {
//    [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
    PaxMapViewController *map = [[PaxMapViewController alloc]init];
    map.coll = CLLocationCoordinate2DMake([_responseObject[@"express_list"][0][@"fromBox"][@"latitude"] floatValue], [_responseObject[@"express_list"][0][@"fromBox"][@"longitude"] floatValue]);
    [self.navigationController pushViewController:map animated:true];
}
- (IBAction)clickCollection:(id)sender {
    [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
    
    
    PaxCollect_QRCODEViewController *cqvc = [[PaxCollect_QRCODEViewController alloc]init];
    PaxCollectionModel *model = [[PaxCollectionModel alloc]init];
    model.expressNumber = @"12138";
    model.location = @"不知道";
    model.status = @"Pick UP";
    model.shortLink = @"http://baidu.com";
    model.validateCode = @"111";
    cqvc.model = model;
    [self.navigationController pushViewController:cqvc animated:true];
}


- (void)setModel:(PaxMyOrderModel *)model
{

    _model = model;
    [self networkRequestWith:_model];
    
}
- (void)networkRequestWith:(PaxMyOrderModel *)model
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_MyOrdersDetailWithTipMessage:PaxPleasewaitamomentLoad detailID:model.order_id Finish:^(id responseObject, NSError *error) {
        [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
        
        _responseObject = responseObject;
        
        Weakself.fromAddress.text = [NSString stringWithFormat:@"%@\n%@", responseObject[@"express_list"][0][@"box"][@"name"] == nil? PaxUnknowaddress : responseObject[@"express_list"][0][@"box"][@"name"] , responseObject[@"express_list"][0][@"box"][@"address"] ==nil ? PaxUnknowaddress :responseObject[@"express_list"][0][@"box"][@"address"]];
       // if (Weakself.fromAddress.text == nil) {
        //    Weakself.fromAddress.text = PaxUnknowaddress;
        // }
        
        
        Weakself.order_status.text = responseObject[@"order_status"];
        Weakself.pin_number.text = responseObject[@"express_list"][0][@"validateCode"];
        Weakself.order_name.text = responseObject[@"name"];
        
        
        NSString *code = [NSString stringWithFormat:@"http://47.90.16.40:18080/ebox/api/v1/barcode/express/402880855c15367c015c195fbf1b0017/%@",responseObject[@"express_list"][0][@"fromBox"][@"barcode"][@"id"]];
        Weakself.qrImg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:code imageViewWidth:Weakself.qrImg.height];
        
        
        
//        Weakself.coll = CLLocationCoordinate2DMake(<#CLLocationDegrees latitude#>, <#CLLocationDegrees longitude#>)
        
    }];
}
- (IBAction)clicksupport:(id)sender {
    PaxSpeakWithUsViewController *speak = [[PaxSpeakWithUsViewController alloc]init];
    speak.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:speak animated:true];
}

@end
