//
//  PaxSpeakWithUsViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSpeakWithUsViewController.h"
#import "PaxBaseHelpViewController.h"
#import "PaxReportAProblemViewController.h"
@interface PaxSpeakWithUsViewController ()
@property (weak, nonatomic) UIView *contentView;

@property (weak, nonatomic) UIButton *HowItWorks;
@property (weak, nonatomic) UIButton *FAQ;
@property (weak, nonatomic) UIButton *Terms;
@property (weak, nonatomic) UIButton *Privacy;
@property (weak, nonatomic) UIButton *speaks;
@end

@implementation PaxSpeakWithUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self setupText];
    [self rac_event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置UI
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 容器视图
    UIView *contentView = [[UIView alloc]init];
    _contentView = contentView;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(24);
        make.height.equalTo(@(240));
    }];
    
    
    //TODO: how it works
    _HowItWorks = [self setupUnitView];
    [contentView addSubview:_HowItWorks];
    [_HowItWorks mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.equalTo(@(40));
    }];
    
    //TODO: FAQ
    _FAQ = [self setupUnitView];
    [contentView addSubview:_FAQ];
    [_FAQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(_HowItWorks.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    //TODO: Terms
    _Terms = [self setupUnitView];
    [contentView addSubview:_Terms];
    [_Terms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(_FAQ.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    //TODO: Privacy
    _Privacy = [self setupUnitView];
    [contentView addSubview:_Privacy];
    [_Privacy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(_Terms.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    
    //TODO: Speak
    _speaks = [self setupUnitView];
    [contentView addSubview:_speaks];
    [_speaks mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(_Privacy.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    
}

- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    for (id subview in _contentView.subviews) {
        if ([subview class] == [UIButton class]) {
            UIButton *sub = (UIButton *)subview;
            [sub setTitleColor:Pax_Black forState:UIControlStateNormal];
        }
    }
}

- (void)setupFont
{
    for (id subview in _contentView.subviews) {
        if ([subview class] == [UIButton class]) {
            UIButton *sub = (UIButton *)subview;
            sub.titleLabel.font = Pax_Font_Button;
        }
    }
}

- (void)setupText
{
    self.navText = PaxSpeakwithus;
    [_HowItWorks setTitle:PaxHowitworks forState:UIControlStateNormal];
    [_FAQ setTitle:PaxFAQ forState:UIControlStateNormal];
    [_Terms setTitle:PaxTermsConditionofService forState:UIControlStateNormal];
    [_Privacy setTitle:PaxPrivacyofService forState:UIControlStateNormal];
    [_speaks setTitle:PaxSpeakwithus forState:UIControlStateNormal];
}

- (void)rac_event
{
    LXLWeakSelf(self);
    //TODO: 运营按钮
    [[_HowItWorks rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxBaseHelpViewController *howVc = [[PaxBaseHelpViewController alloc]init];
        howVc.navText = PaxHowitworks;
        [howVc setupTextWith:@"1.0 Apps cannot transmit data about a user without obtaining the user's prior permission and providing the user with access to information about how and where the data will be used\n1.1 Apps that require users to share personal information,such as email address and date of birth, in order to function will be rejected\n1.2 Apps may ask for date of birth (or use other age-gating mechanisms) only for the purpose of complying with applicable children's privacy statutes, but must include some useful functionality or entertainment value re 9 ardless of the user's age\n1.3 Apps that collect, transmit, or have the capability to share personal information (e.g. name, address, email, location,photos, videos, drawings, the ability to chat, other personal data, or persistent identifiers used in combination with any of the above) from a minor must comply with applicable children's privacy statutes, and must include a privacy policy\n1.4 Apps that include account registration or access a user's existing account must include a privacy policy or they will be rejected"];
        [Weakself.navigationController pushViewController:howVc animated:true];
    }];
    //TODO: FAQ 按钮
    [[_FAQ rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxBaseHelpViewController *faqVc = [[PaxBaseHelpViewController alloc]init];
        faqVc.navText = PaxFAQ;
        [faqVc setupTextWith:@"1.0 Apps cannot transmit data about a user without obtaining the user's prior permission and providing the user with access to information about how and where the data will be used\n1.1 Apps that require users to share personal information,such as email address and date of birth, in order to function will be rejected\n1.2 Apps may ask for date of birth (or use other age-gating mechanisms) only for the purpose of complying with applicable children's privacy statutes, but must include some useful functionality or entertainment value re 9 ardless of the user's age\n1.3 Apps that collect, transmit, or have the capability to share personal information (e.g. name, address, email, location,photos, videos, drawings, the ability to chat, other personal data, or persistent identifiers used in combination with any of the above) from a minor must comply with applicable children's privacy statutes, and must include a privacy policy\n1.4 Apps that include account registration or access a user's existing account must include a privacy policy or they will be rejected"];
        [Weakself.navigationController pushViewController:faqVc animated:true];
    }];
    //TODO: Terms 按钮
    [[_Terms rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxBaseHelpViewController *termsVc = [[PaxBaseHelpViewController alloc]init];
        termsVc.navText = PaxTermsConditionofService;
        [termsVc setupTextWith:@"1.0 Apps cannot transmit data about a user without obtaining the user's prior permission and providing the user with access to information about how and where the data will be used\n1.1 Apps that require users to share personal information,such as email address and date of birth, in order to function will be rejected\n1.2 Apps may ask for date of birth (or use other age-gating mechanisms) only for the purpose of complying with applicable children's privacy statutes, but must include some useful functionality or entertainment value re 9 ardless of the user's age\n1.3 Apps that collect, transmit, or have the capability to share personal information (e.g. name, address, email, location,photos, videos, drawings, the ability to chat, other personal data, or persistent identifiers used in combination with any of the above) from a minor must comply with applicable children's privacy statutes, and must include a privacy policy\n1.4 Apps that include account registration or access a user's existing account must include a privacy policy or they will be rejected"];
        [Weakself.navigationController pushViewController:termsVc animated:true];
    }];
    
    //TODO: Privacy 按钮
    [[_Privacy rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxBaseHelpViewController *privacyVc = [[PaxBaseHelpViewController alloc]init];
        privacyVc.navText = PaxPrivacyofService;
        [privacyVc setupTextWith:@"1.0 Apps cannot transmit data about a user without obtaining the user's prior permission and providing the user with access to information about how and where the data will be used\n1.1 Apps that require users to share personal information,such as email address and date of birth, in order to function will be rejected\n1.2 Apps may ask for date of birth (or use other age-gating mechanisms) only for the purpose of complying with applicable children's privacy statutes, but must include some useful functionality or entertainment value re 9 ardless of the user's age\n1.3 Apps that collect, transmit, or have the capability to share personal information (e.g. name, address, email, location,photos, videos, drawings, the ability to chat, other personal data, or persistent identifiers used in combination with any of the above) from a minor must comply with applicable children's privacy statutes, and must include a privacy policy\n1.4 Apps that include account registration or access a user's existing account must include a privacy policy or they will be rejected"];
        [Weakself.navigationController pushViewController:privacyVc animated:true];
    }];
    
    //TODO: Speak 按钮
    [[_speaks rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxReportAProblemViewController *speaksVc = [[PaxReportAProblemViewController alloc]init];
        speaksVc.navText = PaxSpeakwithus;
        
        [Weakself.navigationController pushViewController:speaksVc animated:true];
    }];
}

/**
 单元控件
 */
- (UIButton *)setupUnitView
{
    //TODO: 容器
    UIButton *contentView = [[UIButton alloc]init];
    [contentView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [contentView setTitleColor:Pax_Black forState:UIControlStateNormal];
    return contentView;
}
@end
