//
//  PaxWashingServiceViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/6.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxWashingServiceViewController.h"
#import "FullChildViewController.h"
#import "ChildViewController.h"
@interface PaxWashingServiceViewController ()
@property (weak, nonatomic) UISegmentedControl *seg;
@end

@implementation PaxWashingServiceViewController
#pragma mark - 懒加载


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = Pax_Bg_Grey;
    [self setupSegmentView];
    [self setAbount];
    [self setUpAllViewController];
//    [self setupBottomView];
    [self rac_event];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.hidesBottomBarWhenPushed = true;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.hidesBottomBarWhenPushed = false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAbount
{
    // 设置标题字体
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight,CGFloat *titleWidth) {
        
        // 设置标题字体
        *titleFont = [UIFont systemFontOfSize:13];
        
    }];
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        // 标题填充模式
        *underLineColor = [UIColor redColor];
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = YES;
}
// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 上衣
    FullChildViewController *wordVc1 = [[FullChildViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout  alloc] init]];
    wordVc1.title = PaxJacket;
    [self addChildViewController:wordVc1];
    
    // 上衣外套
    FullChildViewController *wordVc2 = [[FullChildViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout  alloc] init]];
    wordVc2.title = PaxSportsCoat;
    [self addChildViewController:wordVc2];
    
    // 裤装裙装
    FullChildViewController *wordVc3 = [[FullChildViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout  alloc] init]];
    wordVc3.title = PaxPants;
    [self addChildViewController:wordVc3];
    
    // 配件
    FullChildViewController *wordVc4 = [[FullChildViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout  alloc] init]];
    wordVc4.title = PaxAccessories;
    [self addChildViewController:wordVc4];
    
  
    
    
    
}
- (void)setupSegmentView
{
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:_items];
    seg.frame = CGRectMake(0, 0, ScreenWidth / 2.5, 30);
    self.navigationItem.titleView = seg;
    self.seg = seg;
    /*[seg setTintColor:[UIColor orangeColor]];*/
    [seg setTintColor:self.tineColor];
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName : _titleColor_nor} forState:UIControlStateNormal];
    
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName : _titleColor_sel} forState:UIControlStateSelected];
    seg.selectedSegmentIndex = 0;
    
}

- (void)setupBottomView{
    LXLWeakSelf(self);
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor cz_randomColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(Weakself.view);
        make.height.equalTo(@(Pax_Home_WashingService_BottomView_Height));
    }];
}

- (void)rac_event{
    [[self.seg rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(id x) {
       
    }];
}
@end


