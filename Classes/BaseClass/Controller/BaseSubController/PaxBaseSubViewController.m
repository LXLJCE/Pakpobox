//
//  PaxBaseSubViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxBaseSubViewController.h"

@interface PaxBaseSubViewController ()
@property (weak, nonatomic) UIButton *leftBtn;

@property (weak, nonatomic) UILabel *navTitle;
@end

@implementation PaxBaseSubViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Pax_White;
    [self setupPaxNav];
    [self rac_event_pax];
}

/**
 设置顶部 NAV
 */
- (void)setupPaxNav
{
    self.navigationController.navigationBar.hidden = true;
    // Left_Arrow
    UIButton *leftBtn = [[UIButton alloc]init];
    LXLWeakSelf(self);
    _leftBtn = leftBtn;
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Weakself.view).offset(8);
        make.top.equalTo(Weakself.view).offset(20);
        make.width.height.mas_equalTo(60);
    }];
    leftBtn.imageView.contentMode = UIViewContentModeCenter;
    [leftBtn setImage:[UIImage imageNamed:@"Left_Arrow"] forState:UIControlStateNormal];
    
    //TODO: 标题
    UILabel *NavTitle = [[UILabel alloc]init];
    _navTitle = NavTitle;
    _navTitle.font = Pax_Font_H2;
    _navTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:NavTitle];
    [NavTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(Weakself.view);
        make.top.equalTo(Weakself.view).offset(20);
        make.height.mas_equalTo(60);
    }];
    
    if (_navText == nil) {
        _navTitle.hidden = true;
    }else{
        _navTitle.hidden = false;
        _navTitle.text = _navText;
    }
    UIButton *rightBtn = [[UIButton alloc]init];
    _rightBtn = rightBtn;
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Weakself.view).offset(-8);
        make.top.equalTo(Weakself.view).offset(20);
        make.width.height.mas_equalTo(60);
    }];
//    rightBtn.imageView.contentMode = UIViewContentModeCenter;
//    [rightBtn setImage:[UIImage imageNamed:@"Left_Arrow"] forState:UIControlStateNormal];
    
    if ([_rightTitle isEqualToString:@""]||_rightTitle == nil) {
        [rightBtn setTitle:PaxHome forState:UIControlStateNormal];
    }else{
        [rightBtn setTitle:_rightTitle forState:UIControlStateNormal];
    }
    
    
    [rightBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Pax_Font_Button;
    
}

- (void)clickHome:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:true];
}
- (void)setNavText:(NSString *)navText
{
    _navText = navText;
    if (_navText == nil) {
        _navTitle.hidden = true;
    }else{
        _navTitle.hidden = false;
        _navTitle.text = _navText;
    }
}


- (void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle = rightTitle;
    if ([_rightTitle isEqualToString:@""]||_rightTitle == nil) {
        [_rightBtn setTitle:PaxHome forState:UIControlStateNormal];
    }else{
        [_rightBtn setTitle:_rightTitle forState:UIControlStateNormal];
    }
    
}

/**
 绑定事件
 */
- (void)rac_event_pax
{
    LXLWeakSelf(self);
    
    [[_leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself.navigationController popViewControllerAnimated:true];
    }];
    
    
    
    [[_rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself clickPax];
        
    }];
}

- (void)clickPax
{
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)dealloc
{
    PaxLog(@"%@",@"死了");
}
@end
