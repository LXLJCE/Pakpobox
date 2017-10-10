//
//  PaxLoginViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/27.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxLoginViewController.h"
#import "PaxCustomTextField.h"
#import "PaxRegistViewController.h"
#import "PaxMainViewController.h"
#import "PaxForgetPasswordController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface PaxLoginViewController ()
@property (weak, nonatomic) UITextField *email; /**邮箱输入*/
@property (weak, nonatomic) UITextField *password;/**密码输入*/
@property (weak, nonatomic) UIButton *loginBtn;/**登陆点击*/
@property (weak, nonatomic) UIButton *forgetPwBtn;/**忘记密码*/
@property (weak, nonatomic) UIButton *facebookBtn;/**facebook登陆*/
@property (weak, nonatomic) UIButton *registBtn;/**注册*/


@end

@implementation PaxLoginViewController

/**
 生命周期方法
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    [self setupLoginView];
    [self setupColor];
    [self setupFont];
}

// MARK: -建立登陆界面
- (void)setupLoginView
{
    //TODO: 内容视图
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    LXLWeakSelf(self);
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(20);
        make.centerX.equalTo(Weakself.view);
//        make.width.mas_equalTo(328);
        make.left.equalTo(Weakself.view).offset(24);
        make.bottom.equalTo(Weakself.view);
    }];
//TODO: 顶部图片
    
     UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snap6"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    [contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Top_Image_Height));
    }];
    
    //TODO:  中间文字
    UITextField *email = [[UITextField alloc]init];
    email.borderStyle = UITextBorderStyleRoundedRect;
    [email backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    self.email = email;
    [contentView addSubview:email];
    [email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(Pax_Login_Top_Image_Height+15);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_Login_Height));
    }];
    email.placeholder = PaxEmail;

    
    
    
    
    
    UITextField *password = [[UITextField alloc]init];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.placeholder = PaxPassword;
    [password backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    password.secureTextEntry = true;
    self.password = password;
    [contentView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(email.mas_bottom).offset(10);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_Login_Height));
    }];

    
    
    //TODO:  底部按钮
    UIButton *forgetPassword = [[UIButton alloc]init];
    self.forgetPwBtn = forgetPassword;
    [forgetPassword setTitle:PaxForgetLoginPassword forState:UIControlStateNormal];
    [contentView addSubview:forgetPassword];
    [forgetPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetPassword.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetPassword sizeToFit];
    [forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom);
        make.left.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Center_Login_Height));
    }];
    
    CGFloat height = ScreenHeight - 64 - Pax_Login_Top_Image_Height - 20 - 3*Pax_Login_Center_Login_Height;
    CGFloat margin = (height - 3 * Pax_Login_Bottom_Button_Height) / 4;
    margin = 20;
    
    //TODO: 登陆按钮
    UIButton *loginBtn = [[UIButton alloc]init];
    self.loginBtn = loginBtn;
    [loginBtn setBackgroundColor:[UIColor greenColor]];
//    loginBtn.layer.cornerRadius = Pax_Login_Bottom_Button_Height / 2;
//    loginBtn.layer.masksToBounds = true;
    [loginBtn backColor:[UIColor clearColor] cornerRadius:Pax_Login_Bottom_Button_Height / 2 borderColor:[UIColor clearColor] borderWidth:0 isShadow:false];
    [loginBtn setTitle:PaxLogin forState:UIControlStateNormal];
    [contentView addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forgetPassword.mas_bottom).offset(margin);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Bottom_Button_Height));
    }];
    
    
    
    //TODO: facebook
    UIButton *facebookLogin = [[UIButton alloc]init];
    
    self.facebookBtn = facebookLogin;
 
    [facebookLogin setBackgroundColor:[UIColor blueColor]];
    [facebookLogin setTitle:PaxFacebookLogin forState:UIControlStateNormal];
//    facebookLogin.layer.cornerRadius = Pax_Login_Bottom_Button_Height / 2;
//    facebookLogin.layer.masksToBounds = true;
    [facebookLogin backColor:Pax_Color_LoginBtn cornerRadius:Pax_Login_Bottom_Button_Height / 2 borderColor:[UIColor clearColor] borderWidth:1 isShadow:false];
    [contentView addSubview:facebookLogin];
    
    [facebookLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(margin);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Bottom_Button_Height));
    }];
    
    
    //TODO: regist
    UIButton *registBtn = [[UIButton alloc]init];
    self.registBtn = registBtn;
    [registBtn setBackgroundColor:[UIColor redColor]];
    [registBtn setTitle:PaxUPCreatAccount forState:UIControlStateNormal];
//    registBtn.layer.cornerRadius = Pax_Login_Bottom_Button_Height / 2;
//    registBtn.layer.masksToBounds = true;
    [registBtn backColor:Pax_Color_LoginBtn cornerRadius:Pax_Login_Bottom_Button_Height / 2 borderColor:[UIColor clearColor] borderWidth:1 isShadow:false];
    [contentView addSubview:registBtn];
    
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(facebookLogin.mas_bottom).offset(margin);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@(Pax_Login_Bottom_Button_Height));
    }];
    
    
    
    [self rac_event];
}

/*添加事件*/
#pragma mark : -添加事件方法
- (void)rac_event
{
    LXLWeakSelf(self);
    //TODO:  email
    [[_email rac_textSignal]subscribeNext:^(id x) {
        PaxLog(@"%@",x);
    }];
    
    // TODO: password
    [[_password rac_textSignal]subscribeNext:^(id x) {
        
    }];
    
    //TODO: forgetBtn
    [[_forgetPwBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        PaxForgetPasswordController *pax = [[PaxForgetPasswordController alloc]init];
       
        [Weakself.navigationController pushViewController:pax animated:true];
    }];
    //TODO: LoginBtn
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself LoginEvent];
        
    }];
    
    //TODO: faceBookBtn 事件
    [[_facebookBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        // 打开 FBSDKProfile 自动追踪 FBSDKAccessToken
        //        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        [FBSDKProfile enableUpdatesOnAccessTokenChange:true];
        // 清空FBSDKAccessToken
        //        FBSDKAccessToken.setCurrent(nil)
        [FBSDKAccessToken setCurrentAccessToken:nil];
        // 登录
        //        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        //        loginManager.logOut() // 先退出登录
        //        loginManager.loginBehavior = .native // 优先客户端方式
        FBSDKLoginManager *manage = [[FBSDKLoginManager alloc]init];
        [manage logOut];
        [manage setLoginBehavior:FBSDKLoginBehaviorNative];
        [manage logInWithReadPermissions:@[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (result == nil) {
                return ;
            }
            if (error) {
                NSLog(@"%@",@"Process error");
            }else if( result.isCancelled){
                NSLog(@"%@",@"Cancelled");
                [PaxHUD Pax_showErrorWithStatus:PaxCancelFaceBookLogIn];
            }else{
                NSLog(@"UserID:%@\r\nToken:%@",result.token.userID,result.token.tokenString );
                
                [Weakself networkRequestOpen:result.token];
                
                
//                NSLog(@"FBSDKProfile.current():%@",[FBSDKProfile currentProfile]);
//                [PaxHUD Pax_showSuccessWithStatus:[NSString stringWithFormat:@"FaceBook\nUserID:%@\r\nToken:%@",result.token.userID,result.token.tokenString]];
                
                
                
//                PaxRegistViewController *registV = [[PaxRegistViewController alloc]init];
//                
//                [Weakself.navigationController pushViewController:registV animated:true];
            }
        }];
        
    }];
    
    //TODO: registBtn
    [[_registBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        PaxRegistViewController *registV = [[PaxRegistViewController alloc]init];
       
        [Weakself.navigationController pushViewController:registV animated:true];
    }];
}

