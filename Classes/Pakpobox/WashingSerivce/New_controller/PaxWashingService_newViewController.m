//
//  PaxWashingService_newViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxWashingService_newViewController.h"
#import "PaxPaypal.h"
#import "PaxSelectMapViewController.h"
#import "PaxNearbyModel.h"
#import "PaxDetergentViewController.h"
#import "PaxDetergentModel.h"
#import "PaxWashPaySuccessViewController.h"
@interface PaxWashingService_newViewController ()<PayPalPaymentDelegate>
/** 箱子对箱子界面*/
@property (weak, nonatomic) UIView *Sender;

/**
 标题
 */
@property (weak, nonatomic) UILabel *titleLabel;

/**
 服饰图片
 */
@property (weak,nonatomic) UIImageView *clothes;


/**
 位置
 */
@property (weak, nonatomic) UITextField *locationLabel;

/**
 服务
 */
@property (weak, nonatomic) UITextField * DetergentLabel;


/**
 价格文字
 */
@property (weak, nonatomic) UILabel *crashNum;

/**
 继续按钮
 */
@property (weak, nonatomic) UIButton *WashBtnContinue;


/**下一步按钮*/
@property (weak, nonatomic) UIButton *continueBtn;
/**提示文字*/
@property (weak, nonatomic) UILabel *pleaseLabel;
/**运单号*/
@property (weak, nonatomic) UITextField *OrderText;


/**
 paypal模型
 */
@property (strong, nonatomic) PaxPaypal *model;


/**
 价格列表数组
 */
@property (strong, nonatomic) NSArray *detergentModels;


/**
 选中的服务几个
 */
@property (assign, nonatomic) float price;

/**
 总金额
 */
@property (assign, nonatomic) float total;


/**
 优惠券
 */
@property (weak, nonatomic) UITextField *gift;

/**
 积分
 */
@property (weak, nonatomic) UITextField *credit;



/**
 附近模型
 */
@property (strong, nonatomic) PaxNearbyModel *nearbyModel;
/**
 洗涤夜模型
 */
@property (strong, nonatomic) PaxDetergentModel *detergentModel;


@property (strong , nonatomic) NSDictionary *responseObject;
@end

@implementation PaxWashingService_newViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self networkRequestToGetServicePirce];
    self.navText = PaxWash;
    self.model = [[PaxPaypal alloc]init];
    [self setupUI];
    [self setupColor];
    [self setupFont];
    [self setupText];
    
    
    [self rac_event];
    
}


/**
 UI界面设置
 */
