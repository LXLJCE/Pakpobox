//
//  PaxHomeBottomView.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxHomeBottomView.h"
@interface PaxHomeBottomView()
//@property (weak, nonatomic) UIButton *moreBtn;
@property (weak, nonatomic) UIView *leftUpView;
@property (weak, nonatomic) UIView *leftDownView;
@property (weak, nonatomic) PaxHomeBottomSubView *rightUpView;
@property (weak, nonatomic) UIView *rightDownView;


@end
@implementation PaxHomeBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupBaseView];
    }
    return self;
}

- (void)setupBaseView
{
    UIView *leftUp =  [PaxHomeBottomImageView subImageViewWithImageName:@"http://f.hiphotos.baidu.com/zhidao/pic/item/80cb39dbb6fd526695cb9cc4a918972bd5073679.jpg"];
    _leftUpView = leftUp;
//    leftUp.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:leftUp];
    
    UIView *leftDown =  [PaxHomeBottomImageView subImageViewWithImageName:@"http://f.hiphotos.baidu.com/zhidao/pic/item/80cb39dbb6fd526695cb9cc4a918972bd5073679.jpg"];
    _leftDownView = leftDown;
//    leftDown.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:leftDown];
    
    PaxHomeBottomSubView *rightUp =  [[PaxHomeBottomSubView alloc]init];
    _rightUpView = rightUp;
//    rightUp.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:rightUp];
    
    UIView *rightDown =  [PaxHomeBottomImageView subImageViewWithImageName:@"http://f.hiphotos.baidu.com/zhidao/pic/item/80cb39dbb6fd526695cb9cc4a918972bd5073679.jpg"];
    _rightDownView = rightDown;
//    rightDown.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:rightDown];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 1;
    CGFloat width = (self.bounds.size.width - margin) / 2;
    CGFloat height_u = (self.bounds.size.height - margin) * 3 / 4;
    CGFloat height_d = (self.bounds.size.height - margin) * 1 / 4;
    _leftUpView.frame = CGRectMake(0, 0, width, height_u);
    _rightUpView.frame = CGRectMake(width + margin, 0, width, height_u);
    _leftDownView.frame = CGRectMake(0, height_u + 1, width, height_d);
    _rightDownView.frame = CGRectMake(width + 1, height_u + 1, width, height_d);
}
@end


@interface PaxHomeBottomSubView()
@property (weak, nonatomic) UIView *leftUpView;
@property (weak, nonatomic) UIView *leftDownView;
@property (weak, nonatomic) UIView *rightUpView;
@property (weak, nonatomic) UIView *rightDownView;
@end

@implementation PaxHomeBottomSubView
- (instancetype)init
{
    if (self = [super init]) {
        [self setupBaseView];
    }
    return self;
}

- (void)setupBaseView
{
    UIView *leftUp =  [PaxHomeBottomImageView subImageViewWithImageName:@"http://i5.qhimg.com/t01de8b3480cf9686f9.jpg"];
    _leftUpView = leftUp;
//    leftUp.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:leftUp];
    
    UIView *leftDown =  [PaxHomeBottomImageView subImageViewWithImageName:@"http://appd.123.sogou.com/u/2015/11/5643244ecbbac.jpg"];
    _leftDownView = leftDown;
//    leftDown.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:leftDown];
    
    UIView *rightUp =  [PaxHomeBottomImageView subImageViewWithImageName:@"http://img4.duitang.com/uploads/item/201511/15/20151115202348_KZtj3.thumb.700_0.jpeg"];
    _rightUpView = rightUp;
//    rightUp.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:rightUp];
    
    UIView *rightDown =  [PaxHomeBottomImageView subImageViewWithImageName:@"http://image.game.uc.cn/2015/12/22/11729436.jpg"];
    _rightDownView = rightDown;
//    rightDown.backgroundColor = [UIColor cz_randomColor];
    [self addSubview:rightDown];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 1;
    CGFloat width = (self.bounds.size.width - margin) / 2;
    CGFloat height_u = (self.bounds.size.height - margin) / 2;
    _leftUpView.frame = CGRectMake(0, 0, width, height_u);
    _rightUpView.frame = CGRectMake(width + margin, 0, width, height_u);
    _leftDownView.frame = CGRectMake(0, height_u + 1, width, height_u);
    _rightDownView.frame = CGRectMake(width + 1, height_u + 1, width, height_u);
}


- (void)setupFont
{
    
}

- (void)setupColor
{
    
}
@end


@interface PaxHomeBottomImageView()
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation PaxHomeBottomImageView
+ (instancetype)subImageViewWithImageName:(NSString *)imageName
{
    PaxHomeBottomImageView *subView = [[self alloc]init];
    
    [subView setupBaseUI];
//    [subView.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placehold"]];
    subView.imageView.image = [UIImage imageNamed:@"pack"];
    return subView;
}
- (void)setupBaseUI
{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    _imageView = imageView;
    imageView.userInteractionEnabled = true;
    self.userInteractionEnabled = true;
    [self addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:tap];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}
- (void)click
{
    [PaxHUD Pax_showWithStatus:@"正在请求"];
//    [PaxHUD Pax_showWithLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PaxHUD Pax_showSuccessWithStatus:@"请求成功"];
//        [PaxHUD Pax_dismiss];
    });
}
@end
