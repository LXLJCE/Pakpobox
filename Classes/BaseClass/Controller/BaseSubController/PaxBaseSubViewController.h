//
//  PaxBaseSubViewController.h
//  Pakpobox
//
//  Created by 博兴 on 2017/4/21.
//  Copyright © 2017年 bx. All rights reserved.
//


typedef void(^Click)();
#import <UIKit/UIKit.h>

@interface PaxBaseSubViewController : UIViewController
@property (strong, nonatomic) NSString *navText;

@property (weak, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) NSString    *rightTitle;

- (void)clickPax;
@end
