//
//  PaxResetPasswordViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxResetPasswordViewController.h"

@interface PaxResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *againPassword;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation PaxResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navText = PaxResetPassword;
    _password.placeholder = PaxNewPassword;
    _againPassword.placeholder = PaxConfirmPassword;
    [_sureBtn setTitle:PaxConfirmChange forState:UIControlStateNormal];
//    _sureBtn.layer.cornerRadius = 6;
//    _sureBtn.layer.masksToBounds = true;
    [_password backColor:Pax_White cornerRadius:5 borderColor:[UIColor clearColor] borderWidth:1 isShadow:true];
    [_againPassword backColor:Pax_White cornerRadius:5 borderColor:[UIColor clearColor] borderWidth:1 isShadow:true];
    [_sureBtn backColor:Pax_TineColor cornerRadius:25 borderColor:[UIColor clearColor] borderWidth:1 isShadow:true];
    _emailLabel.text = _email;
    _password.secureTextEntry = true;
    _againPassword.secureTextEntry = true;
}


- (IBAction)clickSureBtn:(id)sender {
    
    [self networkRequest];
}

- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools]Pax_RestPasswordWithTipMessage:PaxChangingPleasewaitamoment andToken:_token andPassword:_password.text andFinish:^(id responseObject, NSError *error) {
        [PaxHUD Pax_showSuccessWithStatus:PaxChangepasswordSuccess];
        [Weakself.navigationController popToRootViewControllerAnimated:true];
    }];
}
@end
