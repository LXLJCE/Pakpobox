//
//  PaxReturnOrderInformationViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxReturnOrderInformationViewController.h"

@interface PaxReturnOrderInformationViewController ()
/**顶部说明标题*/
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
/**打印按钮*/
@property (weak, nonatomic) IBOutlet UIButton *printLabel;
/**底部说明文字*/
@property (weak, nonatomic) IBOutlet UILabel *bottomIntroduce;
///**内容标题*/
//@property (weak, nonatomic) IBOutlet UILabel *DetailTitle;
/**Locker*/
@property (weak, nonatomic) IBOutlet UILabel *Locker;
/**Door*/
@property (weak, nonatomic) IBOutlet UILabel *Door;
/**Order*/
@property (weak, nonatomic) IBOutlet UILabel *Order;
/**Pin*/
@property (weak, nonatomic) IBOutlet UILabel *Pin;
/**QRCodeIm*/
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeIm;
/**DetailIntro*/
@property (weak, nonatomic) IBOutlet UILabel *DetailIntro;
@end

@implementation PaxReturnOrderInformationViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_printLabel backColor:Pax_White cornerRadius:6 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [self setupText];
    
    [self rac_event];
    [self setupContent];
    [self networkRequest];
}


/**
 UI设置
 */

/**设置文字*/
- (void)setupText
{
    self.navText = PaxReturnOrderInformation;
    _topLabel.text = PaxSeeyoureturndetails;
    _bottomIntroduce.text = PaxEreceipt;
    [_printLabel setTitle:PaxPrintLabel forState:UIControlStateNormal];
//    _Locker.text = @"Windsor House - CauseWaybay";
//    _Door.text = @"Windsor House - CauseWaybay";
//    _Order.text = @"Windsor House - CauseWaybay";
    _DetailIntro.text = PaxPleasegotothePakpoboxlocker;
//    _Pin.text = @"123";
//    _Pin.text = _responseObject[@"validateCode"];
//    
//    NSString *code = [NSString stringWithFormat:@"http://47.90.16.40:18080/ebox/api/v1/barcode/express/402880855c15367c015c195fbf1b0017/%@",_responseObject[@"barcode"][@"id"]];
//    _QRCodeIm.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:code imageViewWidth:60];
//    _Order.text = _responseObject[@"customerStoreNumber"];
//    
//    _Locker.text = _responseObject[@"box"][@"name"];
//    
//    _Door.text = _responseObject[@"mouth"][@"box"][@"address"];
}
/**绑定事件*/
- (void)rac_event{

}

/**
 内容设置
 */
- (void)setupContent
{
//    _QRCodeIm.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:@"www.baidu.com" imageViewWidth:60];
}

- (void)setResponseObject:(NSDictionary *)responseObject
{
    _responseObject = responseObject;
    
}


- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_MyOrdersDetailWithTipMessage:PaxPleasewaitamomentLoad detailID:_responseObject[@"order"][@"id"] Finish:^(id responseObject, NSError *error) {
            Weakself.Pin.text = responseObject[@"express_list"][0][@"validateCode"];
        
            NSString *code = [NSString stringWithFormat:@"http://47.90.16.40:18080/ebox/api/v1/barcode/express/402880855c15367c015c195fbf1b0017/%@",responseObject[@"express_list"][0][@"barcode"][@"id"]];
            _QRCodeIm.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:code imageViewWidth:60];
            Weakself.Order.text = responseObject[@"name"];
        
            _Locker.text = [NSString stringWithFormat:@"%@\n%@",responseObject[@"express_list"][0][@"box"][@"name"],responseObject[@"express_list"][0][@"box"][@"address"]];
        NSString *door = responseObject[@"express_list"][0][@"mouth"][@"mouthType"][@"name"];
        if ([door isEqualToString:@"S"]) {
            _Door.text = PaxSmallDimensions;
        }else if([door isEqualToString:@"M"]){
            _Door.text = PaxMediumDimensions;
        }else if([door isEqualToString:@"L"]){
            _Door.text = PaxLargeDimensions;
        }
        
        
        
//            _Door.text = [NSString stringWithFormat:@"%@\n%@",responseObject[@"express_list"][0][@"mouth"][@"name"],responseObject[@"express_list"][0][@"mouth"][@"address"]];;
    }];
}

@end
