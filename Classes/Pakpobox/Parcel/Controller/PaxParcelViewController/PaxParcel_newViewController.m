//
//  PaxParcel_newViewController.m
//  Pakpobox
//
//  Created by Merry Christmas on 2017/4/25.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxParcel_newViewController.h"
#import "PaxParcel_packViewController.h"
#import "PaxReturn_newViewController.h"
#import "PaxMyOrders_SubViewController.h"
@interface PaxParcel_newViewController ()

@end

@implementation PaxParcel_newViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupUI];
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
    self.navText = PaxParcels;
    self.btn1Name = PaxSender;
    self.btn2Name = PaxReturn;
    self.btn3Name = PaxCollection;
    self.imageName = @"snap2";
}
- (void)clickBtn1:(UIButton *)sender
{
    PaxParcel_packViewController *pack = [[PaxParcel_packViewController alloc]init];
    pack.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:pack animated:true];
}

- (void)clickBtn2:(UIButton *)sender
{
    PaxReturn_newViewController *returnvc = [[PaxReturn_newViewController alloc]init];
    returnvc.hidesBottomBarWhenPushed = true;
     [self.navigationController pushViewController:returnvc animated:true];
}

- (void)clickBtn3:(UIButton *)sender
{
    
    [self networkRequestCollect];
    
    
}

/**
 取件的列表
 */
- (void)networkRequestCollect
{
//    LXLWeakSelf(self);
//    [[LXLNetWorkTool shareTools]Pax_unpickListWithTipMessage:@"正在获取" andFinish:^(id responseObject, NSError *error) {
//        [PaxHUD Pax_showSuccessWithStatus:@"获取成功"];
//        
    
        PaxMyOrders_SubViewController *myorder = [[PaxMyOrders_SubViewController alloc]init];
        myorder.navText = PaxCollection;
        [self.navigationController pushViewController:myorder animated:true];
//    }];
}
@end
