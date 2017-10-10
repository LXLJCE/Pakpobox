//
//  PaxMineTableViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/7.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMineTableViewController.h"

#import "PaxSpeakWithUsViewController.h"
#import "PaxMyAccountViewController.h"
#import "PaxSettingViewController.h"
#import "PaxLoginViewController.h"
#import "PaxMainViewController.h"
#import "PaxMyOrderListViewController.h"
#import "PaxCreditsViewController.h"
@interface PaxMineTableViewController ()


@property (weak, nonatomic) UIButton *setting;
@property (weak, nonatomic) UIButton *accountDetails;
@property (weak, nonatomic) UIButton *myCredits;
@property (weak, nonatomic) UIButton *myWallet;
@property (weak, nonatomic) UIButton *myOrders;
@property (weak, nonatomic) UIButton *support;
@property (weak, nonatomic) UIButton *logOut;

@property (weak, nonatomic) UIView *contentView;

@end

@implementation PaxMineTableViewController





/**
 声明周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupFont];
    [self setupText];
    [self setupColor];
    [self rac_event];
}


/**
 界面设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 内容视图
    UIView *contentView = [[UIView alloc]init];
    _contentView = contentView;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.center.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(24);
        make.height.mas_equalTo(400);
    }];
    //TODO: 设置按钮
    UIButton *setting = [[UIButton alloc] init];
    _setting = setting;
    [setting backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:setting];
    [setting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    //TODO: 账户详情
    UIButton *AccountDetail = [[UIButton alloc] init];
    _accountDetails = AccountDetail;
    [AccountDetail backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:AccountDetail];
    [AccountDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(setting.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    //TODO: 我的积分
    UIButton *mycredits = [[UIButton alloc] init];
    _myCredits = mycredits;
    [mycredits backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:mycredits];
    [mycredits mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AccountDetail.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
//    //TODO: 我的钱包
//    UIButton *myWallet = [[UIButton alloc] init];
//    _myWallet = myWallet;
//    [myWallet backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
//    [contentView addSubview:myWallet];
//    [myWallet mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(mycredits.mas_bottom).offset(20);
//        make.left.right.equalTo(contentView);
//        make.height.mas_equalTo(40);
//    }];
    
    //TODO: 我的订单
    UIButton *myOrders = [[UIButton alloc] init];
    _myOrders = myOrders;
    [myOrders backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:myOrders];
    [myOrders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mycredits.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    //TODO: 帮助
    UIButton *support = [[UIButton alloc] init];
    _support = support;
    [support backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:support];
    [support mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myOrders.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    //TODO: 登出
    UIButton *logOut = [[UIButton alloc] init];
    _logOut = logOut;
    [logOut backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:logOut];
    [logOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(support.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
}

/**
 颜色设置
 */
- (void)setupColor{
    self.view.backgroundColor = Pax_Bg_Grey;
    for (id sub in self.contentView.subviews) {
        if ([sub class] == [UIButton class]) {
            UIButton *subBtn = (UIButton *)sub;
            [subBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
        }
    }
}

/**
 字体设置
 */
- (void)setupFont
{
    for (id sub in self.contentView.subviews) {
        if ([sub class] == [UIButton class]) {
            UIButton *subBtn = (UIButton *)sub;
            subBtn.titleLabel.font = Pax_Font_Button;
        }
    }
}

/**
 内容设置
 */
- (void)setupText
{
    self.navigationItem.title = PaxMine;
    [_setting setTitle:PaxSetting forState:UIControlStateNormal];
    [_accountDetails setTitle:PaxAccountDetail forState:UIControlStateNormal];
    [_myCredits setTitle:PaxMyCredits forState:UIControlStateNormal];
    [_myWallet setTitle:PaxMyWallet forState:UIControlStateNormal];
    [_myOrders  setTitle:PaxMyOrders forState:UIControlStateNormal];
    [_support setTitle:PaxSupport forState:UIControlStateNormal];
    [_logOut setTitle:PaxLogOut forState:UIControlStateNormal];
}

/**
 事件绑定
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_setting rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        PaxSettingViewController *setVc = [[PaxSettingViewController alloc]init];
        setVc.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:setVc animated:true];
    }];
    
    [[_accountDetails rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PaxMyAccountViewController *myac = [[PaxMyAccountViewController alloc]init];
        myac.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:myac animated:true];
    }];
    [[_support rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PaxSpeakWithUsViewController *speak = [[PaxSpeakWithUsViewController alloc]init];
        speak.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:speak animated:true];
    }];
    
    [[_logOut rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [Weakself networkRequest];
       
    }];
    
    [[_myOrders rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxMyOrderListViewController *order = [[PaxMyOrderListViewController alloc]init];
        order.navText = PaxMyOrders;
        order.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:order animated:true];
    }];
    
    [[_myCredits rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxCreditsViewController *credits = [[PaxCreditsViewController alloc]init];
        [Weakself.navigationController pushViewController:credits animated:true];
    }];
    
    [[_myWallet rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
    }];
}

- (void)networkRequest
{
    [[LXLNetWorkTool shareTools] Pax_logOutWithTipMessage:@"正在推出登陆,请稍等..." Finish:^(id responseObject, NSError *error) {
        PaxLoginViewController *login = [[PaxLoginViewController alloc]init];
        
        
        PaxMainBaseNavController *nav = [[PaxMainBaseNavController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }];
}
@end
