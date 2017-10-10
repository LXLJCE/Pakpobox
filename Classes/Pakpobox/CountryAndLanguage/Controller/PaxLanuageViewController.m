//
//  PaxViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxLanuageViewController.h"
#import "PaxLoginViewController.h"
@interface PaxLanuageViewController ()
@property (weak, nonatomic) UIView *lanuageView;
@property (weak, nonatomic) UILabel *lanuageLabel;
@property (weak, nonatomic) UILabel *countryLabel;
@property (weak, nonatomic) UIButton *continueBtn;
@end

@implementation PaxLanuageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Pax_Bg_Grey;
    [self setupBaseUI];
    [self rac_event];
    [self setupFont];
    [self setupColor];
}

// MARK: -初始化页面
- (void)setupBaseUI
{
    
    UIImageView *bgImage = [[UIImageView alloc]init];
    [self.view addSubview:bgImage];
    bgImage.frame = CGRectMake(0, 40, ScreenWidth, 130);
    bgImage.image = [UIImage imageNamed:@"snap6"];
    bgImage.contentMode = UIViewContentModeScaleToFill;
    
    LXLWeakSelf(self);
    // contentView
    
    
    UIImageView *top = [[UIImageView alloc]init];
    top.image = [UIImage imageNamed:@"snap5"];
    [self.view addSubview:top];
    
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImage.mas_bottom);
        make.centerX.equalTo(Weakself.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(200);
    }];
    
    
    UIView *contentView = [[UIView alloc]init];
//    contentView.backgroundColor = [UIColor cz_randomColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top.mas_bottom).offset(0);
        make.centerX.equalTo(Weakself.view);
        make.height.equalTo(@(100));
//        make.width.mas_equalTo(328);
        make.left.equalTo(Weakself.view).offset(24);
    }];
    
    
    // 选择语言
    
    UIView *lanuage = [self selectorViewWithTitle:PaxLanuage];
    [contentView addSubview:lanuage];
    [lanuage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView).offset(3);
        make.right.equalTo(contentView);
        make.height.equalTo(@(40));
    }];
    self.lanuageView = lanuage;
    UITapGestureRecognizer *tapLa = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLanuage:)];
    [lanuage addGestureRecognizer:tapLa];
    
    // 选择国家
    
    UIView *country = [self selectorViewWithTitle:PaxCountry];
    [contentView addSubview:country];
    [country mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.bottom.equalTo(contentView).offset(-3);
        make.right.equalTo(contentView);
        make.height.equalTo(@(40));
    }];
    
    UITapGestureRecognizer *tapCo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCountry:)];
    [country addGestureRecognizer:tapCo];
    
    // 下一步
    UIButton *continueBtn = [[UIButton alloc]init];
    self.continueBtn = continueBtn;
    [continueBtn setTitle:PaxContinue forState:UIControlStateNormal];
    [continueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Weakself.view);
        make.bottom.equalTo(Weakself.view).offset(-50);
//        make.width.mas_equalTo(328);
        make.left.equalTo(Weakself.view).offset(24);
        make.height.mas_equalTo(50);
    }];
    
    [continueBtn backColor:Pax_TineColor cornerRadius:25 borderColor:[UIColor clearColor] borderWidth:1 isShadow:false];
    
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
    
    [selectorView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    
    return selectorView;
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
    _lanuageLabel = titleLabel;
    NSArray *items = @[PaxEnglish, PaxChinese];
    [self setupAlertControllerWithTitle:PaxLanuage andItems:items WithTap:tap];
    
    
}

/**
 点击选择国家
 */
- (void)clickCountry:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    UILabel *titleLabel;
    for (UIView *subview in view.subviews) {
        if (subview.class == [UILabel class]) {
            titleLabel = (UILabel *)subview;
            self.countryLabel = titleLabel;
        }
    }
    
    
    NSArray *items = @[PaxHongKong, PaxTaiwan, PaxMalaysia];
    [self setupAlertControllerWithTitle:PaxCountry andItems:items WithTap:tap] ;

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
            
            if (tap.view == self.lanuageView) {
                if ([item isEqualToString:PaxEnglish]) {
                    [PaxInternationalControl setUserlanguage:@"en"];
                    titleLabel.text = PaxEnglish;
                    [PaxDataSave saveLanguage:PaxEnglish];
                    
                }else{
                    [PaxInternationalControl setUserlanguage:@"zh-Hans-CN"];
                    titleLabel.text = PaxChinese;
                    [PaxDataSave saveLanguage:PaxChinese];
                }
                self.countryLabel.text = PaxCountry;
                
            }else{
                [PaxDataSave saveCountry:item];
            }
        }];
        [alert addAction:action];
    }
    
   
    [alert addAction: [UIAlertAction actionWithTitle:PaxCancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

/**
 对于事件
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    if (_lanuageLabel!= nil && _lanuageLabel.text != PaxLanuage) {
        [PaxDataSave saveLanguage:_lanuageLabel.text];
    }
    if (_countryLabel!= nil &&_countryLabel.text != PaxCountry) {
        [PaxDataSave saveCountry:_countryLabel.text];
    }
    
    [[self.continueBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        PaxLoginViewController *login = [[PaxLoginViewController alloc]init];
        PaxMainBaseNavController *nav = [[PaxMainBaseNavController alloc]initWithRootViewController:login];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }];
}

/**
 生命周期
 */
- (void)dealloc{
    PaxLog(@"%@",@"死了");
}

- (void)setupColor
{
    _continueBtn.backgroundColor = Pax_Color_Lanuage_Btn_Back;
    [_continueBtn setTitleColor:Pax_Color_Lanuage_Btn_Title forState:UIControlStateNormal];
   
    
}

- (void)setupFont
{
    _continueBtn.titleLabel.font = Pax_Font_Lanuage_Btn;
}
@end
