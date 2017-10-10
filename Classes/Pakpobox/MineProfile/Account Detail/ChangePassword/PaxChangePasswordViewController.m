//
//  PaxChangePasswordViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/30.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxChangePasswordViewController.h"
#import "PaxLoginViewController.h"


@interface PaxChangePasswordViewController ()
@property (weak, nonatomic) UITextField *currentPassword;
@property (weak, nonatomic) UITextField *confirmPassword;
@property (weak, nonatomic) UILabel *introLabel;
@property (weak, nonatomic) UITextField *Password;
@property (weak, nonatomic) UIButton *confirmChange;
@property (weak, nonatomic) UILabel *bottomLabel;
@end

@implementation PaxChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupFont];
    [self setupText];
    [self setupColor];
    [self rac_event];
}
/**
 设置主界面UI
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 主体内容
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(Weakself.view);
        make.height.mas_equalTo(300);
        make.left.equalTo(Weakself.view).offset(24);
    }];
    
    //TODO: currentPassword
    UITextField *currentPassword = [[UITextField alloc]init];
    _currentPassword = currentPassword;
    currentPassword.secureTextEntry = true;
    currentPassword.borderStyle = UITextBorderStyleRoundedRect;
    [currentPassword backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [contentView addSubview:currentPassword];
    [currentPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        
        make.height.mas_equalTo(40);
    }];
    
    UITextField *confirmPassword = [[UITextField alloc]init];
    _confirmPassword = confirmPassword;
    confirmPassword.secureTextEntry = true;
    confirmPassword.borderStyle = UITextBorderStyleRoundedRect;
    [confirmPassword backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [contentView addSubview:confirmPassword];
    [confirmPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentPassword.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *introLabel = [[UILabel alloc]init];
    introLabel.numberOfLines = 0;
    _introLabel = introLabel;
    [contentView addSubview:introLabel];
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmPassword.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    UITextField *password = [[UITextField alloc]init];
    _Password = password;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.secureTextEntry = true;
    [password backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [contentView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introLabel.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *confirmChange = [[UIButton alloc]init];
    _confirmChange = confirmChange;
    [confirmChange backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [contentView addSubview:confirmChange];
    [confirmChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.numberOfLines = 0;
    _bottomLabel = bottomLabel;
    [contentView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmChange.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
}
/**
 字体设置
 */
- (void)setupFont
{
    _currentPassword.font = Pax_Font_Text;
    _confirmPassword.font = Pax_Font_Text;
    _introLabel.font = Pax_Font_Text;
    _Password.font = Pax_Font_Text;
    _confirmChange.titleLabel.font = Pax_Font_Button;
    _bottomLabel.font = Pax_Font_Text;
}
/**
 文字设置
 */
- (void)setupText
{
    self.navText = PaxChangePassword;
    _currentPassword.placeholder = PaxEntercurrentpassword;
    _confirmPassword.placeholder = PaxConfirmPassword;
    _introLabel.text = PaxIfthepassworddoesnotmatchorisnotwhatwehavenorecord;
    _Password.placeholder = PaxEnternewpassword;
    _bottomLabel.text = PaxSuccessPasswordchanged;
    [_confirmChange setTitle:PaxConfirmChange forState:UIControlStateNormal];
}
/**
 颜色设置
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _currentPassword.textColor = Pax_Black;
    _confirmPassword.textColor = Pax_Black;
    _introLabel.textColor = Pax_Black;
    _Password.textColor = Pax_Black;
    [_confirmChange setTitleColor:Pax_Black forState:UIControlStateNormal];
    _bottomLabel.textColor = Pax_Black;
    
}
/**
 事件设置
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_currentPassword rac_textSignal] subscribeNext:^(id x) {
        
    }];
    [[_confirmPassword rac_textSignal]subscribeNext:^(id x) {
        
    }];
    
    [[_Password rac_textSignal]subscribeNext:^(id x) {
        
    }];
    [[_confirmChange rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself networkRequest];
    }];
}

- (void)networkRequest
{
    
    [[LXLNetWorkTool shareTools]Pax_updatePasswordWithTipMessage:PaxModifyinPleasewaitmoment password:_Password.text originalPassword:_currentPassword.text Finish:^(id responseObject, NSError *error) {
        
        [PaxHUD Pax_showSuccessWithStatus:PaxSuccessPasswordchanged];
        PaxLoginViewController *login = [[PaxLoginViewController alloc]init];
        PaxMainBaseNavController *nav = [[PaxMainBaseNavController alloc]initWithRootViewController:login];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        
        
    }];
}
@end
