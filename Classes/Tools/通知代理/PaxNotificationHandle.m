//
//  PaxNotificationHandle.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/8.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxNotificationHandle.h"

@implementation PaxNotificationHandle

+(PaxNotificationHandle *) shareInstance
{
    static PaxNotificationHandle *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
-(void)authorizationPushNotificaton:(UIApplication *)application
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self; //必须写代理
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
        //注册之后的回调
        if (!error && granted) {
            NSLog(@"注册成功...");
        }
        else{
            NSLog(@"注册失败...");
        }
    }];
    
    //获取注册之后的权限设置
    //注意UNNotificationSettings是只读对象哦，不能直接修改！
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"通知配置信息:\n%@",settings);
    }];
    
    //注册通知获取token
    [application registerForRemoteNotifications];
}

#pragma mark UNUserNotificationCenterDelegate

//收到通知
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    
    //收到的内容
    UNNotificationContent *content = request.content;
    
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    
    //收到消息的角标
    NSNumber *badge = content.badge;
    
    //收到消息的body
    NSString *body = content.body;
    
    //收到消息的声音
    UNNotificationSound *sound = content.sound;
    
    //推送消息的副标题
    NSString *subtitle = content.subtitle;
    
    //推送消息的标题
    NSString *title = content.title;
    
    if ([notification.request.trigger isKindOfClass:[UNNotificationTrigger class]]) {
        NSLog(@"前台收到通知:%@\n",userInfo);
    }
    else{
        NSLog(@"前台收到通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@}",body,title,subtitle,badge,sound,userInfo);
    }
    //不管前台后台状态下。推送消息的横幅都可以展示出来！有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}


//app通知的点击事件
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    
    //收到的内容
    UNNotificationContent *content = request.content;
    
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    
    //收到消息的角标
    NSNumber *badge = content.badge;
    
    //收到消息的body
    NSString *body = content.body;
    
    //收到消息的声音
    UNNotificationSound *sound = content.sound;
    
    //推送消息的副标题
    NSString *subtitle = content.subtitle;
    
    //推送消息的标题
    NSString *title = content.title;
    
    if ([response.notification.request.trigger isKindOfClass:[UNNotificationTrigger class]]) {
        NSLog(@"点击了通知:%@\n",userInfo);
    }
    else{
        NSLog(@"通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler();
} @end
