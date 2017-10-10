//
//  PaxParamter_CreateSender.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxParamter_CreateSender.h"

@implementation PaxParamter_CreateSender
- (instancetype)init
{
    if (self = [super init]) {
        self.giftcardCode = @"";
        self.receiverName = @"";
        self.receiverPhone = @"";
        
        self.credits = 0;
        self.mouthSize = @"";
        self.image = [[UIImage alloc]init];
        self.payType = @"";
        self.sendType = @"";
    }
    return self;
}

@end
