//
//  PaxSMSViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/13.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSMSViewController.h"
#import "PaxResetPasswordViewController.h"
@interface PaxSMSViewController ()
@property (weak, nonatomic) UITextField *code;
@property (weak, nonatomic) UIButton *sureBtn;
@property (weak, nonatomic) UILabel *intro;
@end

@implementation PaxSMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupColor];
    [self setupFont];
    [self rac_event];
}

- (void)setupUI
{
    LXLWeakSelf(self);
    UIView *contentView = [[UIView alloc]init];
//    contentView.backgroundColor = [UIColor cz_randomColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(120);
        make.centerX.equalTo(Weakself.view);
//        make.width.mas_equalTo(328);
        make.left.equalTo(Weakself.view).offset(24);
        make.height.mas_offset(93);
    }];
    UILabel *emailLabel = [[UILabel alloc]init];
    [contentView addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(contentView);
        make.height.mas_offset(40);
    }];
    
    emailLabel.text = _email;
    UIButton *submitBtn = [[UIButton alloc]init];
    self.sureBtn = submitBtn;
    [submitBtn setTitle:PaxVerify forState:UIControlStateNormal];
    [submitBtn backColor:Pax_TineColor cornerRadius:25 borderColor:[UIColor clearColor] borderWidth:1 isShadow:true];
/*    submitBtn.layer.borderColor = [UIColor grayColor].CGColor;
    submitBtn.layer.borderWidth = 1.0f;*/
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [contentView addSubview:submitBtn];
    [submitBtn sizeToFit];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailLabel.mas_bottom).offset(3);
        make.right.equalTo(contentView);
        make.bottom.equalTo(contentView);
        make.width.equalTo(@(100));
    }];
    
    
    UITextField *smsCode = [[UITextField alloc]init];
    self.code = smsCode;
    [smsCode backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    smsCode.placeholder = PaxSmsCode;
    smsCode.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:smsCode];
    [smsCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailLabel.mas_bottom).offset(3);
        make.left.equalTo(contentView);
        make.bottom.equalTo(contentView);
        make.right.equalTo(submitBtn.mas_left).offset(-10);
    }];
   
    UILabel *textLabel = [[UILabel alloc]init];
    self.intro = textLabel;
    textLabel.text = PaxSMS;
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(10);
        make.left.equalTo(Weakself.view).offset(24);
        make.right.equalTo(Weakself.view).offset(-24);
    }];
    
}

- (void)setupFont
{
    self.code.font = Pax_Font_SMS_Code_Title;
    self.sureBtn.titleLabel.font = Pax_Font_SMS_Btn_Title;
    self.intro.font = Pax_Font_SMS_Intro_Title;
}

- (void)setupColor
{
    self.code.textColor = [UIColor blackColor];
    self.intro.textColor = [UIColor blackColor];
    [self.sureBtn setTitleColor:Pax_Color_Verlia_Btn_title forState:UIControlStateNormal];
    self.sureBtn.backgroundColor = Pax_Orange;
}

- (void)rac_event
{
    LXLWeakSelf(self);
    [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [Weakself networkRequest];
    }];
}
/**
 网络请求
 */
- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools]Pax_CodeWitnTipMessage:PaxAuthenticatinpleasewaitamoment andCode:_code.text andEmail:_email andFinish:^(id responseObject, NSError *error) {
        [PaxHUD Pax_showSuccessWithStatus:PaxVerifysuccessfullypleaseesetpassword];
        PaxResetPasswordViewController *reset = [[PaxResetPasswordViewController alloc]init];
        reset.email = _email;
        reset.token = responseObject[@"token"];
        [Weakself.navigationController pushViewController:reset animated:true];
        
    }];
}
@end
