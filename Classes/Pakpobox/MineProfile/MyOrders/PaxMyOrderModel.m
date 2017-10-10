//
//  PaxMyOrderModel.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/10.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyOrderModel.h"

@implementation PaxMyOrderModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"order_id":@"id"};
}

- (NSString *)time{

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_create_time / 1000];
    NSString *ago = [date timeAgo];
    
    return [NSString stringWithFormat:@"%@",ago];
}
@end