- (void)setupUI
{
    UIView *Sender = [[UIView alloc]init];
    [self.view addSubview:Sender];
    LXLWeakSelf(self);
    [Sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(64);
        make.left.right.bottom.equalTo(Weakself.view);
    }];
    // TODO: 标题
    UILabel *title = [[UILabel alloc]init];
    _titleLabel = title;
    title.textAlignment = NSTextAlignmentCenter;
    [Sender addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Sender).offset(10);
        make.left.right.equalTo(Sender);
        make.height.mas_equalTo(35);
    }];
    //TODO: 图片
    UIImageView *clothes = [[UIImageView alloc]init];
    _clothes = clothes;
    clothes.contentMode = UIViewContentModeScaleToFill;
    [Sender addSubview:clothes];
    [clothes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom);
        make.centerX.equalTo(Sender);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    UIView *contentView = [[UIView alloc]init];
    [Sender addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clothes.mas_bottom).offset(20);
        make.bottom.left.right.equalTo(Sender);
        ;
    }];
    
    
    //TODO: Locker
    UIView *loction = [self setupLeftButtonAndRightTextViewLeftlabel:PaxLocation andRightPlaceholder:PaxShowNearestPakpoboxLocker andIsHiddenImage:false clickRightView:@selector(clickLocation:)];
    [contentView addSubview:loction];
    [loction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(24);
        make.right.equalTo(contentView).offset(-24);
        make.top.equalTo(contentView);
        make.height.equalTo(@(40));
    }];
    //TODO: 洗涤剂
    UIView *Detergent = [self setupLeftButtonAndRightTextViewLeftlabel:PaxDetergent andRightPlaceholder:PaxStandardFree andIsHiddenImage:false clickRightView:@selector(clickDetergent:)];
    [contentView addSubview:Detergent];
    [Detergent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(24);
        make.right.equalTo(contentView).offset(-24);
        make.top.equalTo(loction.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    
    
    //TODO: 优惠卷
    UIView *giftcode = [self setupLeftButtonAndRightTextViewLeftlabel:@"优惠券" andRightPlaceholder:@"请输入优惠券编码" andIsHiddenImage:true clickRightView:nil];
    [contentView addSubview:giftcode];
    [giftcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(24);
        make.right.equalTo(contentView).offset(-24);
        make.top.equalTo(Detergent.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    
    //TODO: 积分
    UIView *credit = [self setupLeftButtonAndRightTextViewLeftlabel:@"积分" andRightPlaceholder:@"请输入积分" andIsHiddenImage:true clickRightView:nil];
    [contentView addSubview:credit];
    [credit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(24);
        make.right.equalTo(contentView).offset(-24);
        make.top.equalTo(giftcode.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    
    //TODO: 结算
    UILabel *crashNum = [[UILabel alloc]init];
    _crashNum = crashNum;
    crashNum.textAlignment = NSTextAlignmentCenter;
    [Sender addSubview:crashNum];
    [crashNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(credit.mas_bottom).offset(20);
        make.left.equalTo(Weakself.view).offset(40);
        make.width.equalTo(Weakself.view).offset(-80).multipliedBy(0.5);
        make.height.mas_equalTo(40);
    }];
    //TODO: continueBtn
    UIButton *continueBtn = [[UIButton alloc]init];
    _WashBtnContinue = continueBtn;
    [continueBtn backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [Sender addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(credit.mas_bottom).offset(20);
        make.right.equalTo(contentView).offset(-40);
        make.width.equalTo(contentView).offset(-80).multipliedBy(0.5);
        make.height.mas_equalTo(50);
    }];

}
/**
 设置颜色
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _continueBtn.backgroundColor = Pax_White;
    
    _pleaseLabel.textColor = Pax_Black;
    _OrderText.textColor = Pax_Black;
    
    
    _titleLabel.textColor = Pax_Black;
    [_WashBtnContinue setTitleColor:Pax_Black forState:UIControlStateNormal];
    _crashNum.textColor = Pax_Black;
}

/**
 设置字体
 */
- (void)setupFont
{
    
    _continueBtn.titleLabel.font = Pax_Font_Button;
    _pleaseLabel.font = Pax_Font_Text;
    _OrderText.font = Pax_Font_H3;
    _titleLabel.font = Pax_Font_H2;
    _WashBtnContinue.titleLabel.font = Pax_Font_Button;
    _crashNum.font = Pax_Font_H3;
}

/**
 设置文字
 */
- (void)setupText
{
    [_continueBtn setTitle:PaxContinue forState:UIControlStateNormal];
    [_continueBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
    _pleaseLabel.text = PaxPleaseinputorder;
    _titleLabel.text = PaxAllyoucanfitfor;
    [_WashBtnContinue setTitle:PaxContinue forState:UIControlStateNormal];
    _crashNum.text = @"$65";
    
    
    _clothes.image = [UIImage imageNamed:@"snap2"];
}

/**
 绑定事件
 */
- (void)rac_event{
    LXLWeakSelf(self);
 
    [[_WashBtnContinue rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [Weakself networkRequestWithCreateOrder];
    }];
    
    //TODO: 监听gift 优惠券的输入
    [[_gift rac_textSignal]subscribeNext:^(id x) {
        
    }];
    
    //TODO: 监听credit 积分输入
    
    [[_credit rac_textSignal]subscribeNext:^(id x) {
        
    }];
    
}

#pragma mark - 用于基本元素设计
- (UIView *)setupLeftButtonAndRightTextViewLeftlabel:(NSString *)title andRightPlaceholder:(NSString *)placeholder andIsHiddenImage:(BOOL)isHidden clickRightView:(SEL)clickFuncation{
    UIView *content = [[UIView alloc]init];
    
    //TODO: 左边view的设计
    UIView *leftView = [[UIView alloc]init];
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
    [rightView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
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
    
    if (placeholder == PaxShowNearstLocker) {
        _locationLabel = textfiled;
    }else if(placeholder == PaxStandardFree){
        _DetergentLabel = textfiled;
    }else if([title isEqualToString:@"优惠券"]){
        _gift = textfiled;
    }else if([title isEqualToString:@"积分"]){
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

#pragma mark - clickRight

/**
 点击位置跳转

 @param tap tap
 */
- (void)clickLocation:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:true];
    PaxLog(@"%@",@"点击了");
    UITextField *textfield;
    for (id sub in tap.view.subviews) {
        if ([sub class] == [UITextField class]) {
            textfield = (UITextField *)sub;
        }
    }
    LXLWeakSelf(self);
    PaxSelectMapViewController *seleMap = [[PaxSelectMapViewController alloc]init];
    seleMap.selectLoction = ^(PaxNearbyModel *model) {
        Weakself.nearbyModel = model;
        textfield.text = model.name;
    };
    
    [self.navigationController pushViewController:seleMap animated:true];
    
}

/**
 点击洗涤剂跳转

 @param tap tap
 */
- (void)clickDetergent:(UITapGestureRecognizer *)tap
{
    LXLWeakSelf(self);
    [self.view endEditing:true];
    PaxLog(@"%@",@"点击了");
    UITextField *textfield;
    for (id sub in tap.view.subviews) {
        if ([sub class] == [UITextField class]) {
            textfield = (UITextField *)sub;
        }
    }
  
    PaxDetergentViewController *devc = [[PaxDetergentViewController alloc]init];
    devc.models = _detergentModels;
    devc.handle = ^(PaxDetergentModel *model) {
        [Weakself setContent:model];
    };
    [self.navigationController pushViewController:devc animated:true];
    
    
}



//订单支付完成后回调此方法
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
//    [PaxHUD Pax_showSuccessWithStatus:[NSString stringWithFormat: @"支付成功,支付%@",_crashNum.text]];
    [PaxHUD Pax_showSuccessWithStatus:[NSString stringWithFormat:@"%@%@",PaxPaySuccess,_crashNum.text]];
    
    //PaxWashPaySuccessViewController *vc = [[PaxWashPaySuccessViewController alloc]init];
    
    //[self.navigationController pushViewController:vc animated:true];
    //回调的 PayPalPayment 的 confirmation 属性包含此次订单的状态信息包括校验码，服务器可已通过该校验码验证交易真实性。
    //返回数据 - id所对应的就是校验码。
    /*
     {
     client =     {
     environment = sandbox;
     "paypal_sdk_version" = "2.14.2";
     platform = iOS;
     "product_name" = "PayPal iOS SDK";
     };
     response =     {
     "create_time" = "2016-05-12T03:25:49Z";
     id = "PAY-6BG56850AF923584SK4Z7PNQ";
     intent = sale;
     state = approved;
     };
     "response_type" = payment;
     }
     */
    LXLWeakSelf(self);
    [paymentViewController dismissViewControllerAnimated:true completion:^{
        PaxWashPaySuccessViewController *vc = [[PaxWashPaySuccessViewController alloc]init];
        vc.washId = Weakself.responseObject[@"id"];
        [Weakself.navigationController pushViewController:vc animated:true];
    }];
    
}

//用户取消支付回调此方法
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    [PaxHUD Pax_showErrorWithStatus:PaxPayCancel];
    [paymentViewController dismissViewControllerAnimated:true completion:nil];
   // PaxWashPaySuccessViewController *vc = [[PaxWashPaySuccessViewController alloc]init];
    
    //[self.navigationController pushViewController:vc animated:true];
//    [self networkRequestWithCreateOrder];
}



/**
 获取洗衣服务价格
 */
- (void)networkRequestToGetServicePirce
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_GetServicePriceWithTipMessage:PaxPleasewaitamomentLoad type:_order_type  Finish:^(NSArray *responseObject, NSError *error) {
        
        if(responseObject.count == 0){
            [PaxHUD Pax_showSuccessWithStatus:PaxSorrnodatayouwant];
        }else{
            NSArray *models = [PaxDetergentModel mj_objectArrayWithKeyValuesArray:responseObject[0][@"sku_list"]];
            Weakself.detergentModels = models;
        
            
            Weakself.price = [responseObject[0][@"price"] floatValue];
            Weakself.titleLabel.text = [NSString stringWithFormat:@"%@%.2f",PaxAllyoucanfitfor,Weakself.price];
            
            
            
            [Weakself setContent:models[0]];
            
        }
    }];
}


/**
 根据 服务 模型

 @param model 计算价格
 */
- (void)setContent:(PaxDetergentModel *)model{
    _detergentModel = model;
    _DetergentLabel.text = model.name;
    float total = _price + model.price;
    _total = total;
    _crashNum.text = [NSString stringWithFormat:@"$%.2f",total];
}

#pragma mark - 订单生成
- (void)networkRequestWithCreateOrder
{
    NSDictionary *user = [PaxDataSave getUserMessage];
    LXLWeakSelf(self);
    
    
    //NSDictionary *goodInfo = @{
                              // @"items" : @[
                                //   @{
                              // @"amount":[NSString stringWithFormat:@"%f", _detergentModel.price * 1],
                              //  @"price":[NSString stringWithFormat:@"%f", _detergentModel.price * 1],
                               //    @"quantity":@"1",
                              //     @"sku_id":_detergentModel.detergent_id
                              //     }
                             //          ]
                             //  };
    
    
    NSString *goodsInfo = [NSString stringWithFormat:@"{\"items\":[{\"amount\":%f,\"price\":%f, \"quantity\":%zd,\"sku_id\":%@}]}",_detergentModel.price *1, _detergentModel.price,1,_detergentModel.detergent_id];
    
    if(_nearbyModel == nil){
        [PaxHUD Pax_showErrorWithStatus:PaxSelectorBoxLocation];
        return;
    }
    
    [[LXLNetWorkTool shareTools]Pax_WashCreateorderWithTipMessage:PaxPleasewaitamomentLoad login_name:user[@"email"] == nil? @"" :user[@"email"]Phone:user[@"phoneNumber"] == nil ? @"" :user[@"phoneNumber"]   amount:_total giftcardamount:0 totalamount:_total productname:_detergentModel.name productdesc:@"" goodsinfo:goodsInfo clienttype:@"IOS" giftcardno:@"" Integral:0 ordertype:@"LAUNDRY_SERVICE" Box:@{@"id" : _nearbyModel.nearbyId} paytype:@"NONE" Finish:^(id responseObject, NSError *error) {
        
        
        
            [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
        
        Weakself.responseObject = responseObject;
        
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        
        //订单总额
        
        payment.amount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",Weakself.total]];
        
        
        
        //货币类型-RMB是没用的
        payment.currencyCode = @"USD";
        
        //订单描述
        payment.shortDescription = @"Hipster clothing";
        
        
        
        
        //生成paypal控制器，并模态出来(push也行)
        //将之前生成的订单信息和paypal配置传进来，并设置订单VC为代理
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment                                                                                            configuration:Weakself.model.payPalConfig                                                                                                 delegate:Weakself];
        
        //模态展示
        [Weakself presentViewController:paymentViewController animated:YES completion:nil];

        
        
       
        
        
    }];
}
@end
