//
//  PaxParamter_CreateSender.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxParamter_CreateSender : NSObject
@property (copy, nonatomic) NSString *receiverName;
@property (copy, nonatomic) NSString *receiverPhone;
@property (strong, nonatomic) NSDictionary    *deliveryBox;
@property (strong, nonatomic) NSDictionary *recipientBox;
@property (strong, nonatomic) NSDictionary *recipientAddress;
@property (strong, nonatomic) NSString *payType;
@property (strong, nonatomic) NSString *mouthSize;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *giftcardCode;
@property (strong, nonatomic) NSString *sendType;
@property (assign, nonatomic) NSInteger credits;
@end
