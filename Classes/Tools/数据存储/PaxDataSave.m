//
//  PaxDataSave.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxDataSave.h"

@implementation PaxDataSave
+ (void)saveCountry:(NSString *)country
{
    [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"Country"];
}

+ (NSString *)getCountry
{
    return (NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"Country"];
}
+ (void)saveLanguage:(NSString *)lanuage
{
    [[NSUserDefaults standardUserDefaults] setObject:lanuage forKey:@"Lanuage"];
}
+ (NSString *)getLanuage
{
    return (NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"Lanuage"];
}
+ (void)saveUserMessage:(NSDictionary *)userMessage
{
    [[NSUserDefaults standardUserDefaults] setObject:userMessage forKey:@"UserMessage"];
}
+ (NSDictionary *)getUserMessage
{
    return (NSDictionary *)[[NSUserDefaults standardUserDefaults]objectForKey:@"UserMessage"];
}

+ (void)saveDeviceToken:(NSString *)DeviceToken
{
    [[NSUserDefaults standardUserDefaults] setObject:DeviceToken forKey:@"DeviceToken"];
}
+ (NSString *)getDeviceToken
{
    return (NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceToken"];
}
@end
