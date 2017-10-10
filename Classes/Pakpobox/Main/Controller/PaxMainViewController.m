//
//  PaxMainViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMainViewController.h"

//#import "PaxHomeViewController.h"
#import "PaxHow_newViewController.h"
#import "PaxAroundPaxViewController.h"
#import "PaxMineTableViewController.h"
//#import "PaxQRCodeViewController.h"
#import "SGQRCodeScanningVC.h"
#import "PaxNotificationViewController.h"
#import "PaxLoginViewController.h"
//#import "PaxMyOrdersViewController.h"
#import "PaxNotificationViewController.h"
@interface PaxMainViewController ()<BROptionButtonDelegate>


@end

@implementation PaxMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addChildrenViewController];
    self.selectedIndex = 0;
//    [self setupBROptionButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)childViewControllerWithVc:(UIViewController *)vc andTabbarTitle:(NSString *)tabbarTitle WithImageName:(NSString *)imageName
{
    
    PaxMainBaseNavController *nav = [[PaxMainBaseNavController alloc]initWithRootViewController:vc];
    nav.tabBarItem.title = tabbarTitle;
    if (imageName != nil) {
        nav.tabBarItem.image = [UIImage imageNamed:imageName];
    }
    
    PaxBigTitleViewController *bgvc = (PaxBigTitleViewController *)vc;
    
    bgvc.Navtext = tabbarTitle;
    [self addChildViewController:nav];
}
- (void)addChildrenViewController
{
    UIViewController *homeVc = [[PaxHow_newViewController alloc]init];
    
    [self childViewControllerWithVc:homeVc andTabbarTitle:PaxExplore WithImageName:@"home"];
    
    PaxAroundPaxViewController *homeVc1 = [[PaxAroundPaxViewController alloc]init];
    [self childViewControllerWithVc:homeVc1 andTabbarTitle:PaxAround WithImageName:@"location"];
  
    
    
//    PaxMyOrdersViewController *homeVc2 = [[PaxMyOrdersViewController alloc]init];
//    [self childViewControllerWithVc:homeVc2 andTabbarTitle:PaxMyOrders WithImageName:@"photo"];
    
    SGQRCodeScanningVC *homeVc2 = [[SGQRCodeScanningVC alloc]init];
    PaxMainBaseNavController *nav_vc2 = [[PaxMainBaseNavController alloc]initWithRootViewController:homeVc2];
    
    homeVc2.title = PaxScan;
    nav_vc2.tabBarItem.image = [UIImage imageNamed:@"Scan"];
    [self addChildViewController:nav_vc2];
    
    PaxNotificationViewController *homeVc3 = [[PaxNotificationViewController alloc]init];
    homeVc3.navigationItem.title = PaxNotification;
    [self childViewControllerWithVc:homeVc3 andTabbarTitle:PaxNotification WithImageName:@"notification"];
//    PaxMineTableViewController *homeVc4 = [[UIStoryboard storyboardWithName:@"PaxMineTableViewController" bundle:nil] instantiateInitialViewController];
    PaxMineTableViewController *homeVc4 = [[PaxMineTableViewController alloc]init];
    [self childViewControllerWithVc:homeVc4 andTabbarTitle:PaxMine WithImageName:@"user"];
}

- (void)setupBROptionButtons
{
    BROptionsButton *brOption = [[BROptionsButton alloc]initWithTabBar:self.tabBar forItemIndex:2 delegate:self];
    self.brOption = brOption;
    [brOption setImage: [UIImage imageNamed:@"up" ] forBROptionsButtonState: BROptionsButtonStateNormal];
    [brOption setImage: [UIImage imageNamed:@"down" ] forBROptionsButtonState: BROptionsButtonStateOpened];
}

- (NSInteger)brOptionsButtonNumberOfItems:(BROptionsButton *)brOptionsButton
{
    return 3;
}
- (void)brOptionsButton:(BROptionsButton *)brOptionsButton didSelectItem:(BROptionItem *)item
{
    NSLog(@"%zd",item.index);
//    [self.centerControllerView removeFromParentViewController];
    /*
     
     初始化所有 界面.  点击将前一个界面进行移除, 新界面进行添加
     */
    
    if (item.index == 0) {
        [self.tabBar removeObserver:brOptionsButton forKeyPath:@"selectedItem"];
        PaxLoginViewController *login = [[PaxLoginViewController alloc]init];
    
        
        PaxMainBaseNavController *nav = [[PaxMainBaseNavController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }else if(item.index == 1){

//        PaxMyOrdersViewController *ncvc = [[PaxMyOrdersViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:ncvc];
//        ncvc.Navtext = PaxMyOrders;
//        [self presentViewController:nav animated:true completion:nil];
        
        
        
    }else if(item.index == 2){
        /*PaxMainBaseNavController *qrcodevc = [[UIStoryboard storyboardWithName:@"PaxQRCodeViewController" bundle:nil] instantiateInitialViewController];
//        qrcodevc.navigationItem.title = PaxQRCODE ;
        [self presentViewController:qrcodevc animated:true completion:nil];
         */
        SGQRCodeScanningVC *ncvc = [[SGQRCodeScanningVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:ncvc];
//        ncvc.navigationItem.title = PaxQRCODE;
        [self presentViewController:nav animated:true completion:nil];
    }
   
//    [self setSelectedIndex:brOptionsButton.locationIndexInTabBar];
}

- (UIImage *)brOptionsButton:(BROptionsButton *)brOptionsButton imageForItemAtIndex:(NSInteger)index
{
    
    UIImage *image;
    switch (index) {
        case 2:
            image = [UIImage imageNamed:@"scan"];
            break;
        case 1:
            image = [UIImage imageNamed:@"order"];
            break;
        case 0:
            image = [UIImage imageNamed:@"logout"];
            break;
        default:
            break;
    }
    return image;
}

@end
