//
//  PaxParcel_packViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxParcel_packViewController.h"
#import "PaxParcelLockerToLockerViewController.h"
#import "PaxParcelLockerToAddressViewController.h"
@interface PaxParcel_packViewController ()

@end

@implementation PaxParcel_packViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.navText = PaxSender;
    self.btn1Name = PaxLockerToLocker;
    self.btn2Name = PaxLockerToAddress;
    self.imageName = @"snap3";
    self.view.backgroundColor = [UIColor cz_colorWithRed:246 green:246 blue:246 ];
   
}
- (void)clickBtn1:(UIButton *)sender
{
    PaxParcelLockerToLockerViewController *llVc = [[PaxParcelLockerToLockerViewController alloc]init];
    llVc.hidesBottomBarWhenPushed  = true;
    [self.navigationController pushViewController:llVc animated:true];
}

- (void)clickBtn2:(UIButton *)sender
{
    PaxParcelLockerToAddressViewController *laVc = [[PaxParcelLockerToAddressViewController alloc]init];
    laVc.hidesBottomBarWhenPushed  = true;
    [self.navigationController pushViewController:laVc animated:true];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
