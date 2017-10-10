//
//  PaxNearbyModel.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/2.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxNearbyModel : NSObject
@property (copy, nonatomic) NSString *nearbyId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) CGFloat distance;
@end
