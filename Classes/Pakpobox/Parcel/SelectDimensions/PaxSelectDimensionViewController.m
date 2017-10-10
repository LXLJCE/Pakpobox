//
//  PaxSelectDimensionViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/27.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSelectDimensionViewController.h"
#import "PaxPaypal.h"
#import "PaxParcelQrCodeDetailViewController.h"
@interface PaxSelectDimensionViewController ()<PayPalPaymentDelegate>

@property (weak, nonatomic) UIButton *perviousBtn;/**记录上一次点击*/
@property (weak, nonatomic) UILabel *titleLabel;/**标题*/
@property (weak, nonatomic) UIButton *continueBtn;/**下一步*/
@property (weak, nonatomic) UILabel *crashNum;/**费用*/

/**订单配置*/
@property(nonatomic, strong) PayPalConfiguration *payPalConfig;

@property (strong, nonatomic) PaxPaypal *model;


@property (strong, nonatomic) NSDictionary *responseObject;
@end

@implementation PaxSelectDimensionViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self setupText];
    [self rac_event];
    _crashNum.text = @"$";
    self.model = [[PaxPaypal alloc]init];
    
}


/**
 UI界面设计
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 设置标题
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    _titleLabel = titleLabel;
//    [self.view addSubview: titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(Weakself.view).offset(64 + 20);
//        make.left.right.equalTo(Weakself.view);
//    }];
    
    //TODO: 设置中间内容
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(24);
        make.right.equalTo(Weakself.view).offset(-24);
        make.height.mas_equalTo(250);
    }];
    
    UIView *small = [self setupLeftButtonAndRightTextViewLeftlabel:PaxSmallDimensions andRightText:Pax10 clickRightView:@selector(clickSmall:)];
    [contentView addSubview:small];
    [small mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    UIView *middle = [self setupLeftButtonAndRightTextViewLeftlabel:PaxMediumDimensions andRightText:Pax20 clickRightView:@selector(clickMiddle:)];
    [contentView addSubview:middle];
    [middle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(small.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    UIView *large = [self setupLeftButtonAndRightTextViewLeftlabel:PaxLargeDimensions andRightText:Pax30 clickRightView:@selector(clickLarge:)];
    [contentView addSubview:large];
    [large mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(middle.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    
    UILabel *crashNum = [[UILabel alloc]init];
    _crashNum = crashNum;
    crashNum.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:crashNum];
    [crashNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(large.mas_bottom).offset(20);
        make.left.equalTo(Weakself.view).offset(40);
        make.width.equalTo(Weakself.view).offset(-48).multipliedBy(0.5);
        make.height.mas_equalTo(40);
    }];
    //TODO: continueBtn
    UIButton *continueBtn = [[UIButton alloc]init];
    _continueBtn = continueBtn;
    [continueBtn backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [self.view addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(large.mas_bottom).offset(20);
        make.right.equalTo(Weakself.view).offset(-40);
        make.width.equalTo(Weakself.view).offset(-48).multipliedBy(0.5);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - 用于基本元素设计
- (UIView *)setupLeftButtonAndRightTextViewLeftlabel:(NSString *)title  andRightText:(NSString *)rightText clickRightView:(SEL)clickFuncation{
    UIView *content = [[UIView alloc]init];
    //TODO: 左边view的设计
    UIButton *leftView = [[UIButton alloc]init];
//    leftView.backgroundColor = Pax_White;
//    leftView.layer.cornerRadius = 5;
//    leftView.layer.masksToBounds = true;
    [leftView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [content addSubview:leftView];
    
    [leftView setTitle:title forState:UIControlStateNormal];
    
    [leftView addTarget:self action:clickFuncation forControlEvents:UIControlEventTouchDown];
    leftView.titleLabel.font = Pax_Font_Text;
    [leftView setTitleColor:Pax_Black forState:UIControlStateNormal];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(content);
        make.right.equalTo(content).offset(-100);
    }];
    
    
    //TODO: 右边view的设计
    UILabel *rightView = [[UILabel alloc]init];
    
    
    [content addSubview:rightView];
    rightView.text = rightText;
    rightView.font = Pax_Font_Text;
    rightView.textColor = Pax_Black;
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(content);
        make.width.mas_equalTo(50);
    }];
        return content;
}

/**
 设置字体
 */
- (void)setupFont
{
    _titleLabel.font = Pax_Font_H2;
    _continueBtn.titleLabel.font = Pax_Font_Button;
}

/**
 设置颜色
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _titleLabel.textColor = Pax_Black;
    _continueBtn.backgroundColor = Pax_White;
    [_continueBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
}

/**
 设置字体
 */
