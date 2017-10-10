//
//  PaxPaypalDelegate.h
//  Pakpobox
//
//  Created by 博兴 on 2017/2/27.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxPaypalDelegate : NSObject<PayPalPaymentDelegate>
+ (instancetype)sharedInstance;
@end
