//
//  PaxSegmentNavController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/6.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSegmentNavController.h"

@interface PaxSegmentNavController ()

@end

@implementation PaxSegmentNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSegmentView];
    [self setupRightItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// MARK: -SegmentView
- (void)setupSegmentView
{
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:_items];
    seg.frame = CGRectMake(0, 0, ScreenWidth / 2.5, 30);
    self.navigationItem.titleView = seg;
    self.segControl = seg;
    /*[seg setTintColor:[UIColor orangeColor]];*/
    [seg setTintColor:self.tineColor];
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName : _titleColor_nor} forState:UIControlStateNormal];
    
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName : _titleColor_sel} forState:UIControlStateSelected];
    seg.selectedSegmentIndex = 0;
    
}
- (void)setupRightItem
{
    UIButton *button= [[UIButton alloc]init];
    self.btn = button;
    [button setImage:[UIImage imageNamed:_rightImageName] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    [self.btn addTarget:self action:@selector(clickRightItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}
- (void)clickRightItem{}
@end
