//
//  PaxParcel_newViewController.h
//  Pakpobox
//
//  Created by 博兴 on 2017/4/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxBaseSubViewController.h"

@interface PaxHomePWBaseViewController : PaxBaseSubViewController

/**
 imageName 图片名称
 */
@property (strong, nonatomic) NSString *imageName;


/**
 第一个按钮名称
 */
@property (strong, nonatomic) NSString *btn1Name;

/**
 第二个按钮名称
 */
@property (strong, nonatomic) NSString *btn2Name;

/**
 第三个按钮名称
 */
@property (strong, nonatomic) NSString *btn3Name;


- (void)clickBtn1:(UIButton *)sender;
- (void)clickBtn2:(UIButton *)sender;
- (void)clickBtn3:(UIButton *)sender;
@end
