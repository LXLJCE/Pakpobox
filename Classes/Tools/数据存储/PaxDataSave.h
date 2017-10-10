//
//  PaxDataSave.h
//  Pakpobox
//
//  Created by 博兴 on 2017/4/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxDataSave : NSObject

/**
 保存国家

 @param country 国家
 */
+ (void)saveCountry:(NSString *)country;

/**
 获取国家

 @return 国家
 */
+ (NSString *)getCountry;

/**
 保存语言

 @param lanuage 语言
 */
+ (void)saveLanguage:(NSString *)lanuage;

/**
 获取语言

 @return 语言
 */
+ (NSString *)getLanuage;

/**
 保存用户信息

 @param userMessage 用户信息
 */
+ (void)saveUserMessage:(NSDictionary *)userMessage;

/**
 获取用户信息

 @return 用户信息
 */
+ (NSDictionary *)getUserMessage;


+ (void)saveDeviceToken:(NSString *)DeviceToken;
+ (NSString *)getDeviceToken;
@end
