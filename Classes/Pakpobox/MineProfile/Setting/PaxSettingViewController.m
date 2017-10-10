//
//  PaxSettingViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/5.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSettingViewController.h"
#import "PaxLoginViewController.h"
#import "PaxMainViewController.h"
@interface PaxSettingViewController ()
@property (weak, nonatomic) UISwitch *location;
@property (weak, nonatomic) UISwitch *app_notification;
@property (weak, nonatomic) UISwitch *email_notification;
@property (weak, nonatomic) UISwitch *sms_notification;
@property (weak, nonatomic) UIView *lanuage;

@property (strong, nonatomic) NSString *currentLanuage;



@property (strong, nonatomic) NSArray *orinagl_setting;
@end

@implementation PaxSettingViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self setupText];
    [self rac_event];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterForeground) name:@"EnterForeground" object:nil];
}
- (void)EnterForeground
{
    [self setAuthor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setAuthor];
    
    UILabel *lan;
    for (id sub in self.lanuage.subviews) {
        if ([sub class] == [UILabel class]) {
            lan = (UILabel *)sub;
        }
    }
    _orinagl_setting = @[@(_location.on),@(_app_notification.on),@(_email_notification.on),@(_sms_notification.on),lan.text];
    
    
}

/**
 设置授权
 */
- (void)setAuthor{
    if ([self locationAuthor]) {
        _location.on = true;
    }else{
        _location.on = false;
    }
    
    if ([self notificationAuthor]) {
        _app_notification.on = true;
    }else{
        _app_notification.on = false;
    }
    _email_notification.on = true;
    _sms_notification.on = true;
}

- (BOOL)locationAuthor
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        return true;
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        return false;
    }else{
        return false;
    }
}

- (BOOL)notificationAuthor
{
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
        return false;
    }else{
        return true;
    }
}
/**
 界面设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 设置内容界面
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview: contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center .equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(24);
        make.height.mas_equalTo(250);
    }];
    //TODO: location
    UIView *location = [self setupUnit:PaxLocation andSel:@selector(clickLocation:)];
    [contentView addSubview:location];
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    //TODO: App
    UIView *appNotification = [self setupUnit:PaxAppNotification andSel:@selector(clickAppNotification:)];
    [contentView addSubview:appNotification];
    [appNotification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(location.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    //TODO: email
    UIView *emailNotification = [self setupUnit:PaxEmailNotification andSel:@selector(clickEmailNotification:)];
    [contentView addSubview:emailNotification];
    [emailNotification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(appNotification.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    //TODO: sms
    UIView *SMSNotification = [self setupUnit:PaxSMSNotification andSel:@selector(clickSMSNotification:)];
    [contentView addSubview:SMSNotification];
    [SMSNotification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(emailNotification.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    //TODO: Lanuage
    NSString *currentLanuage = [PaxInternationalControl userLanguage];
    
    _currentLanuage = currentLanuage;
    NSString *lanuageCurrent;
    if ([currentLanuage  isEqual: @"en"]) {
        lanuageCurrent = PaxEnglish;
    }else{
        lanuageCurrent = PaxChinese;
    }
    UIView *lanuage = [self selectorViewWithTitle:lanuageCurrent];
    [contentView addSubview:lanuage];
    [lanuage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(SMSNotification.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    self.lanuage = lanuage;
    UITapGestureRecognizer *tapLa = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLanuage:)];
    [lanuage addGestureRecognizer:tapLa];
}


/**
 颜色设置
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
}

/**
 字体设置
 */
- (void)setupFont
{

}


/**
 内容设置
 */
- (void)setupText
{
    self.navText = PaxSetting;
}


/**
 绑定事件
 */
- (void)rac_event
{

}


/**
 基本元素设置
 */
- (UIView *)setupUnit:(NSString *)leftTitle andSel:(SEL)action;
{
    UIView *contentView = [[UIView alloc]init];
    //TODO: 左边的label
    UILabel *leftLabel = [[UILabel alloc]init];
    [leftLabel backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = Pax_Font_Text;
    leftLabel.text = leftTitle;
    leftLabel.textColor = Pax_Black;
    [contentView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(contentView);
        make.right.equalTo(contentView).offset(-80);
    }];
    
    UIView *selectView = [[UIView alloc]init];
    [contentView addSubview:selectView];
    [selectView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow: true];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(contentView);
        make.width.mas_equalTo(80);
    }];
    UISwitch *select = [[UISwitch alloc]init];
    [selectView addSubview:select];
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(selectView);
        
    }];
    
    [select addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (leftTitle == PaxLocation) {
        _location = select;
    }else
    if (leftTitle == PaxAppNotification) {
        _app_notification = select;
    }else
    if (leftTitle == PaxEmailNotification) {
        _email_notification = select;
    }else
    if (leftTitle == PaxSMSNotification) {
        _sms_notification = select;
    }
    
    
    
    
    
    
    
    return contentView;
    
}

