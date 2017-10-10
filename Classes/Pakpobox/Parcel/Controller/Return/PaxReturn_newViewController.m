//
//  PaxReturn_newViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxReturn_newViewController.h"
#import "PaxReturnOrderInformationViewController.h"
#import "PaxSelectMapViewController.h"
#import "PaxNearbyModel.h"
@interface PaxReturn_newViewController ()

@property (weak, nonatomic) UIView *Return;/** 箱子对地址界面*/

@property (weak, nonatomic) UIButton *continueBtn;/**下一步按钮*/
@property (weak, nonatomic) UILabel *pleaseLabel; /**提示文字*/
@property (weak, nonatomic) UITextField *OrderText; /**运单号*/
@property (strong, nonatomic) PaxNearbyModel *lockerModel;
@property (strong, nonatomic) NSString *mouthSize;
@end

@implementation PaxReturn_newViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navText = PaxReturn;
    
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
    self.view.backgroundColor = [UIColor cz_colorWithRed:246 green:246 blue:246 ];
    UIView *Return = [[UIView alloc]init];
    _Return = Return;
    [self.view addSubview:Return];
    LXLWeakSelf(self);
    [Return mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(64);
        make.left.right.bottom.equalTo(Weakself.view);
    }];
    UIImageView *top = [[UIImageView alloc]init];
    [Return addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Return).offset(20);
        make.left.right.equalTo(Return);
        make.height.mas_equalTo(200);
    }];
    top.contentMode = UIViewContentModeScaleAspectFit;
    top.image = [UIImage imageNamed:@"snap2"];
    
    
    UIView *contentView = [[UIView alloc]init];
    [Return addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Return).offset(250);
        make.centerX.equalTo(Return);
        make.left.equalTo(Return);
        make.bottom.equalTo(Return);
    }];
    contentView.backgroundColor = [UIColor cz_colorWithRed:246 green:246 blue:246];
    
    //TODO: Locker
    UIView *Locker = [self setupLeftButtonAndRightTextViewLeftlabel:PaxLocker andRightPlaceholder:PaxShowNearestPakpoboxLocker andIsHiddenImage:false clickRightView:@selector(clickLocker:)];
    [contentView addSubview:Locker];
    [Locker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(contentView);
        make.height.equalTo(@(40));
    }];
    //TODO: Door Size
    UIView *DoorSize = [self setupLeftButtonAndRightTextViewLeftlabel:PaxDoorSize andRightPlaceholder:PaxSmall391mm450mm120mm andIsHiddenImage:false clickRightView:@selector(clickBox:)];
    [contentView addSubview:DoorSize];
    [DoorSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(Locker.mas_bottom).offset(15);
        make.height.equalTo(@(40));
    }];
    //TODO: Please input order#
    UILabel *pleaseLabel = [[UILabel alloc]init];
    _pleaseLabel = pleaseLabel;
    
    [contentView addSubview:pleaseLabel];
    [pleaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DoorSize.mas_bottom);
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.height.equalTo(@(25));
    }];
    
    UIView *textContent = [[UIView alloc]init];
    
    [contentView addSubview:textContent];
    [textContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pleaseLabel.mas_bottom);
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.height.equalTo(@(40));
    }];
    UITextField *textfield = [[UITextField alloc]init];
    _OrderText = textfield;
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    [textfield backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    textfield.placeholder = PaxOrderpreregistration;
    [textContent addSubview:textfield];
    [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(textContent);
        make.left.equalTo(textContent).offset(5);
    }];
    
    //TODO: 下一步按钮
    UIButton *continueBtn = [[UIButton alloc]init];
    _continueBtn = continueBtn;
    [continueBtn backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    
    [contentView addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textContent.mas_bottom).offset(15);
//        make.bottom.equalTo(contentView);
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView).offset(24);
//        make.width.equalTo(@(120));
        make.height.mas_equalTo(50);
    }];

}



/**
 事件绑定
 */
- (void)rac_event{
    LXLWeakSelf(self);
    
    
    //TODO: 下一步按钮
    [[_continueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [Weakself networkRequest];
    }];
    
}


/**
 网络请求
 */
