//
//  PaxBaseNavViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/27.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxBaseViewController.h"

@interface PaxBaseViewController ()
@property (weak, nonatomic) UILabel *labelT;
@property (weak, nonatomic) UIButton *upBtn;
@end

@implementation PaxBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    self.upBtn.hidden = _isHome;
}

// MARK: -设置顶部样式
- (void)setupView
{
    UIView *topView = [[UIView alloc]init];
    [self.view addSubview:topView];
    
    
     LXLWeakSelf(self);
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(20);
        make.left.right.equalTo(Weakself.view);
        make.height.equalTo(@44);
    }];
    


        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _upBtn = leftBtn;
        [leftBtn setTitle:PaxUpStep forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftBtn sizeToFit];
        [topView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(topView);
            make.width.equalTo(@80);
            
        }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = _Labeltitle;
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:21];
    [topView addSubview:title];
    [title sizeToFit];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(topView);
    }];
    
}
- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:true];
}

@end
