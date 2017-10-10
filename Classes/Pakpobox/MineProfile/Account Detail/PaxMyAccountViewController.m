//
//  PaxMyAccountViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/40.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyAccountViewController.h"
#import "PaxChangePasswordViewController.h"
#import "PaxCreditsViewController.h"
#import "PaxSelectMapViewController.h"
#import "PaxNearbyModel.h"


@interface PaxMyAccountViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) PaxNearbyModel *location_model;

@property (weak, nonatomic) UILabel *username;
@property (weak, nonatomic) UILabel *email;
@property (weak, nonatomic) UILabel *telephone;
@property (weak ,nonatomic) UIView *select_locker;
@property (weak, nonatomic) UIButton *credits;
@property (weak, nonatomic) UIButton *ChangePassword;


@property (weak, nonatomic) UIView *cover;
@property (weak, nonatomic) UIView *boxView;
@property (weak, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSMutableArray *pickerArr;


@property (weak, nonatomic) UIButton *cancelBtn;
@property (weak, nonatomic) UIButton *sureBtn;

@property (weak, nonatomic) NSString *selectText;
@end

@implementation PaxMyAccountViewController

- (NSMutableArray *)pickerArr
{
    if(_pickerArr == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _pickerArr = model;
    }
    return _pickerArr;
}

/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navText = PaxMYACCOUNT;
    self.pickerArr = [NSMutableArray arrayWithObjects:@"One",@"Two",@"Three",@"One",@"Two",@"Three",@"One",@"Two",@"Three",@"One",@"Two",@"Three",@"One",@"Two",@"Three",@"One",@"Two",@"Three",@"One",@"Two",@"Three", nil];
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self setupText];
    [self rac_event];
    [self networkRequest];
    
   
}


/**
 基本元素设置
 */
