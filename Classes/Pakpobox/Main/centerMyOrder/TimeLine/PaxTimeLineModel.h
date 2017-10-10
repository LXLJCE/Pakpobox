//
//  PaxTimeLineModel.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/2.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxTimeLineModel : NSObject
@property (nonatomic, assign) Boolean isShow;
@property (copy, nonatomic) NSString *customerStoreNumber;
@property (nonatomic, assign) long createTime;
@property (copy, nonatomic) NSString *status;
- (CGFloat)height;
- (NSString *)time;
@end
