//
//  PaxShopGoodDetail.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/25.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxShopGoodDetail.h"

@implementation PaxShopGoodDetail
+(instancetype)detailWith:(NSString *)image qrcode:(NSString *)qrcode pin:(NSString *)pin
{
    PaxShopGoodDetail *de = [[PaxShopGoodDetail alloc]init];
    de.image = image;
    de.qrcode = qrcode;
    de.pin = pin;
    return de;
}
@end
