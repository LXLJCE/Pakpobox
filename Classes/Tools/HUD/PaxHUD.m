//
//  PaxHUD.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/17.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxHUD.h"

@implementation PaxHUD
static SCLAlertViewShowBuilder *showBuilder;
static SCLAlertViewBuilder * builder;
+ (void)load
{
    /*轻柔遮盖*/
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    
    /*消失时间*/
    [self setMinimumDismissTimeInterval:0.5];
    /*动画*/
//    [self setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
 }


+ (void)Pax_showWithStatus:(NSString *)status{
    
    
    [self showWithStatus:status];
}
+ (void)Pax_showSuccessWithStatus:(NSString *)status
{
    
    [self showSuccessWithStatus:status];
}

+ (void)Pax_showErrorWithStatus:(NSString *)status
{
    
    [self showErrorWithStatus:status];
}

+ (void)Pax_showWithLoading
{
    builder = [SCLAlertViewBuilder new];
    showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleWaiting)
    .title(@"网络加载中...");
    [showBuilder showAlertView:builder.alertView onViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    // or even
    showBuilder.show(builder.alertView, [UIApplication sharedApplication].keyWindow.rootViewController);
}

+ (void)Pax_dismiss
{
//    [builder.alertView removeFromParentViewController];
}
@end
