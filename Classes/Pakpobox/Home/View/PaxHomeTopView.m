//
//  PaxHomeTopView.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxHomeTopView.h"
#import "STBannerView.h"

@interface PaxHomeTopView()<STBannerViewDelegate>
@property (nonatomic, weak) STBannerView *netBannerView;
@property (weak, nonatomic) UIButton *locationBtn;
@property (weak, nonatomic) UIButton *email;
@end
@implementation PaxHomeTopView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupBase];
        [self setupColor];
        [self setupFont];
    }
    return self;
}


- (void)setupBase
{
    _netBannerView = [STBannerView bannerView];
//    _netBannerView.layer.cornerRadius = 5;
    _netBannerView.layer.masksToBounds = true;
    _netBannerView.interval = 5;
    _netBannerView.delegate = self;
    [_netBannerView creatTimer];
    [self addSubview:_netBannerView];
    
    
    UIButton *locationBtn = [[UIButton alloc]init];
    [locationBtn setTitle:PaxShenZhen forState:UIControlStateNormal];
    [self addSubview:locationBtn];
    [locationBtn sizeToFit];
    self.locationBtn = locationBtn;
    
    UIButton *email = [[UIButton alloc]init];
    [email setTitle:PaxShenZhen forState:UIControlStateNormal];
    [self addSubview:email];
    [email sizeToFit];
    self.email = email;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.netBannerView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.locationBtn.frame = CGRectMake(8, 8, 100, self.locationBtn.bounds.size.height);
    self.email.frame = CGRectMake(self.bounds.size.width - 8 - 100, 8, 100, self.email.bounds.size.height);
    if (_netBannerView.images.count == 0) {
        _netBannerView.images = @[@"pack",@"pack",@"pack"];
    }
   
}

- (void)setupFont
{
    self.locationBtn.titleLabel.font = Pax_Font_Home_Top_Left;
    self.email.titleLabel.font = Pax_Font_Home_Top_Right;
    
}

- (void)setupColor
{
    [self.locationBtn setTitleColor:Pax_Color_Home_Top_leftBtn_TitleColor forState:UIControlStateNormal];
    [self.email setTitleColor:Pax_Color_Home_Top_rightBtn_TitleColor forState:UIControlStateNormal];
//    [self.locationBtn setBackgroundColor:Pax_Color_Hone_Top_Btn_BackGround];
//    [self.email setBackgroundColor:Pax_Color_Hone_Top_Btn_BackGround];
}

- (void)bannerView:(STBannerView *)view didSelectImageView:(UIImageView *)imageView
{
//     PaxLog(@"%zd", imageView.tag);
    _ClickTopView();
}

@end
