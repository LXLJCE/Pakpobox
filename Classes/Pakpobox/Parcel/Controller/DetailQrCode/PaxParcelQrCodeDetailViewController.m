//
//  PaxParcelQrCodeDetailViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/27.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxParcelQrCodeDetailViewController.h"

@interface PaxParcelQrCodeDetailViewController ()

/**
 打印按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *printLabel;

/**
 二维码图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *qrImg;

/**
 顶部介绍文字
 */
@property (weak, nonatomic) IBOutlet UILabel *topTitle;

/**
 状态
 */
@property (weak, nonatomic) IBOutlet UILabel *status;

/**
 状态内容
 */
@property (weak, nonatomic) IBOutlet UILabel *status_text;

/**
 from
 */
@property (weak, nonatomic) IBOutlet UILabel *from;

/**
 from 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *from_text;
/**
 to
 */
@property (weak, nonatomic) IBOutlet UILabel *to;

/**
 to 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *to_text;


/**
 pin
 */
@property (weak, nonatomic) IBOutlet UILabel *pin;

/**
 pin 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *pin_text;

/**
 pin 底部内容
 */
@property (weak, nonatomic) IBOutlet UILabel *pin_detail;

/**
 底部内容
 */
@property (weak, nonatomic) IBOutlet UILabel *bottom_text;

@end

@implementation PaxParcelQrCodeDetailViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navText = PaxDetail;
    [_printLabel backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [self setupText];
    [self networkRequest];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  
}

/**
 内容设置
 */
- (void)setupText
{
    _topTitle.text = PaxThankyouSeeYourParcelorderdetailsbelow;
    _status.text = PaxStatus;
    _from .text = PaxFrom;
    _to.text = PaxTo;
    _pin.text = PaxPin;
    _pin_detail.text = PaxUsethepinorQR;
    _bottom_text.text = PaxEreceipt;
    [_printLabel setTitle:PaxPrintLabel forState:UIControlStateNormal];
    
    
    
//    _status_text.text = _responseObject[@"status"];
//    _from_text.text = [NSString stringWithFormat:@"%@\n%@",_responseObject[@"fromBox"][@"name"],_responseObject[@"fromBox"][@"address"]];
//    _to_text.text = [NSString stringWithFormat:@"%@\n%@",_responseObject[@"toBox"][@"name"],_responseObject[@"toBox"][@"address"]];
//    
//    NSString *code = [NSString stringWithFormat:@"http://47.90.16.40:18080/ebox/api/v1/barcode/express/402880855c15367c015c195fbf1b0017/%@",_responseObject[@"barcode"][@"id"]];
//    _qrImg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:code imageViewWidth:60];
//    
//    self.navText = _responseObject[@"customerStoreNumber"];
}


- (void)setResponseObject:(NSDictionary *)responseObject
{
    _responseObject = responseObject;
}

- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_MyOrdersDetailWithTipMessage:PaxPleasewaitamomentLoad detailID:_responseObject[@"order"][@"id"] Finish:^(id responseObject, NSError *error) {
        
            Weakself.status_text.text = responseObject[@"express_list"][0][@"status"];
            Weakself.from_text.text = [NSString stringWithFormat:@"%@\n%@",responseObject[@"express_list"][0][@"fromBox"][@"name"],responseObject[@"express_list"][0][@"fromBox"][@"address"]];
        
        if(responseObject[@"express_list"][0][@"toBox"] == nil){
        
        Weakself.to_text.text = [NSString stringWithFormat:@"%@\n%@",responseObject[@"express_list"][0][@"recipientAddress"][@"name"],responseObject[@"express_list"][0][@"recipientAddress"][@"detailedAddress"]];
        }
        else{
            Weakself.to_text.text = [NSString stringWithFormat:@"%@\n%@",responseObject[@"express_list"][0][@"toBox"][@"name"],responseObject[@"express_list"][0][@"toBox"][@"address"]];
        }
            NSString *code = [NSString stringWithFormat:@"http://47.90.16.40:18080/ebox/api/v1/barcode/express/402880855c15367c015c195fbf1b0017/%@",responseObject[@"express_list"][0][@"barcode"][@"id"]];
            Weakself.qrImg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:code imageViewWidth:60];
        
            Weakself.navText = responseObject[@"name"];
        Weakself.pin_text.text = responseObject[@"express_list"][0][@"customerStoreNumber"];
    }];
}

@end
