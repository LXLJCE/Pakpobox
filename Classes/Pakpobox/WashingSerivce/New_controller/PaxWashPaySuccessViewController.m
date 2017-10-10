//
//  PaxWashPaySuccessViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/10.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxWashPaySuccessViewController.h"

@interface PaxWashPaySuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *aqcodeImg;
@property (weak, nonatomic) IBOutlet UILabel *wash_text;

@property (weak, nonatomic) IBOutlet UILabel *order_name;

@property (weak, nonatomic) IBOutlet UILabel *order_status;

@property (weak, nonatomic) IBOutlet UILabel *order_price;


@property (weak, nonatomic) IBOutlet UILabel *Pin;
@property (weak, nonatomic) IBOutlet UILabel *location;



@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UILabel *wash;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *locationD;







@end

@implementation PaxWashPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navText = PaxDetail;
    self.view.backgroundColor = Pax_White;
//    self.aqcodeImg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:@"http://baidu.com" imageViewWidth:100];
    [self.completeBtn backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [self networkRequest];
    
    
    
    
    self.status.text = PaxStatus;
    self.wash.text = PaxWash;
    self.price.text = PaxPrice;
    self.location.text = PaxLocation;
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setWashId:(NSString *)washId
{
    _washId = washId;
}

- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_MyOrdersDetailWithTipMessage:PaxPleasewaitamomentLoad detailID:_washId Finish:^(id responseObject, NSError *error) {
        [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
        
        Weakself.order_name.text = responseObject[@"name"];
        Weakself.order_status.text = responseObject[@"order_status"];
        Weakself.order_price.text = [NSString stringWithFormat:@"$%.2f",[responseObject[@"order_amount"] floatValue]];
        
        Weakself.wash_text.text = responseObject[@"order_items"][0][@"sku_item"][@"name"];
        Weakself.Pin.text = [NSString stringWithFormat:@"PIN: %@", responseObject[@"express_list"][0][@"validateCode"]];
        
        Weakself.location.text = [NSString stringWithFormat:@"%@\n%@", responseObject[@"express_list"][0][@"box"][@"name"],responseObject[@"express_list"][0][@"box"][@"address"]];
        
        NSString *code = [NSString stringWithFormat:@"http://47.90.16.40:18080/ebox/api/v1/barcode/express/402880855c15367c015c195fbf1b0017/%@",responseObject[@"express_list"][0][@"barcode"][@"id"]];
        Weakself.aqcodeImg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:code imageViewWidth:100];
        
    }];
}
@end
