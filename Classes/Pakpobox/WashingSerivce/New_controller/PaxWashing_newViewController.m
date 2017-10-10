//
//  PaxWashing_newViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxWashing_newViewController.h"
#import "PaxWashingService_newViewController.h"
#import "PaxMyOrders_SubViewController.h"
@interface PaxWashing_newViewController ()

@end

@implementation PaxWashing_newViewController

/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//        [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
    [self setupUI];
    return self;
}

/**
 UI界面设置
 */
- (void)setupUI
{
    self.view.backgroundColor = [UIColor cz_colorWithRed:246 green:246 blue:246 ];
    self.navText = PaxLaundry;
    self.btn1Name = PaxWash;
    self.btn2Name = PaxDryCleaning;
    self.btn3Name = PaxCollectLaundry;
    self.imageName = @"snap3";
}
- (void)clickBtn1:(UIButton *)sender
{
    
    PaxWashingService_newViewController *wash = [[PaxWashingService_newViewController alloc]init];
    wash.order_type = @"LAUNDRY";
    wash.hidesBottomBarWhenPushed = true;
     [self.navigationController pushViewController:wash animated:true];

}

- (void)clickBtn2:(UIButton *)sender
{

    
    PaxWashingService_newViewController *wash = [[PaxWashingService_newViewController alloc]init];
    wash.order_type = @"DRY_CLEANING";
    wash.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:wash animated:true];
}

- (void)clickBtn3:(UIButton *)sender
{
    PaxMyOrders_SubViewController *myorder = [[PaxMyOrders_SubViewController alloc]init];
    myorder.navText = PaxCollectLaundry;
    [self.navigationController pushViewController:myorder animated:true];
}
@end
