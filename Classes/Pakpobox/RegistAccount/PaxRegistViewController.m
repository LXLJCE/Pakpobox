//
//  PaxRegistViewController.m
//  Pakpobox
//
//  Created by 博兴 on 1017/2/28.
//  Copyright © 1017年 bx. All rights reserved.
//

#import "PaxRegistViewController.h"
#import "PaxCustomBtn.h"
#import "PaxSelectorPick.h"
#import "PaxSMSViewController.h"
#import "PaxMainViewController.h"
@interface PaxRegistViewController ()

@property (weak, nonatomic) UIView *contentView;

/**
 全名
 */
@property (weak, nonatomic) UITextField *fullName;

/**
 邮箱
 */
@property (weak, nonatomic) UITextField *email;

/**
 电话
 */
@property (weak, nonatomic) UITextField *phone;

/**
 密码
 */
@property (weak, nonatomic) UITextField *password;

/**
 再次输入密码
 */
@property (weak, nonatomic) UITextField *againPassword;

/**
 推荐人
 */
@property (weak, nonatomic) UITextField *recommandingPerson;

/**
 协议
 */
@property (weak, nonatomic) UIButton *conditionBtn;

/**
 同意
 */
@property (weak, nonatomic) UIButton *isAgreeBtn;


/**
 注册按钮
 */
@property (weak, nonatomic) UIButton *registBtn;

@end

@implementation PaxRegistViewController



/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Pax_Bg_Grey;
    [self setupRegistView];
    self.navText = PaxUPCreatAccount;
    [self rac_event];
    [self setupColor];
    [self setupFont];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupRegistView
{
    LXLWeakSelf(self);
   
    
    
    // 中部视图
    
    UIView *contentView = [[UIView alloc]init];
    self.contentView = contentView;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Weakself.view);
//        make.width.mas_equalTo(328);
        make.left.equalTo(Weakself.view).offset(24);
        make.top.equalTo(Weakself.view).offset(90);
        make.height.equalTo(Weakself.view);
    }];
    // 中间文字
    /*全称*/
    UITextField *fullName = [[UITextField alloc]init];
    self.fullName = fullName;
    [fullName backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    fullName.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:fullName];
    [fullName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_TextField_Height));
    }];
    fullName.placeholder = PaxFullName;
    /*邮箱*/
    UITextField *email = [[UITextField alloc]init];
    self.email = email;
    [email backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    email.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:email];
    [email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fullName.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_TextField_Height));
    }];
    email.placeholder = PaxEmail;

    /*手机号*/
    UITextField *phone = [[UITextField alloc]init];
    self.phone = phone;
    [phone backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    phone.keyboardType = UIKeyboardTypePhonePad;
    phone.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(email.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_TextField_Height));
    }];
    phone.placeholder = PaxTelephone;

    /*密码*/
    UITextField *password = [[UITextField alloc]init];
    self.password = password;
    [password backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    password.secureTextEntry = true;
    password.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_TextField_Height));
    }];
    password.placeholder = PaxPassword;

    /*确认密码*/
    UITextField *surePassword = [[UITextField alloc]init];
    self.againPassword = surePassword;
    surePassword.secureTextEntry = true;
    [surePassword backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    surePassword.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:surePassword];
    [surePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_TextField_Height));
    }];
    surePassword.placeholder = PaxSurePassword;

    /*推荐人邮箱*/
    UITextField *rommandingEmail = [[UITextField alloc]init];
    self.recommandingPerson = rommandingEmail;
    [rommandingEmail backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    rommandingEmail.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:rommandingEmail];
    [rommandingEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(surePassword.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_TextField_Height));
    }];
    rommandingEmail.placeholder = PaxRecommandingEmail;
    

    
    /*协议*/
    
    UIView *xieyiView = [[UIView alloc]init];
    [contentView addSubview:xieyiView];
    [xieyiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rommandingEmail.mas_bottom).offset(Pax_Regist_Bottom_margin);
        make.height.equalTo(@(Pax_Regist_BottomBtn_Height));
        make.centerX.equalTo(contentView);
        make.width.equalTo(@(300));
    }];
    
    UIButton *xieyiLeftBtn = [[UIButton alloc] init];
    self.isAgreeBtn = xieyiLeftBtn;
    [xieyiLeftBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [xieyiLeftBtn setImage:[UIImage imageNamed:@"check_on"] forState:UIControlStateSelected];
    [xieyiView addSubview:xieyiLeftBtn];
    [xieyiLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(xieyiView);
        make.width.equalTo(@(50));
    }];
    UIButton *xieyiRightBtn = [[UIButton alloc] init];
    self.conditionBtn = xieyiRightBtn;
    [xieyiView addSubview:xieyiRightBtn];
    [xieyiRightBtn setTitle:PaxAgreeCondition forState:UIControlStateNormal];
    [xieyiRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(xieyiView);
        make.left.equalTo(xieyiLeftBtn.mas_right);
        make.width.equalTo(@(250));
    }];
    
    
    /*注册按钮*/
    UIButton *registBtn = [[UIButton alloc]init];
    self.registBtn = registBtn;
    [registBtn backColor:Pax_TineColor cornerRadius:Pax_Regist_Bottom_Button_Height/2 borderColor:[UIColor clearColor] borderWidth:0 isShadow:false];
    [registBtn setTitle:PaxLowCreatAccount forState:UIControlStateNormal];
    [contentView addSubview:registBtn];
    
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xieyiView.mas_bottom).offset(Pax_Regist_Bottom_margin);
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Regist_Bottom_Button_Height));
    }];
    
    
    
    
    
}


