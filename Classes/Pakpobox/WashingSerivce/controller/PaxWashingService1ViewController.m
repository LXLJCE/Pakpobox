//
//  PaxWashingService1ViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/14.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxWashingService1ViewController.h"

#import "PaxParcelCollectViewController.h"
#import "PaxPaypal.h"
#import "PaxReturnOrderInformationViewController.h"
@interface PaxWashingService1ViewController ()<PayPalPaymentDelegate>
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


@property (weak, nonatomic) UILabel *crashNum;
@property (weak, nonatomic) UIButton *WashBtnContinue;

/** 箱子对地址界面*/
@property (weak, nonatomic) UIView *Return;
/**下一步按钮*/
@property (weak, nonatomic) UIButton *continueBtn;
/**提示文字*/
@property (weak, nonatomic) UILabel *pleaseLabel;
/**运单号*/
@property (weak, nonatomic) UITextField *OrderText;


@property (strong, nonatomic) PaxPaypal *model;
@end

@implementation PaxWashingService1ViewController

- (UIView *)Sender
{
    if(_Sender == nil){
        /**Sender 界面布局*/
        UIView *Sender = [[UIView alloc]init];
        [self.view addSubview:Sender];
        LXLWeakSelf(self);
        [Sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Weakself.view).offset(64);
            make.left.right.bottom.equalTo(Weakself.view);
        }];
        UILabel *title = [[UILabel alloc]init];
        _titleLabel = title;
        title.textAlignment = NSTextAlignmentCenter;
        [Sender addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Sender).offset(10);
            make.left.right.equalTo(Sender);
            make.height.mas_equalTo(35);
        }];
        UIImageView *clothes = [[UIImageView alloc]init];
        _clothes = clothes;
        clothes.contentMode = UIViewContentModeCenter;
        [Sender addSubview:clothes];
        [clothes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom);
            make.left.equalTo(Sender).offset(60);
            make.right.equalTo(Sender).offset(-60);
            make.height.equalTo(clothes.mas_width);
        }];
        UIView *contentView = [[UIView alloc]init];
        [Sender addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(clothes.mas_bottom).offset(20);
            make.bottom.left.right.equalTo(Sender);
            ;
        }];
        
        
        //TODO: Locker
        UIView *loction = [self setupLeftButtonAndRightTextViewLeftlabel:PaxLocation andRightPlaceholder:PaxShowNearestPakpoboxLocker andIsHiddenImage:false clickRightView:@selector(clickRight)];
        [contentView addSubview:loction];
        [loction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(24);
            make.right.equalTo(contentView).offset(-24);
            make.top.equalTo(contentView);
            make.height.equalTo(@(30));
        }];
        //TODO: Door Size
        UIView *Detergent = [self setupLeftButtonAndRightTextViewLeftlabel:PaxDetergent andRightPlaceholder:PaxStandardFree andIsHiddenImage:false clickRightView:@selector(clickRight)];
        [contentView addSubview:Detergent];
        [Detergent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(24);
            make.right.equalTo(contentView).offset(-24);
            make.top.equalTo(loction.mas_bottom).offset(20);
            make.height.equalTo(@(30));
        }];
        
        //TODO: Door Size
        UIView *giftcode = [self setupLeftButtonAndRightTextViewLeftlabel:@"优惠券" andRightPlaceholder:@"请输入优惠券编码" andIsHiddenImage:true clickRightView:@selector(clickRight)];
        [contentView addSubview:Detergent];
        [Detergent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(24);
            make.right.equalTo(contentView).offset(-24);
            make.top.equalTo(Detergent.mas_bottom).offset(20);
            make.height.equalTo(@(30));
        }];
        
        //TODO: Door Size
        UIView *credit = [self setupLeftButtonAndRightTextViewLeftlabel:@"积分" andRightPlaceholder:@"请输入积分" andIsHiddenImage:true clickRightView:@selector(clickRight)];
        [contentView addSubview:Detergent];
        [Detergent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(24);
            make.right.equalTo(contentView).offset(-24);
            make.top.equalTo(giftcode.mas_bottom).offset(20);
            make.height.equalTo(@(30));
        }];
        
        
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
        [continueBtn backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
        [Sender addSubview:continueBtn];
        [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(credit.mas_bottom).offset(20);
            make.right.equalTo(contentView).offset(-40);
            make.width.equalTo(contentView).offset(-80).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        
        
        _Sender = Sender;
    }
    return _Sender;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:PaxParcels style:UIBarButtonItemStyleDone target:nil action:nil];
    self.model = [[PaxPaypal alloc]init];
    [self addReturn];
    [self addSender];
    [self setupColor];
    [self setupFont];
    [self setupText];
    
    
    [self rac_event];
    
    
    
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 绑定事件
 */
- (void)rac_event{
    LXLWeakSelf(self);
    
    //TODO: segment 选项卡点击
    [[self.segControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl *sender) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                [Weakself addSender];
                break;
            case 1:
                [Weakself addReturn];
                break;
            default:
                break;
        }
        
    }];
    
    
    
    //TODO: 下一步按钮
    [[_continueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PaxReturnOrderInformationViewController *reurnVc = [[PaxReturnOrderInformationViewController alloc]init];
        
        [Weakself.navigationController pushViewController:reurnVc animated:true];
    }];
    
    
    [[_WashBtnContinue rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        
        //订单总额
        
        payment.amount = [NSDecimalNumber decimalNumberWithString:@"65"];
        
        
        
        //货币类型-RMB是没用的
        payment.currencyCode = @"USD";
        
        //订单描述
        payment.shortDescription = @"Hipster clothing";
        
        
        
        
        //生成paypal控制器，并模态出来(push也行)
        //将之前生成的订单信息和paypal配置传进来，并设置订单VC为代理
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment                                                                                            configuration:Weakself.model.payPalConfig                                                                                                 delegate:Weakself];
        
        //模态展示
        [self presentViewController:paymentViewController animated:YES completion:nil];
        
    }];
    
}
- (void)addSender{
    self.Sender.hidden = false;
    self.Return.hidden = true;
    
}
- (void)addReturn{
    self.Sender.hidden = true;
    self.Return.hidden = false;
    
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
    
    
    _clothes.image = [UIImage imageNamed:@"pack"];
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
    rightView.backgroundColor = Pax_White;
    rightView.layer.cornerRadius = 5;
    rightView.layer.masksToBounds = true;
    
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
- (void)clickRight
{
    [self.view endEditing:true];
    PaxLog(@"%@",@"点击了");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}




//订单支付完成后回调此方法
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    [PaxHUD Pax_showSuccessWithStatus:[NSString stringWithFormat:@"成功支付%@",_crashNum.text]];
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
    [paymentViewController dismissViewControllerAnimated:true completion:nil];
}

//用户取消支付回调此方法
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    [PaxHUD Pax_showErrorWithStatus:@"取消支付"];
    [paymentViewController dismissViewControllerAnimated:true completion:nil];
}
@end