- (UIView *)setupUnit:(SEL)clickView
{
    UIView *contentView = [[UIView alloc]init];
    UILabel *titleLabel = [[UILabel alloc]init];
    contentView.userInteractionEnabled = true;
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
    contentView.userInteractionEnabled = true;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(24);
        make.height.mas_equalTo(300);
    }];
    //TODO: username
    UILabel *userName = [[UILabel alloc]init];
    userName.textAlignment = NSTextAlignmentCenter;
    _username = userName;
    [userName backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(0);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    //TODO: email
    UILabel *email = [[UILabel alloc]init];
    email.textAlignment = NSTextAlignmentCenter;
    _email = email;
    [email backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:email];
    [email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(userName.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    //TODO: telephone
    UILabel *telephone = [[UILabel alloc]init];
    telephone.textAlignment = NSTextAlignmentCenter;
    _telephone = telephone;
    [telephone backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:telephone];
    [telephone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(email.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    //TODO: locker
    UIView *select_locker = [self setupUnit:@selector(clickSelectLocker)];
    _select_locker = select_locker;
    [select_locker backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:select_locker];
    [select_locker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(telephone.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    //TODO: credits
    UIButton *credits = [[UIButton alloc]init];
    credits.titleLabel.textAlignment = NSTextAlignmentCenter;
    _credits = credits;
    [credits backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:credits];
    [credits mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(select_locker.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    //TODO: telephone
    UIButton *changePassword = [[UIButton alloc]init];
    changePassword.titleLabel.textAlignment = NSTextAlignmentCenter;
    _ChangePassword = changePassword;
    [changePassword backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [contentView addSubview:changePassword];
    [changePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(credits.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    
    UIView *cover = [[UIView alloc]init];
    _cover = cover;
    cover.frame = self.view.bounds;
    cover.alpha = 0.0;
    cover.backgroundColor = Pax_Black;
    [self.view addSubview:cover];
    
    UIView *boxview = [[UIView alloc]init];
    [self.view addSubview:boxview];
    [boxview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view.mas_bottom);
        make.left.equalTo(Weakself.view).offset(10);
        make.right.equalTo(Weakself.view).offset(-10);
        make.height.mas_offset(35);
    }];
    _boxView = boxview;
    UIButton *cancelBtn = [[UIButton alloc]init];
    _cancelBtn = cancelBtn;
    [boxview addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(boxview);
        make.width.mas_equalTo(120);
    }];
    UIButton *sureBtn = [[UIButton alloc]init];
    _sureBtn = sureBtn;
    [boxview addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(boxview);
        make.width.mas_equalTo(120);
    }];
    [_boxView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    
    
    
    _boxView = boxview;
    UIPickerView *picker = [[UIPickerView alloc]init];
    [self.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(boxview.mas_bottom).offset(5);
        make.right.equalTo(Weakself.view).offset(-10);
        make.left.equalTo(Weakself.view).offset(10);
        make.height.mas_offset(150);
    }];
    _picker = picker;
    [picker backColor:Pax_Border_Grey cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    picker.delegate = self;
    picker.dataSource = self;
    
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
    _cancelBtn.titleLabel.font = Pax_Font_Text;
    _sureBtn.titleLabel.font = Pax_Font_Text;
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
    
    [_cancelBtn setTitleColor:Pax_Red forState:UIControlStateNormal];
    [_sureBtn setTitleColor:Pax_TineColor forState:UIControlStateNormal];
    _boxView.backgroundColor = [UIColor whiteColor];
}

/**
 内容
 */
- (void)setupText
{
//    NSDictionary *user = [PaxDataSave getUserMessage];
    
    _username.text = PaxName;
    _email.text = PaxEmail;
    _telephone.text = PaxTelephone;
    for (id sub in _select_locker.subviews) {
        if ([sub class] == [UILabel class]) {
            UILabel *subLabel = (UILabel *)sub;
            subLabel.text = PaxSAVED;
        }
    }
    [_credits setTitle:PaxMyCredits forState:UIControlStateNormal];
    [_ChangePassword setTitle:PaxChangePassword forState:UIControlStateNormal];
    
    [_cancelBtn setTitle:PaxCancel forState:UIControlStateNormal];
    [_sureBtn setTitle:PaxSure forState:UIControlStateNormal];
}

/**
 事件绑定
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    

    [[_ChangePassword rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxChangePasswordViewController *changVc = [[PaxChangePasswordViewController alloc]init];
        [Weakself.navigationController pushViewController:changVc animated:true];
    }];
    
    [[_credits rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
//        [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
        PaxCreditsViewController *credits = [[PaxCreditsViewController alloc]init];
        [Weakself.navigationController pushViewController:credits animated:true];
    }];
    
    [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        for (id sub in _select_locker.subviews) {
            if ([sub class] == [UILabel class]) {
                UILabel *subLabel = (UILabel *)sub;
                if (_selectText != nil && ![_selectText isEqualToString:@""]) {
                    subLabel.text = _selectText;
                }else{
                    subLabel.text = Weakself.pickerArr.firstObject;
                }
                
            }
        }
        
        [Weakself hiddenPicker];
    }];
    
    [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself hiddenPicker];
    }];
}

- (void)clickSelectLocker
{
//    [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
    
//    [self showPicker];
    
    PaxSelectMapViewController *mapView = [[PaxSelectMapViewController alloc]init];
    
    LXLWeakSelf(self);
    mapView.selectLoction = ^(PaxNearbyModel *model) {
       
        [Weakself networkRequestSaveLocker:model];
    };
    
    [Weakself.navigationController pushViewController:mapView animated:true];
    
    
}

- (void)networkRequestSaveLocker:(PaxNearbyModel *)model
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools]Pax_SetPreferredBoxTipMessage:PaxPleasewaitamomentLoad preferredBox:@{@"id":model.nearbyId} Finish:^(id responseObject, NSError *error) {
        
        [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
        for (id sub in Weakself.select_locker.subviews) {
            if ([sub class] == [UILabel class]) {
                UILabel *subLabel = (UILabel *)sub;
                subLabel.text = model.name;
            }
        }
    }];
}


- (void)showPicker
{
    LXLWeakSelf(self);
    
    [UIView animateWithDuration:0.25 animations:^{
        [_boxView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Weakself.view.mas_bottom).offset(-190);
        }];
        _cover.alpha = 0.5;  
        [self.view layoutIfNeeded];
    }];
}
- (void)hiddenPicker
{
    LXLWeakSelf(self);
    
    [UIView animateWithDuration:0.25 animations:^{
        [_boxView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Weakself.view.mas_bottom).offset(0);
        }];
        _cover.alpha = 0.0;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - PickerDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectText = self.pickerArr[row];
}

- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_AccountInfoWithTipMessage:PaxPleasewaitamomentLoad Finish:^(id responseObject, NSError *error) {
        
        
        
        Weakself.username.text = responseObject[@"name"] == nil ? PaxName : responseObject[@"name"];
        Weakself.email.text = responseObject[@"email"] == nil ? PaxEmail :responseObject[@"email"];
        Weakself.telephone.text = responseObject[@"phoneNumber"] == nil? PaxTelephone : responseObject[@"phoneNumber"];
        
    }];
}
@end
