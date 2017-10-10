//
//  PaxParcelLockerToAddressViewController.m
//  Pakpobox
//
//  Created by 博兴 on 1517/3/23.
//  Copyright © 1517年 bx. All rights reserved.
//

#import "PaxParcelLockerToAddressViewController.h"
#import "PaxLockerSnapViewController.h"
#import "PaxSelectMapViewController.h"
#import "PaxNearbyModel.h"
#import "PaxParamter_CreateSender.h"
@interface PaxParcelLockerToAddressViewController ()

/**
 下一步按钮
 */
@property (weak, nonatomic) UIButton *continueBtn;

/**
 from
 */
@property (strong, nonatomic) PaxNearbyModel *fromModel;


/**
 name
 */
@property (weak, nonatomic) UITextField *name;

/**
 电话
 */
@property (weak, nonatomic) UITextField *phone;



/**
 地址信息
 */
@property (weak, nonatomic) UITextField *floor;
@property (weak, nonatomic) UITextField *street;
@property (weak, nonatomic) UITextField *city;

/**
 优惠卷
 */
@property (weak, nonatomic) UITextField *gift;

/**
 积分
 */
@property (weak, nonatomic) UITextField *credit;
@end

@implementation PaxParcelLockerToAddressViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navText = PaxLockerToAddress;
    [self setupUI]; /**基本UI*/
    [self setupFont];/**字体*/
    [self setupText];/**文字*/
    [self setupColor];/**颜色*/
    [self rac_event];/**事件*/
}


/**
 界面基本配置
 */
