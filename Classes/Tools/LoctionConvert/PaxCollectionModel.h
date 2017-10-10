//
//  PaxCollectionModel.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/2.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxCollectionModel : NSObject
@property (nonatomic, assign) NSInteger collectionID;
@property (copy, nonatomic) NSString *validateCode;
@property (copy, nonatomic) NSString *shortLink;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *expressNumber;
@end
