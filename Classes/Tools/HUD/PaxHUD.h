//
//  PaxHUD.h
//  Pakpobox
//
//  Created by 博兴 on 2017/3/17.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface PaxHUD : SVProgressHUD

+ (void)Pax_showWithStatus:(NSString *)status;
+ (void)Pax_showSuccessWithStatus:(NSString *)status;
+ (void)Pax_showErrorWithStatus:(NSString *)status;
+ (void)Pax_showWithLoading;
+ (void)Pax_dismiss;
@end
