//
//  PaxMyOrderModel.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/10.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxMyOrderModel : NSObject

/**
 id
 */
@property (copy, nonatomic) NSString *order_id;

/**
 标题
 */
@property (copy, nonatomic) NSString *name; //  标题

/**
 创建时间
 */
@property (nonatomic, assign) NSInteger create_time;// 创建时间

/**
 订单状态
 */
@property (copy, nonatomic) NSString *order_status; // 订单状态

/**
 支付状态
 */
@property (copy, nonatomic) NSString *pay_status;// 支付状态


/**
 支付金额
 */
@property (nonatomic, assign) float order_amount;

- (NSString *)time;
@end
