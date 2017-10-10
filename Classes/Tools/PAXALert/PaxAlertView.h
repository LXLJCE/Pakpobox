//
//  PaxAlertView.h
//  Pakpobox
//
//  Created by 博兴 on 2017/4/17.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlertBlock)(NSString *mes);

@interface PaxAlertView : NSObject
+ (void)alert:(NSString *)select1 and:(NSString *)select2 finish:(AlertBlock)alertBlock;
@end
