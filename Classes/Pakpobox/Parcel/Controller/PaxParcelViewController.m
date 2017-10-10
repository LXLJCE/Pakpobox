//
//  PaxParcelViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/20.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxParcelViewController.h"
#import "PaxParcelCollectViewController.h"
#import "PaxParcelLockerToLockerViewController.h"
#import "PaxParcelLockerToAddressViewController.h"
#import "PaxReturnOrderInformationViewController.h"
@interface PaxParcelViewController ()
@property (weak, nonatomic) UIView *Sender;/** 箱子对箱子界面*/
@property (weak, nonatomic) UIButton *LL; /**跳转锁对锁*/
@property (weak, nonatomic) UIButton *LA; /**跳转所对箱子*/
@property (weak, nonatomic) UIView *Return;/** 箱子对地址界面*/

@property (weak, nonatomic) UIButton *continueBtn;/**下一步按钮*/
@property (weak, nonatomic) UILabel *pleaseLabel; /**提示文字*/
@property (weak, nonatomic) UITextField *OrderText; /**运单号*/

@end

@implementation PaxParcelViewController

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
        
        /**两个按钮的设置*/
        
        UIView *contentView = [[UIView alloc]init];
        [Sender addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(Sender);
            make.left.equalTo(Sender).offset(24);
             make.right.equalTo(Sender).offset(-24);
            make.height.equalTo(Sender).multipliedBy(0.5);
        }];
        
        /*Sender按钮*/
        UIButton *LL = [[UIButton alloc]init];
        self.LL = LL;
        
        [LL backColor:Pax_White cornerRadius:Pax_Login_Bottom_Button_Height / 2 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
        [contentView addSubview:LL];
        
        [LL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView).offset(10);
            make.left.right.equalTo(contentView);
            make.height.equalTo(@(Pax_Login_Bottom_Button_Height));
        }];
    
        
        /*Return按钮*/
        UIButton *LA = [[UIButton alloc]init];
        self.LA = LA;
        [LA backColor:Pax_White cornerRadius:Pax_Login_Bottom_Button_Height / 2 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
        [contentView addSubview:LA];
        
        [LA mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(LL.mas_bottom).offset(20);
            make.left.right.equalTo(contentView);
            make.height.equalTo(@(Pax_Login_Bottom_Button_Height));
        }];
        
        
        
        _Sender = Sender;
    }
    return _Sender;
}
- (UIView *)Return
{
    if(_Return == nil){
        UIView *Return = [[UIView alloc]init];
        _Return = Return;
        [self.view addSubview:Return];
        LXLWeakSelf(self);
        [Return mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Weakself.view).offset(64);
            make.left.right.bottom.equalTo(Weakself.view);
        }];
        
        
        UIView *contentView = [[UIView alloc]init];
        [Return addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(Return);
            make.left.equalTo(Return);
            make.height.equalTo(@(220));
        }];
        
        
        //TODO: Locker
        UIView *Locker = [self setupLeftButtonAndRightTextViewLeftlabel:PaxLocker andRightPlaceholder:PaxShowNearestPakpoboxLocker andIsHiddenImage:false clickRightView:@selector(clickRight)];
        [contentView addSubview:Locker];
        [Locker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(24);
            make.right.equalTo(contentView).offset(-24);
            make.top.equalTo(contentView);
            make.height.equalTo(@(30));
        }];
        //TODO: Door Size
        UIView *DoorSize = [self setupLeftButtonAndRightTextViewLeftlabel:PaxDoorSize andRightPlaceholder:PaxSmall391mm450mm120mm andIsHiddenImage:false clickRightView:@selector(clickRight)];
        [contentView addSubview:DoorSize];
        [DoorSize mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(24);
            make.right.equalTo(contentView).offset(-24);
            make.top.equalTo(Locker.mas_bottom).offset(20);
            make.height.equalTo(@(30));
        }];
        //TODO: Please input order#
        UILabel *pleaseLabel = [[UILabel alloc]init];
        _pleaseLabel = pleaseLabel;
  
        [contentView addSubview:pleaseLabel];
        [pleaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(DoorSize.mas_bottom).offset(20);
            make.left.equalTo(contentView).offset(10 + 24);
            make.right.equalTo(contentView).offset(-24);
            make.height.equalTo(@(25));
        }];
        
        UIView *textContent = [[UIView alloc]init];
        [textContent backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
        [contentView addSubview:textContent];
        [textContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pleaseLabel.mas_bottom);
            make.left.equalTo(contentView).offset(24);
            make.right.equalTo(contentView).offset(-24);
            make.height.equalTo(@(30));
        }];
        UITextField *textfield = [[UITextField alloc]init];
        _OrderText = textfield;
        
        textfield.placeholder = PaxOrderpreregistration;
        [textContent addSubview:textfield];
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(textContent);
            make.left.equalTo(textContent).offset(5);
        }];
        
        //TODO: 下一步按钮
        UIButton *continueBtn = [[UIButton alloc]init];
        _continueBtn = continueBtn;
        [continueBtn backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false] ;
        
        [contentView addSubview:continueBtn];
        [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(textContent.mas_bottom).offset(20);
            make.bottom.equalTo(contentView);
            make.centerX.equalTo(contentView);
            make.width.equalTo(@(120));
        }];
        
        
        
        
        
        
        
        
        
    }
    return _Return;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:PaxParcels style:UIBarButtonItemStyleDone target:nil action:nil];
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
    
    //TODO: 导航 点击
    [[self rac_signalForSelector:@selector(clickRightItem)] subscribeNext:^(id x) {
        PaxParcelCollectViewController *coll = [[PaxParcelCollectViewController alloc]init];
        [self.navigationController pushViewController:coll animated:true];
    }];
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
    
    //TODO: LockerToLocker 点击
    [[self.LL rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        PaxParcelLockerToLockerViewController *llVc = [[PaxParcelLockerToLockerViewController alloc]init];
        [Weakself.navigationController pushViewController:llVc animated:true];
        
    }];
    // TODO: LockerToAddress 点击
    [[self.LA rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        PaxParcelLockerToAddressViewController *laVc = [[PaxParcelLockerToAddressViewController alloc]init];
        [Weakself.navigationController pushViewController:laVc animated:true];
    }];
    
    
    //TODO: 下一步按钮
    [[_continueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PaxReturnOrderInformationViewController *reurnVc = [[PaxReturnOrderInformationViewController alloc]init];
        
        [Weakself.navigationController pushViewController:reurnVc animated:true];
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
        [_LL setBackgroundColor:Pax_White];
        [_LA setBackgroundColor:Pax_White];
        [_LA setTitleColor:Pax_Black forState:UIControlStateNormal];
        [_LL setTitleColor:Pax_Black forState:UIControlStateNormal];
    _continueBtn.backgroundColor = Pax_White;
    
    _pleaseLabel.textColor = Pax_Black;
    _OrderText.textColor = Pax_Black;
}

/**
 设置字体
 */
- (void)setupFont
{
    [_LL.titleLabel setFont:Pax_Font_H3];
    [_LA.titleLabel setFont:Pax_Font_H3];
    _continueBtn.titleLabel.font = Pax_Font_Button;
    _pleaseLabel.font = Pax_Font_Text;
    _OrderText.font = Pax_Font_H3;
    
}

/**
 设置文字
 */
- (void)setupText
{
    [_LL setTitle:PaxLockerToLocker forState:UIControlStateNormal];
    [_LA setTitle:PaxLockerToAddress forState:UIControlStateNormal];
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
@end
