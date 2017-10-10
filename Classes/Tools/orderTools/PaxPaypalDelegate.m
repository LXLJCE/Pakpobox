//
//  PaxPaypalDelegate.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/27.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxPaypalDelegate.h"

@implementation PaxPaypalDelegate

static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}


// MARK: -订单支付完成后回调此方法
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    /*
     //回调的 PayPalPayment 的 confirmation 属性包含此次订单的状态信息包括校验码，服务器可已通过该校验码验证交易真实性。
     //返回数据 - id所对应的就是校验码。
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

}

//MARK: -用户取消支付回调此方法
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
}
@end
