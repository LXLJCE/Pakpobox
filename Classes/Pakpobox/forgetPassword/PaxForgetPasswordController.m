//
//  PaxForgetPasswordController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/13.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxForgetPasswordController.h"
#import "PaxSMSViewController.h"
@interface PaxForgetPasswordController ()
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak,  nonatomic) UITextField *emailTextField;
@property (weak, nonatomic) UIButton *submitBtn;
@property (weak, nonatomic) UIView *intro;
@end

@implementation PaxForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navText = PaxForgetLoginPassword;
    [self setupUI];
    [self setupColor];
    [self setupFont];
    [self rac_event];
}

/**
 对于视图的设计
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(120);
//        make.width.mas_equalTo(328);
        make.left.equalTo(Weakself.view).offset(24);
        make.centerX.equalTo(Weakself.view);
        make.height.equalTo(@(210));
    }];
    
    UILabel *titleLable = [[UILabel alloc]init];
    _titleLabel = titleLable;
    [contentView addSubview: titleLable];
    titleLable.text = PaxForgotYourPassowrd;
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(30);
    }];
    UITextField *email = [[UITextField alloc]init];
    _emailTextField = email;
    [email backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    email.placeholder = PaxEmail;
    email.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:email];
    [email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.right.equalTo(contentView).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *submitBtn = [[UIButton alloc]init];
    _submitBtn = submitBtn;
    [submitBtn setTitle:PaxSubmit forState:UIControlStateNormal];
    [submitBtn backColor:Pax_TineColor cornerRadius:25 borderColor:[UIColor clearColor] borderWidth:1 isShadow:true];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [contentView addSubview:submitBtn];
    [submitBtn sizeToFit];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(email.mas_bottom).offset(20);
        make.right.equalTo(contentView);
        make.height.equalTo(@(50));
        make.width.equalTo(@(100));
    }];
    
    UIView *intro = [[UIView alloc]init];
    _intro = intro;
    [self.view addSubview:intro];
    [intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom);
//        make.width.mas_equalTo(328);
        make.left.equalTo(Weakself.view).offset(24);
        make.centerX.equalTo(Weakself.view);
        make.height.equalTo(@(200));
    }];
    
    UILabel *oneLabel = [[UILabel alloc]init];
    
    oneLabel.text = PaxForgotOne;
    oneLabel.numberOfLines = 0;
    [intro addSubview:oneLabel];
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(intro);
        make.left.right.equalTo(intro);
        make.height.equalTo(intro).multipliedBy(0.3);
    }];
    
    UILabel *twoLabel = [[UILabel alloc]init];
    twoLabel.text = PaxForgotTwo;
    twoLabel.numberOfLines = 0;
    [intro addSubview:twoLabel];
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneLabel.mas_bottom);
        make.left.right.equalTo(intro);
        make.height.equalTo(intro).multipliedBy(0.3);
    }];
    
    UILabel *threeLabel = [[UILabel alloc]init];
    threeLabel.text = PaxForgotThree;
    threeLabel.numberOfLines = 0;
    [intro addSubview:threeLabel];
    [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoLabel.mas_bottom);
        make.left.right.equalTo(intro);
        make.height.equalTo(intro).multipliedBy(0.3);
    }];
}


- (void)setupColor
{
    for (id sub in _intro.subviews) {
        if ([sub class] == [UILabel class]) {
            UILabel *subLabel = (UILabel *)sub;
            subLabel.textColor = Pax_Black;
        }
    }
    _intro.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    _intro.layer.cornerRadius = 5;
    _intro.layer.masksToBounds = true;
    _emailTextField.textColor = Pax_Color_Forgot_Text;
    [_submitBtn setTitleColor:Pax_Color_Forgot_Btn_title forState:UIControlStateNormal];
    _submitBtn.backgroundColor = Pax_TineColor;
}

- (void)setupFont
{
    for (id sub in _intro.subviews) {
        if ([sub class] == [UILabel class]) {
            UILabel *subLabel = (UILabel *)sub;
            subLabel.font = Pax_Font_Fotgot_Title;
        }
    }
    _titleLabel.font = Pax_Font_Fotgot_Title;
    _emailTextField.font = Pax_Font_Fotgot_Code_Title;
    _submitBtn.titleLabel.font = Pax_Font_Fotgot_Btn_Title;
    
}
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself networkRequest];
    }];
}

- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools]Pax_RetrievePasswordWitnTipMessage:PaxSendverificationcode andEmasil:_emailTextField.text andFinish:^(id responseObject, NSError *error) {
        [PaxHUD Pax_showSuccessWithStatus:PaxSendsuccessPleasenotethatcheckemail];
        PaxSMSViewController *sms = [[PaxSMSViewController alloc]init];
        sms.navText = PaxVerify;
        sms.email = _emailTextField.text;
        [Weakself.navigationController pushViewController:sms animated:true];
    }];
}


@end
