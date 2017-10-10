//
//  PaxPaypal.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/10.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxPaypal.h"

@implementation PaxPaypal
- (instancetype)init
{
    if (self = [super init]) {
        //是否接受信用卡
        _payPalConfig.acceptCreditCards = NO;
        
        //商家名称
        _payPalConfig.merchantName = @"商家名";
        
        //商家隐私协议网址和用户授权网址-说实话这个没用到
        _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
        _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
        
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
        
        //paypal账号下的地址信息
        _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
        
        //配置语言环境
        _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    }
    return self;
}
@end