/**
 点击了location
 */
- (void)clickLocation:(UISwitch *)sender
{
    if (sender.on) {
        [PaxHUD Pax_showSuccessWithStatus:@"请到设置页面,勾选定位权限"];
        sender.on = false;
        
    }else{
        [PaxHUD Pax_showSuccessWithStatus:@"请到设置页面,取消定位权限"];
 
        sender.on = true;
    }
   
}
/**
 点击了App.Notification
 */
- (void)clickAppNotification:(UISwitch *)sender
{
    if (sender.on) {
        [PaxHUD Pax_showSuccessWithStatus:@"请到设置页面,勾选通知权限"];
        sender.on = false;
    }else{
        
         [PaxHUD Pax_showSuccessWithStatus:@"请到设置页面,取消通知权限"];
        sender.on = true;
    }
}
/**
 点击了EmailNotification
 */
- (void)clickEmailNotification:(UISwitch *)sender
{
    
}
/**
 点击了SMSNotification
 */
- (void)clickSMSNotification:(UISwitch *)sender
{
    
}


// MARK: - 事件方法

/**
 点击选择语言
 */
- (void)clickLanuage:(UITapGestureRecognizer *)tap
{
    
    UIView *view = tap.view;
    UILabel *titleLabel;
    for (UIView *subview in view.subviews) {
        if (subview.class == [UILabel class]) {
            titleLabel = (UILabel *)subview;
        }
    }
    NSArray *items = @[PaxEnglish, PaxChinese];
    [self setupAlertControllerWithTitle:PaxLanuage andItems:items WithTap:tap];
    
    
}
// MARK: - 对于弹框的描述

/**
 建立弹出框
 
 @param title 标题
 @param items 分类
 */
- (void)setupAlertControllerWithTitle:(NSString *)title andItems:(NSArray *)items WithTap:(UITapGestureRecognizer *)tap
{
    
    UIView *view = tap.view;
    UILabel *titleLabel;
    for (UIView *subview in view.subviews) {
        if (subview.class == [UILabel class]) {
            titleLabel = (UILabel *)subview;
        }
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *item in items) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:item style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            titleLabel.text = item;
            
                if ([item isEqualToString:PaxEnglish]) {
                    [PaxInternationalControl setUserlanguage:@"en"];
                    
                    
                }else{
                    [PaxInternationalControl setUserlanguage:@"zh-Hans-CN"];
                    titleLabel.text = PaxChinese;
                }
            if (![_currentLanuage isEqualToString:item]) {
               
                
                
                PaxLoginViewController *login = [[PaxLoginViewController alloc]init];
           
                
                PaxMainBaseNavController *nav = [[PaxMainBaseNavController alloc] initWithRootViewController:login];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            }
            
        }];
        [alert addAction:action];
    }
    
    
    [alert addAction: [UIAlertAction actionWithTitle:PaxCancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

// MARK: - 组件化

/**
 组件化 view
 
 @param title 文字
 @return 视图
 */
- (UIView *)selectorViewWithTitle:(NSString *)title
{
    UIView *selectorView = [[UIView alloc]init];
    selectorView.backgroundColor = Pax_Color_Lanuage_Label_back;
    UILabel *label = [[UILabel alloc]init];
    label.textColor = Pax_Color_Lanuage_Text;
    label.text = title;
    label.font = Pax_Font_Lanuage_Label;
    [label sizeToFit];
    [selectorView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(selectorView);
        make.left.equalTo(selectorView).offset(5);
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_jlcx_xl_sanjiao"]];
    imageView.contentMode = UIViewContentModeCenter;
    [selectorView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(selectorView);
        make.width.equalTo(@(50));
    }];
    
    [selectorView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    
    return selectorView;
}

/**
 生命周期方法
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 网络请求方法
 */
- (void)networkRequest
{
    LXLWeakSelf(self);
    
    UILabel *lan;
    for (id sub in self.lanuage.subviews) {
        if ([sub class] == [UILabel class]) {
            lan = (UILabel *)sub;
        }
    }
    
    NSArray *new_setting = @[@(_location.on),
                             @(_app_notification.on),
                             @(_email_notification.on),
                             @(_sms_notification.on),
                             lan.text];
    

    for (int i = 0; i < _orinagl_setting.count; i++) {
        if (_orinagl_setting[i] != new_setting[i]) {
            
            [[LXLNetWorkTool shareTools] Pax_settingWithTipMessage:@"正在设置,请稍后..." openLocation:_location.on openAppNotify:_app_notification.on openEmailNotify:_email_notification.on openSmsNotify:_sms_notification.on language:lan.text Finish:^(id responseObject, NSError *error) {
                [PaxHUD Pax_showSuccessWithStatus:@"设置成功"];
            }];
            break;
        }
    }

    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self networkRequest];
}
@end
