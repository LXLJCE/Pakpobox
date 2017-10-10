//
//  PaxBigTitleViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/20.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxBigTitleViewController.h"

@interface PaxBigTitleViewController ()


@end

@implementation PaxBigTitleViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = true;
    [self setupPaxUI];
    [self setupPaxFont];
    [self setupPaxText];
}

/**
 初始化 主界面UI
 */
- (void)setupPaxUI
{
    LXLWeakSelf(self);
    //TODO: 顶部文字的设计
    UILabel *navTitle = [[UILabel alloc]init];
    _navTitle = navTitle;
    [self.view addSubview:navTitle];
    [navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(18);
        make.right.equalTo(Weakself.view).offset(-18);
        make.height.mas_equalTo(100);
    }];
}

/**
 字体初始化
 */
- (void)setupPaxFont
{
    _navTitle.font = Pax_Font_H1;
}

- (void)setupPaxText
{
    _navTitle.text = self.Navtext;
}
@end