/**
 三方登录
 */
- (void)networkRequestOpen:(FBSDKAccessToken *)fb
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_OpenLoginTipMessage:PaxPleasewaitamomentLoad appId:fb.appID openId:fb.userID accessToken:fb.tokenString openPlatformType:@"FACEBOOK" clientType:@"IOS" Finish:^(id responseObject, NSError *error) {
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"token"] forKey:@"userToken"];
        [PaxDataSave saveUserMessage:responseObject];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[PaxMainViewController alloc]init];
    }];
}

/*生命周期*/

#pragma mark : - 声明周期方法 dealloc
- (void)dealloc
{
    PaxLog(@"%@",@"死了");
}

#pragma mark : - 界面设置相关
#pragma mark : - 字体
- (void)setupFont
{
    _forgetPwBtn.titleLabel.font = Pax_Font_Login_Forgot;
    _loginBtn.titleLabel.font = Pax_Font_Button;
    _facebookBtn.titleLabel.font = Pax_Font_Button;
    _registBtn.titleLabel.font = Pax_Font_Button;
}

#pragma mark : - 颜色
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    [_forgetPwBtn setTitleColor:Pax_Color_Forgot_Text forState:UIControlStateNormal];
    _loginBtn.backgroundColor = Pax_Color_LoginBtn;
    _facebookBtn.backgroundColor = Pax_Color_FacebookBtn;
    _registBtn.backgroundColor = Pax_Orange;
    
}

/**
 网络请求接口
 */
#pragma mark : - 网络数据请求
- (void)LoginEvent
{
    
    [self.view endEditing:true];
    if (![self jiaoyanParamters]) {
        return;
    }
    
    [[LXLNetWorkTool shareTools] Pax_LoginWithTipMessage:PaxLogging andLoginName:_email.text andPassword:_password.text andLoginType:@"ACCOUNT" WithFinish:^(NSDictionary *responseObject, NSError *error) {
        [PaxHUD Pax_showSuccessWithStatus:PaxLoginSuccess];
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"token"] forKey:@"userToken"];
        [PaxDataSave saveUserMessage:responseObject];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[PaxMainViewController alloc]init];
    }];


       
    
}

- (BOOL)jiaoyanParamters{

    if([_email.text isEqualToString:@""] || [_password.text isEqualToString:@""]) {
        [PaxHUD Pax_showErrorWithStatus:PaxUserpasswordcannotbeempty];
        return false;
    }else{
    
    return true;
    }
}
@end