/*事件集合rac*/
- (void)rac_event
{
    LXLWeakSelf(self);
    /*email*/
    [[_email rac_textSignal]subscribeNext:^(id x) {
        
    }];
    /*password*/
    [[_password rac_textSignal]subscribeNext:^(id x) {
        
    }];
    /*againPassword*/
    [[_againPassword rac_textSignal]subscribeNext:^(id x) {
        
    }];
    /*recommandingPsw*/
    [[_recommandingPerson rac_textSignal]subscribeNext:^(id x) {
        
    }];

    /*isAgreeBtn*/
    [[_isAgreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        Weakself.isAgreeBtn.selected = !Weakself.isAgreeBtn.selected;
    }];
    /*condtionBtn*/
     [[_conditionBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
         
     }];
    

    /*注册完成操作*/
    
    [[_registBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if (_isAgreeBtn.selected == false) {
            [PaxHUD Pax_showErrorWithStatus:PaxPleaseagrerelevantclause];
            return ;
        }
        
        [Weakself registRquest];

        
        
    }];
    

    
}

/**
 注册请求
 */
- (void)registRquest
{
    if (![self jiaoyanParameter]) {
        return ;
    }
    [[LXLNetWorkTool shareTools]Pax_RegistWithTipMessage:PaxRegisting andPhoneNumberL:_phone.text andName:_fullName.text andEmail:_email.text andLoginName:_email.text andPassword:_password.text andInviteCode:_recommandingPerson.text andRegisterType:@"IOS" andLanuage:nil andCountry:nil andFinish:^(id responseObject, NSError *error) {
        [PaxHUD Pax_showSuccessWithStatus:PaxRegistrationSuccessful];
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"token"] forKey:@"userToken"];
        [PaxDataSave saveUserMessage:responseObject];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[PaxMainViewController alloc]init];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
//    [self hideSelectorBox];
}

/*生命周期*/
- (void)dealloc
{
    PaxLog(@"%@",@"死了");
}


/**
 设置字体
 */
- (void)setupFont
{
    _conditionBtn.titleLabel.font = Pax_Font_Regist_Xieyi_Title;
    _registBtn.titleLabel.font = Pax_Font_Regist_Sure_btn;
}


/**
 设置颜色
 */
- (void)setupColor
{
     [_conditionBtn setTitleColor:Pax_Color_Regist_XieYi_Title forState:UIControlStateNormal];
    _registBtn.backgroundColor = Pax_Color_LoginBtn;
    
}


/**
 参数校验
 */
- (BOOL)jiaoyanParameter
{
    if ([_fullName.text isEqualToString:@""]) {
        [PaxHUD Pax_showErrorWithStatus:PaxUserNameisnotempty];
        return false;
    }else if([_email.text isEqualToString:@""]){
        [PaxHUD Pax_showErrorWithStatus:PaxEmailisnotempty];
        return false;
    }else if([_phone.text isEqualToString:@""]){
        [PaxHUD Pax_showErrorWithStatus:PaxPhoneNumberisnotempty];
        return false;
    }else if([_password.text isEqualToString:@""]){
        [PaxHUD Pax_showErrorWithStatus:PaxPasswordisnotempty];
        return false;
    }else if([_againPassword.text isEqualToString:_password.text]){
        [PaxHUD Pax_showErrorWithStatus:PaxEnteredpasswordsdiffer];
        return false;
    }else{
        return true;
    }
}
@end
