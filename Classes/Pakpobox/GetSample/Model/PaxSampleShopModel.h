//
//  PaxSampleShopModel.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxSampleShopModel : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *pic_url;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) NSInteger quantity;
@property (copy, nonatomic) NSString *shopID;
@end
