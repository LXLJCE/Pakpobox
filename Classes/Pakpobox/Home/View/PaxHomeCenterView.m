//
//  PaxHomeCenterView.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxHomeCenterView.h"
@interface PaxHomeCenterView()
@property (weak, nonatomic) PaxUDButton * expressageBtn; // 快递按钮
@property (weak, nonatomic) PaxUDButton * washingBtn; // 洗衣按钮
@property (weak, nonatomic) PaxUDButton * leaseBtn; // 租赁按钮
@property (weak, nonatomic) PaxUDButton * transferBtn;// 中转按钮
@end
@implementation PaxHomeCenterView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupBase];
        [self setupFont];
        [self setupColor];
    }
    return self;
}
- (void)setupBase
{
    PaxUDButton * expressageBtn = [[PaxUDButton alloc]init];
    [expressageBtn setTitle:PaxParcels forState:UIControlStateNormal];
    [expressageBtn setImage:[UIImage imageNamed:@"package"] forState:UIControlStateNormal];
    [expressageBtn addTarget:self action:@selector(clickExpressageBtn) forControlEvents:UIControlEventTouchUpInside];
    self.expressageBtn = expressageBtn;
    [self addSubview:expressageBtn];
    
    
    PaxUDButton * washingBtn = [[PaxUDButton alloc]init];
    [washingBtn setTitle:PaxLaundry forState:UIControlStateNormal];
    [washingBtn setImage:[UIImage imageNamed:@"clothes"] forState:UIControlStateNormal];
    
    [washingBtn addTarget:self action:@selector(clickWashingBtn) forControlEvents:UIControlEventTouchUpInside];
    self.washingBtn = washingBtn;
    [self addSubview:washingBtn];
    
    
    PaxUDButton * leaseBtn = [[PaxUDButton alloc]init];
    [leaseBtn setTitle:PaxLease forState:UIControlStateNormal];
    [leaseBtn setImage:[UIImage imageNamed:@"rent"] forState:UIControlStateNormal];
    [leaseBtn addTarget:self action:@selector(clickLeaseBtn) forControlEvents:UIControlEventTouchUpInside];
    self.leaseBtn = leaseBtn;
    [self addSubview:leaseBtn];
    
    
    PaxUDButton * transferBtn = [[PaxUDButton alloc]init];
    [transferBtn setTitle:PaxTransitShipment forState:UIControlStateNormal];
    [transferBtn setImage:[UIImage imageNamed:@"transfer"] forState:UIControlStateNormal];
    [transferBtn addTarget:self action:@selector(clickTransferBtn) forControlEvents:UIControlEventTouchUpInside];
    self.transferBtn = transferBtn;
    [self addSubview:transferBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews ];
    CGFloat margin = 20;
    CGFloat width = (self.bounds.size.width - 2 *Pax_Home_center_LR_Margin - 3 * margin) / 4;
    CGFloat height = self.bounds.size.height;
    self.expressageBtn.frame = CGRectMake(Pax_Home_center_LR_Margin, 0, width, height);
    self.washingBtn.frame = CGRectMake(Pax_Home_center_LR_Margin + margin + width, 0, width, height);
    self.leaseBtn.frame = CGRectMake(Pax_Home_center_LR_Margin + margin * 2 + 2 *width, 0, width, height);
    self.transferBtn.frame = CGRectMake(Pax_Home_center_LR_Margin + margin* 3 + 3 * width, 0, width, height);
}

- (void)clickExpressageBtn{}
- (void)clickWashingBtn{}
- (void)clickLeaseBtn{}
- (void)clickTransferBtn{}

- (void)setupFont
{
    
}

- (void)setupColor
{
    self.backgroundColor = [UIColor whiteColor];
    
}
@end


@implementation PaxUDButton

- (void)layoutSubviews
{
    [super layoutSubviews ];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = CGRectMake(0, height - width - 25, width, width);
    self.titleLabel.frame = CGRectMake(0, height - 25, width, 25);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self setTitleColor:Pax_Color_Home_Center_Btn_TitleColor forState:UIControlStateNormal];
        self.titleLabel.font = Pax_Font_Home_Center;
    }
    return  self;
}
@end
