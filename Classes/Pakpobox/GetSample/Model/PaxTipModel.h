//
//  PaxTipModel.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/17.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxTipModel : NSObject
@property (copy, nonatomic) NSString *tip_id;
@property (copy, nonatomic) NSString *name;
@property (nonatomic, assign) BOOL isSelect;
@end
