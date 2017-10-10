//
//  PaxSegmentNavController.h
//  Pakpobox
//
//  Created by 博兴 on 2017/3/6.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaxSegmentNavController : UIViewController
@property (strong , nonatomic) NSArray *items;
@property (strong, nonatomic) UIColor    *tineColor;
@property (strong, nonatomic) UIColor    *titleColor_nor;
@property (strong, nonatomic) UIColor    *titleColor_sel;
@property (weak, nonatomic) UISegmentedControl *segControl;
@property (strong, nonatomic) NSString    *rightImageName;
@property (weak, nonatomic) UIButton *btn;
@end
