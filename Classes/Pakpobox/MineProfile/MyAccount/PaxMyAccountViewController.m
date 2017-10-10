//
//  PaxMyAccountViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/30.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyAccountViewController.h"
#import "PaxChangePasswordViewController.h"
@interface PaxMyAccountViewController ()
@property (weak, nonatomic) UILabel *username;
@property (weak, nonatomic) UILabel *email;
@property (weak, nonatomic) UILabel *telephone;
@property (weak ,nonatomic) UIView *select_locker;
@property (weak, nonatomic) UIButton *credits;
@property (weak, nonatomic) UIButton *ChangePassword;
@end

@implementation PaxMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = PaxMYACCOUNT;
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self setupText];
    [self rac_event];
   
}


/**
 基本元素设置
 */
- (UIView *)setupUnit:(SEL)clickView
{
    UIView *contentView = [[UIView alloc]init];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.left.equalTo(contentView).offset(5);
        make.right.equalTo(contentView).offset(0);
    }];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"img_jlcx_xl_sanjiao"];
    imageView.contentMode = UIViewContentModeCenter;
    [contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(contentView);
        make.width.mas_equalTo(50);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:clickView];
    [contentView addGestureRecognizer:tap];
    return contentView;
}


/**
 UI设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 内容
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(40);
        make.height.mas_equalTo(240);
    }];
    //TODO: username
    UILabel *userName = [[UILabel alloc]init];
    userName.textAlignment = NSTextAlignmentCenter;
    _username = userName;
    [userName backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1];
    [contentView addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(0);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(30);
    }];
    //TODO: email
    UILabel *email = [[UILabel alloc]init];
    email.textAlignment = NSTextAlignmentCenter;
    _email = email;
    [email backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1];
    [contentView addSubview:email];
    [email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(userName.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    //TODO: telephone
    UILabel *telephone = [[UILabel alloc]init];
    telephone.textAlignment = NSTextAlignmentCenter;
    _telephone = telephone;
    [telephone backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1];
    [contentView addSubview:telephone];
    [telephone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(email.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    //TODO: locker
    UIView *select_locker = [self setupUnit:@selector(clickSelectLocker)];
    _select_locker = select_locker;
    [select_locker backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1];
    [contentView addSubview:select_locker];
    [select_locker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(telephone.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    //TODO: credits
    UIButton *credits = [[UIButton alloc]init];
    credits.titleLabel.textAlignment = NSTextAlignmentCenter;
    _credits = credits;
    [credits backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1];
    [contentView addSubview:credits];
    [credits mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(select_locker.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    //TODO: telephone
    UIButton *changePassword = [[UIButton alloc]init];
    changePassword.titleLabel.textAlignment = NSTextAlignmentCenter;
    _ChangePassword = changePassword;
    [changePassword backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1];
    [contentView addSubview:changePassword];
    [changePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(credits.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
}
/**
 字体设置
 */
- (void)setupFont
{
    _username.font = Pax_Font_Text;
    _email.font = Pax_Font_Text;
    _telephone.font = Pax_Font_Text;
    for (id sub in _select_locker.subviews) {
        if ([sub class] == [UILabel class]) {
            UILabel *subLabel = (UILabel *)sub;
            
            subLabel.font = Pax_Font_Text;
        }
    }
    _credits.titleLabel.font = Pax_Font_Text;
    _ChangePassword.titleLabel.font = Pax_Font_Text;
}

/**
 颜色设置
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _username.textColor = Pax_Black;
    _email.textColor = Pax_Black;
    _telephone.textColor = Pax_Black;
    for (id sub in _select_locker.subviews) {
        if ([sub class] == [UILabel class]) {
            UILabel *subLabel = (UILabel *)sub;
            subLabel.textColor = Pax_Black;
        }
    }
    [_credits setTitleColor:Pax_Black forState:UIControlStateNormal];
    [_ChangePassword setTitleColor:Pax_Black forState:UIControlStateNormal];
}

/**
 内容
 */
- (void)setupText
{
    _username.text = @"张三";
    _email.text = @"123456789@qq.com";
    _telephone.text = @"151123456789";
    for (id sub in _select_locker.subviews) {
        if ([sub class] == [UILabel class]) {
            UILabel *subLabel = (UILabel *)sub;
            subLabel.text = @"你确定";
        }
    }
    [_credits setTitle:PaxFreeCredits forState:UIControlStateNormal];
    [_ChangePassword setTitle:PaxChangePassword forState:UIControlStateNormal];
}

/**
 事件绑定
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_ChangePassword rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        PaxChangePasswordViewController *changVc = [[PaxChangePasswordViewController alloc]init];
        [Weakself.navigationController pushViewController:changVc animated:true];
    }];
}

- (void)clickSelectLocker
{

}
@end