- (void)networkRequest{
    
    LXLWeakSelf(self);
    [self.view endEditing:true];
    
    if (_lockerModel == nil || _mouthSize == nil) {
        [PaxHUD Pax_showErrorWithStatus:PaxPleaseselectsavecollectbox];
        return;
    }
    
    [[LXLNetWorkTool shareTools] Pax_CreateReturnExpressOrderWithTipMessage:PaxPleasewaitamomentLoad locker:@{@"id": _lockerModel.nearbyId == nil? @"": _lockerModel.nearbyId} expressNumber:_OrderText.text mouthSize:_mouthSize == nil?@"":_mouthSize Finish:^(id responseObject, NSError *error) {
        PaxReturnOrderInformationViewController *reurnVc = [[PaxReturnOrderInformationViewController alloc]init];
        reurnVc.responseObject = responseObject;
        [Weakself.navigationController pushViewController:reurnVc animated:true];
    }];
}

/**
 设置颜色
 */
- (void)setupColor
{
    

    _continueBtn.backgroundColor = Pax_White;
    
    _pleaseLabel.textColor = Pax_Black;
    _OrderText.textColor = Pax_Black;
}

/**
 设置字体
 */
- (void)setupFont
{

    _continueBtn.titleLabel.font = Pax_Font_Button;
    _pleaseLabel.font = Pax_Font_Text;
    _OrderText.font = Pax_Font_H3;
    
}

/**
 设置文字
 */
- (void)setupText
{

    [_continueBtn setTitle:PaxContinue forState:UIControlStateNormal];
    [_continueBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
    _pleaseLabel.text = PaxPleaseinputorder;
}


#pragma mark - 用于基本元素设计
- (UIView *)setupLeftButtonAndRightTextViewLeftlabel:(NSString *)title andRightPlaceholder:(NSString *)placeholder andIsHiddenImage:(BOOL)isHidden clickRightView:(SEL)clickFuncation{
    UIView *content = [[UIView alloc]init];
    
    //TODO: 左边view的设计
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = Pax_White;
    leftView.layer.cornerRadius = 5;
    leftView.layer.masksToBounds = true;
    [content addSubview:leftView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(content);
        make.width.equalTo(@(80));
    }];
    UILabel *label = [[UILabel alloc]init];
    [leftView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(leftView);
        
    }];
    label.text = title;
    label.font = Pax_Font_H3;
    label.textAlignment = NSTextAlignmentCenter;
    //TODO: 右边view的设计
    UIView *rightView = [[UIView alloc]init];
    [rightView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    
    [content addSubview:rightView];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(content);
        make.left.equalTo(leftView.mas_right).offset(10);
    }];
    UITextField *textfiled = [[UITextField alloc]init];
    [rightView addSubview:textfiled];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.equalTo(rightView);
        make.left.equalTo(rightView).offset(3);
    }];
    textfiled.placeholder = placeholder;
    textfiled.font = Pax_Font_H3;
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    selectImage.image = [UIImage imageNamed:@"img_jlcx_xl_sanjiao"];
    selectImage.contentMode = UIViewContentModeCenter;
    [content addSubview: selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(content);
        make.width.equalTo(@(50));
    }];
    selectImage.hidden = isHidden;
    textfiled.userInteractionEnabled = isHidden;
    if (!isHidden) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:clickFuncation];
        [rightView addGestureRecognizer:tap];
    }
    return content;
}
#pragma mark - clickRight
- (void)clickLocker:(UITapGestureRecognizer *)tap;
{
    [self.view endEditing:true];
    UITextField *textField;
    for (id sub in tap.view.subviews) {
        if ([sub class] == [UITextField class]) {
            textField = (UITextField *)sub;
        }
    }
    PaxSelectMapViewController *selectMap = [[PaxSelectMapViewController alloc]init];
    selectMap.selectLoction = ^(PaxNearbyModel *model) {
        textField.text = model.name;
        _lockerModel = model;
    };
    [self.navigationController pushViewController:selectMap animated:true];
}

- (void)clickBox:(UITapGestureRecognizer*)tap{
    
    [self.view endEditing:true];
    UITextField *textField;
    for (id sub in tap.view.subviews) {
        if ([sub class] == [UITextField class]) {
            textField = (UITextField *)sub;
        }
    }

    UIAlertController *aler = [UIAlertController alertControllerWithTitle:PaxPleaseselectasuitablebox message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [aler addAction:[UIAlertAction actionWithTitle:PaxSmallDimensions style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        textField.text = PaxSmallDimensions;
        _mouthSize = @"S";
    }]];
    [aler addAction:[UIAlertAction actionWithTitle:PaxMediumDimensions  style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        textField.text = PaxMediumDimensions;
        _mouthSize = @"M";
    }]];
    [aler addAction:[UIAlertAction actionWithTitle:PaxLargeDimensions style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        textField.text = PaxLargeDimensions;
        _mouthSize = @"L";
    }]];
    
    [self presentViewController:aler animated:true completion:nil];
}
@end
