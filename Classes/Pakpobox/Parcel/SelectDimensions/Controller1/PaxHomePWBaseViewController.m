//
//  PaxParcel_newViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxHomePWBaseViewController.h"

@interface PaxHomePWBaseViewController ()



/**
 顶部图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *TopImage;

/**
 按钮1
 */
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
//- (IBAction)clickBtn1:(id)sender;
//
//- (IBAction)clickBtn2:(id)sender;
//- (IBAction)clickBtn3:(id)sender;
@end

@implementation PaxHomePWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupPaxUI];
    
}

/**
 UI设置
 */
//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
//    [self setupPaxUI];
//    return self;
//}
- (void)setupPaxUI
{
    
    [_btn1 backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [_btn1 setTitleColor:Pax_Black forState:UIControlStateNormal];
    [_btn1.titleLabel setFont:Pax_Font_Button];
    
    [_btn2 backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [_btn2 setTitleColor:Pax_Black forState:UIControlStateNormal];
    [_btn2.titleLabel setFont:Pax_Font_Button];
    
    [_btn3 backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [_btn3 setTitleColor:Pax_Black forState:UIControlStateNormal];
    [_btn3.titleLabel setFont:Pax_Font_Button];
    
    _btn1.hidden = _btn1Name == nil ? true: false;
    _btn2.hidden = _btn2Name == nil ? true: false;
    _btn3.hidden = _btn3Name == nil ? true: false;
    [_btn1 setTitle:_btn1Name forState:UIControlStateNormal];
    [_btn2 setTitle:_btn2Name forState:UIControlStateNormal];
    [_btn3 setTitle:_btn3Name forState:UIControlStateNormal];
    self.TopImage.image = [UIImage imageNamed:_imageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBtn1Name:(NSString *)btn1Name
{
    _btn1Name = btn1Name;
    
    _btn1.hidden = _btn1Name == nil ? true: false;
    
    [_btn1 setTitle:btn1Name forState:UIControlStateNormal];
}

- (void)setBtn2Name:(NSString *)btn2Name
{
    _btn2Name = btn2Name;
    _btn2.hidden = _btn2Name == nil ? true: false;
    [_btn2 setTitle:btn2Name forState:UIControlStateNormal];
}

- (void)setBtn3Name:(NSString *)btn3Name
{
    _btn3Name = btn3Name;
    _btn3.hidden = _btn3Name == nil ? true: false;
    [_btn3 setTitle:btn3Name forState:UIControlStateNormal];
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.TopImage.image = [UIImage imageNamed:imageName];
}
/**
 点击事件监听
 */
- (IBAction)clickBtn1:(id)sender {
}
- (IBAction)clickBtn2:(id)sender {
}
- (IBAction)clickBtn3:(id)sender {
}
@end
