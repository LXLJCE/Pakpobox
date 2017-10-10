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
    [self setupBaseFont];
    [self setupBaseColor];
}

// MARK: -设置顶部样式
- (void)setupView
{
    
    
    UIImageView *bgImage = [[UIImageView alloc]init];
    [self.view addSubview:bgImage];
    bgImage.frame = self.view.bounds;
    bgImage.image = [UIImage imageNamed:@"bg"];
     
    
    
    
    
    
    
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
        [leftBtn sizeToFit];
        [topView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(topView);
            make.width.equalTo(@80);
            
        }];
    
    UILabel *title = [[UILabel alloc]init];
    self.labelT = title;
    title.text = _Labeltitle;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = Pax_Font_Nav_title;
    
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
- (void)setupBaseFont
{
    [_upBtn.titleLabel setFont:Pax_Font_Nav_left];
}

- (void)setupBaseColor
{
    _labelT.backgroundColor = [UIColor clearColor];
    _labelT.textColor = [UIColor orangeColor];
    [_upBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

@end
