//
//  PaxCollectionModel.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/2.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxCollectionModel.h"

@implementation PaxCollectionModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"collectionID":@"id",
             @"shortLink":@"barcode.shortLink",
             @"location": @"mouth.box.name",
             };
}
@end
