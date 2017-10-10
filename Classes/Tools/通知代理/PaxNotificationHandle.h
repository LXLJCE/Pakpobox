//
//  PaxNotificationHandle.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/8.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface PaxNotificationHandle : NSObject<UNUserNotificationCenterDelegate>

+(PaxNotificationHandle *) shareInstance;

-(void)authorizationPushNotificaton:(UIApplication *)application;
@end