#pragma mark - 界面UI
- (void)setupUI{
    LXLWeakSelf(self);
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(Weakself.view);
        make.top.equalTo(Weakself.view).offset(100);
    }];
    
    
    //TODO: from
    UIView *from = [self setupLeftButtonAndRightTextViewLeftlabel:PaxFrom andRightPlaceholder:PaxShowNearestPakpoboxLocker andIsHiddenImage:false clickRightView:@selector(clickFrom:) andLeftViewIsHidden:false];
    [contentView addSubview:from];
    [from mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(contentView);
        make.height.equalTo(@(40));
    }];
    //TODO: to-name
    UIView *to = [self setupLeftButtonAndRightTextViewLeftlabel:PaxTo andRightPlaceholder:PaxRecieverName andIsHiddenImage:true clickRightView:nil andLeftViewIsHidden:false];
    [contentView addSubview:to];
    [to mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(from.mas_bottom).offset(15);
        make.height.equalTo(@(40));
    }];
    //TODO: to-mobile
    UIView *to_Mobile = [self setupLeftButtonAndRightTextViewLeftlabel:nil andRightPlaceholder:PaxReceiverMobile andIsHiddenImage:true clickRightView:nil andLeftViewIsHidden:true];
    [contentView addSubview:to_Mobile];
    [to_Mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(to.mas_bottom).offset(5);
        make.height.equalTo(@(40));
    }];
    //TODO: Address
    UIView *address_floor = [self setupLeftButtonAndRightTextViewLeftlabel:PaxAddress andRightPlaceholder:PaxFloorApartmentBuilding andIsHiddenImage:true clickRightView:nil andLeftViewIsHidden:false];
    [contentView addSubview:address_floor];
    [address_floor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(to_Mobile.mas_bottom).offset(15);
        make.height.equalTo(@(40));
    }];
    //TODO: Address
    UIView *address_street = [self setupLeftButtonAndRightTextViewLeftlabel:nil andRightPlaceholder:PaxStreet andIsHiddenImage:true clickRightView:nil andLeftViewIsHidden:true];
    [contentView addSubview:address_street];
    [address_street mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(address_floor.mas_bottom).offset(5);
        make.height.equalTo(@(40));
    }];
    //TODO: Address
    UIView *address_District = [self setupLeftButtonAndRightTextViewLeftlabel:nil andRightPlaceholder:PaxDistrictCity andIsHiddenImage:true clickRightView:nil andLeftViewIsHidden:true];
    [contentView addSubview:address_District];
    [address_District mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(address_street.mas_bottom).offset(5);
        make.height.equalTo(@(40));
    }];
    
    //TODO: 优惠券
    UIView *giftcode = [self setupLeftButtonAndRightTextViewLeftlabel:PaxCoupons andRightPlaceholder:PaxPleaseinputcouponcode andIsHiddenImage:true clickRightView:nil andLeftViewIsHidden:false];
    [contentView addSubview:giftcode];
    [giftcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(address_District.mas_bottom).offset(15);
        make.height.equalTo(@(40));
    }];
    
    //TODO: 积分
    UIView *credit = [self setupLeftButtonAndRightTextViewLeftlabel:PaxCredits andRightPlaceholder:PaxPleaseinputcreditsyouwant andIsHiddenImage:true clickRightView:nil andLeftViewIsHidden:false];
    [contentView addSubview:credit];
    [credit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
        make.top.equalTo(giftcode.mas_bottom).offset(15);
        make.height.equalTo(@(40));
    }];
    
    
    
    //TODO: 下一步
    UIButton *continueBtn = [[UIButton alloc]init];
    _continueBtn = continueBtn;
    [continueBtn backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    
    [contentView addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(credit.mas_bottom).offset(15);
//        make.bottom.equalTo(contentView);
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView).offset(16);
        make.height.mas_equalTo(40);
//        make.width.equalTo(@(115));
    }];
    
}
#pragma mark - 界面字体
- (void)setupFont
{
    _continueBtn.titleLabel.font = Pax_Font_Button;
}
#pragma mark - 界面颜色
- (void)setupColor{
    self.view.backgroundColor = Pax_Bg_Grey;
    _continueBtn.backgroundColor = Pax_White;
}
#pragma mark - 界面文字
- (void)setupText{
    [_continueBtn setTitle:PaxContinue forState:UIControlStateNormal];
    [_continueBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
}
#pragma mark - 事件添加
- (void)rac_event{
    //TODO: 下一步按钮
    LXLWeakSelf(self);
    [[_continueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [Weakself.view endEditing:true];
        PaxParamter_CreateSender *sender = [[PaxParamter_CreateSender alloc]init];
        sender.receiverName = _name.text;
        sender.receiverPhone = _phone.text;
        sender.giftcardCode = _gift.text;
        sender.credits = [_credit.text integerValue];
        if (_fromModel == nil) {
            [PaxHUD Pax_showErrorWithStatus:PaxPleaseselectsavecollectbox];
            return;
        }
        
        
        sender.deliveryBox = @{
                               @"id":_fromModel.nearbyId
                               };
        sender.recipientAddress = @{
                                @"cityInfo":_city.text,
                                @"street": _street.text,
                                @"detailedAddress":_floor.text,
                                @"provinceInfo":@"",
                                @"suburb":@""
                                };
        sender.payType = @"ONLINE";
        sender.sendType = @"LOCKER_TO_ADDRESS";
        PaxLockerSnapViewController *dimVc = [[PaxLockerSnapViewController alloc]init];
        dimVc.sender = sender;
        [Weakself.navigationController pushViewController:dimVc animated:true];
        
        
        
    }];
    
    
    //TODO: 监听gift 优惠券的输入
    [[_gift rac_textSignal]subscribeNext:^(id x) {
        
    }];
    
    //TODO: 监听credit 积分输入
    
    [[_credit rac_textSignal]subscribeNext:^(id x) {
        
    }];
}

#pragma mark - 用于基本元素设计
- (UIView *)setupLeftButtonAndRightTextViewLeftlabel:(NSString *)title andRightPlaceholder:(NSString *)placeholder andIsHiddenImage:(BOOL)isHidden clickRightView:(SEL)clickFuncation andLeftViewIsHidden:(BOOL)left_isHidden{
    UIView *content = [[UIView alloc]init];
    
    //TODO: 左边view的设计
    UIView *leftView = [[UIView alloc]init];
    leftView.hidden = left_isHidden;
//    leftView.backgroundColor = Pax_White;
//    leftView.layer.cornerRadius = 5;
//    leftView.layer.masksToBounds = true;
    [leftView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
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
//    rightView.backgroundColor = Pax_White;
//    rightView.layer.cornerRadius = 5;
//    rightView.layer.masksToBounds = true;
 [rightView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [content addSubview:rightView];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(content);
        make.left.equalTo(leftView.mas_right).offset(15);
    }];
    UITextField *textfiled = [[UITextField alloc]init];
    [rightView addSubview:textfiled];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.equalTo(rightView);
        make.left.equalTo(rightView).offset(3);
    }];
    textfiled.placeholder = placeholder;
    textfiled.font = Pax_Font_H3;
    
    if (placeholder == PaxRecieverName) {
        _name = textfiled;
    }else if(placeholder == PaxReceiverMobile){
        _phone = textfiled;
    }else if(placeholder == PaxFloorApartmentBuilding){
        _floor = textfiled;
    }else if(placeholder == PaxStreet){
        _street = textfiled;
    }else if(placeholder == PaxDistrictCity){
        _city = textfiled;
    }else if([title isEqualToString: PaxCoupons]){
        _gift = textfiled;
    }else if([title isEqualToString:PaxCredits]){
        _credit = textfiled;
    }
    
    
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

/**
 点击事件
 */
- (void)clickFrom:(UITapGestureRecognizer *)tap
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
        _fromModel = model;
    };
    [self.navigationController pushViewController:selectMap animated:true];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}
@end
