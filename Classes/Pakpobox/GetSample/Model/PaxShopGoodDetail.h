//
//  PaxShopGoodDetail.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/25.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxShopGoodDetail : NSObject
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *qrcode;
@property (copy, nonatomic) NSString *pin;

+(instancetype)detailWith:(NSString *)image qrcode:(NSString *)qrcode pin:(NSString *)pin;
@end
