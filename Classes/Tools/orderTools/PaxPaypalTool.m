//
//  PaxPaypalToolViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/27.
//  Copyright © 2017年 bx. All rights reserved.
//

// MARK: -专门处理订单的控制器
#import "PaxPaypalTool.h"

@interface PaxPaypalTool ()
@property(nonatomic, strong) PayPalConfiguration *payPalConfig;
@end

@implementation PaxPaypalTool
/*
 /// 真实交易环境-也就是上架之后的环境
 extern NSString * _Nonnull const PayPalEnvironmentProduction;
 /// 模拟环境-也就是沙盒环境
 extern NSString * _Nonnull const PayPalEnvironmentSandbox;
 /// 无网络连接环境-具体用处，咳咳，自行摸索
 extern NSString * _Nonnull const PayPalEnvironmentNoNetwork;
 */


// MARK: -关于Paypal相关配置

- (instancetype)init
{
    if (self = [super init]) {
        [self paypalConfigAbount];
    }
    return self;
}
- (void)paypalConfigAbount
{
    
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
    
    //是否接受信用卡
    _payPalConfig.acceptCreditCards = NO;
    
    //商家名称
    _payPalConfig.merchantName = @"商家名";
    
    //商家隐私协议网址和用户授权网址-说实话这个没用到
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    /*
    //设置地址选项-在支付页面可选择账户地址信息
    typedef NS_ENUM(NSInteger, PayPalShippingAddressOption) {
        //不展示地址信息
        PayPalShippingAddressOptionNone = 0,
        //这个没试过，自行查阅
        PayPalShippingAddressOptionProvided = 1,
        //paypal账号下的地址信息
        PayPalShippingAddressOptionPayPal = 2,
        //全选
        PayPalShippingAddressOptionBoth = 3,
    };
    */
    //paypal账号下的地址信息
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    //配置语言环境
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
}

- (PayPalConfiguration *)PayPalConfiguration
{
    return _payPalConfig;
}

@end