- (void)setupText
{
//    _titleLabel.text = PaxHowbigisyourparcel;
    [_continueBtn setTitle:PaxContinue forState:UIControlStateNormal];
    self.navText = PaxHowbigisyourparcel;
    
}

/**
    方法监听
 */
- (void)clickSmall:(UIButton *)sender
{
    [self clickButton:sender];
    _sender.mouthSize = @"S";
    _crashNum.text = Pax10;
}
- (void)clickMiddle:(UIButton *)sender{
    [self clickButton:sender];
    _sender.mouthSize = @"M";
    _crashNum.text = Pax20;
}

- (void)clickLarge:(UIButton *)sender{
    [self clickButton:sender];
    _sender.mouthSize = @"L";
    _crashNum.text = Pax30;
}

- (void)clickButton:(UIButton *)sender
{
    _perviousBtn.backgroundColor = Pax_White;
    _perviousBtn.selected = false;
    sender.selected = true;
    sender.backgroundColor = Pax_Orange;
    _perviousBtn = sender;
}



- (void)rac_event
{
    LXLWeakSelf(self);
   
    [[_continueBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself networkRequest];
    }];
}

//订单支付完成后回调此方法
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    [PaxHUD Pax_showSuccessWithStatus:[NSString stringWithFormat:@"%@,%@",PaxPaySuccess,_crashNum.text]];
    //回调的 PayPalPayment 的 confirmation 属性包含此次订单的状态信息包括校验码，服务器可已通过该校验码验证交易真实性。
    //返回数据 - id所对应的就是校验码。
    /*
    {
        client =     {
            environment = sandbox;
            "paypal_sdk_version" = "2.14.2";
            platform = iOS;
            "product_name" = "PayPal iOS SDK";
        };
        response =     {
            "create_time" = "2016-05-12T03:25:49Z";
            id = "PAY-6BG56850AF923584SK4Z7PNQ";
            intent = sale;
            state = approved;
        };
        "response_type" = payment;
    }
     */
    LXLWeakSelf(self);
    [paymentViewController dismissViewControllerAnimated:true completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            PaxParcelQrCodeDetailViewController *qrd = [[PaxParcelQrCodeDetailViewController alloc]init];
            qrd.responseObject = Weakself.responseObject;
            [Weakself.navigationController pushViewController:qrd animated:true];
        });
        
    }];
    
}

//用户取消支付回调此方法
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    [PaxHUD Pax_showErrorWithStatus:PaxPayCancel];
    [paymentViewController dismissViewControllerAnimated:true completion:^{
        
    }];
    
}

- (void)networkRequest{
    
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools]Pax_CreateSendExpressOrderWithTipMessage:PaxPleasewaitamomentLoad
                                                            ReceiverName:_sender.receiverName
                                                           receiverPhone:_sender.receiverPhone
                                                             deliveryBox:_sender.deliveryBox
                                                            recipientBox:_sender.recipientBox
                                                            recipientAddress:_sender.recipientAddress
                                                                 payType:_sender.payType
                                                               mouthSize:_sender.mouthSize
                                                                   image:_sender.image
                                                                 credits:_sender.credits
                                                            giftcardCode:_sender.giftcardCode
                                                                sendType:_sender.sendType
                                                                  Finish:^(id responseObject, NSError *error) {
    [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
                                                                      
                                                                      
                                                        
                                                                      Weakself.responseObject = responseObject;
                                                                      if (Weakself.perviousBtn != nil) {
                                                                          PayPalPayment *payment = [[PayPalPayment alloc] init];
                                                                          
                                                                          //订单总额
                                                                          if([Weakself.crashNum.text isEqualToString:Pax10]){
                                                                              payment.amount = [NSDecimalNumber decimalNumberWithString:@"10"];
                                                                          }else if([Weakself.crashNum.text isEqualToString:Pax20]){
                                                                              payment.amount = [NSDecimalNumber decimalNumberWithString:@"20"];
                                                                          }else if([Weakself.crashNum.text isEqualToString:Pax30]){
                                                                              payment.amount = [NSDecimalNumber decimalNumberWithString:@"30"];
                                                                          }else{
                                                                              return ;
                                                                          }
                                                                          
                                                                          
                                                                          //货币类型-RMB是没用的
                                                                          payment.currencyCode = @"USD";
                                                                          
                                                                          //订单描述
                                                                          payment.shortDescription = @"Hipster clothing";
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          //生成paypal控制器，并模态出来(push也行)
                                                                          //将之前生成的订单信息和paypal配置传进来，并设置订单VC为代理
                                                                          PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment                                                                                            configuration:Weakself.model.payPalConfig                                                                                                 delegate:Weakself];
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          //模态展示
                                                                          [Weakself presentViewController:paymentViewController animated:YES completion:nil];
                                                                      }
    
}];
    

}
@end
