//
//  PaxParcel_newViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxHow_newViewController.h"
//#import "STBannerView.h"
#import "XGPush.h"
#import "PaxWashing_newViewController.h"
#import "PaxParcel_newViewController.h"
#import "PaxSamplesViewController.h"
#import "PaxActivateSamplesViewController.h"
#import "PaxCreditsViewController.h"
@interface PaxHow_newViewController ()<SDCycleScrollViewDelegate>

/**
 拥有多少积分
 */
@property (weak, nonatomic) IBOutlet UILabel *haveCreditsTitle;

/**
 获取
 */
@property (weak, nonatomic) IBOutlet UILabel *moreCrrdits;

@property (weak, nonatomic) IBOutlet UILabel *jumpIn;

@property (weak, nonatomic) IBOutlet UILabel *parcels;
@property (weak, nonatomic) IBOutlet UILabel *parcelsDetail;
@property (weak, nonatomic) IBOutlet UILabel *laundry;

@property (weak, nonatomic) IBOutlet UILabel *lanudryDetail;
@property (weak, nonatomic) IBOutlet UILabel *ShopGlobally;

@property (weak, nonatomic) IBOutlet UILabel *ShopGloballyDetails;







/**
 点击获取更多积分

 @param sender sender
 */
- (IBAction)clickMoreCredits:(id)sender;

/**
 顶部广告轮播
 */
@property (weak, nonatomic) IBOutlet UIView *BannerView;
//@property (weak, nonatomic) STBannerView *topView;



/**
 点击Parcels

 @param sender sender
 */
- (IBAction)clickParcels:(id)sender;
/**
 点击Laundry
 
 @param sender sender
 */
- (IBAction)clickLaundry:(id)sender;
/**
 点击ShopGloblly
 
 @param sender sender
 */
- (IBAction)clickShopGlobally:(id)sender;
@end

@implementation PaxHow_newViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor cz_colorWithRed:246 green:246 blue:246 ];
    [self setupUI];
    [self setupText];
}

/**
 界面UI
 */
- (void)setupUI
{

    // 本地加载图片的轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth - 2 * 16, 190) imageNamesGroup:@[@"snap2",@"snap3",@"snap2"]];
    [self.BannerView backColor:[UIColor clearColor] cornerRadius:6 borderColor:[UIColor clearColor]  borderWidth:0 isShadow:false];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    cycleScrollView.backgroundColor = [UIColor clearColor];
    cycleScrollView.delegate = self;
    [self.BannerView addSubview:cycleScrollView];
   
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    LXLWeakSelf(self);
    NSDictionary *user = [PaxDataSave getUserMessage];
    if( user[@"gender"] == nil|| [user[@"gender"] isEqualToString:@""]){
        //TODO: 第一次设置兴趣
        
        PaxActivateSamplesViewController *sim = [[PaxActivateSamplesViewController alloc]init];
        sim.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:sim animated:true];
        
    }else{
    
    
   
    PaxSamplesViewController *sm = [[PaxSamplesViewController alloc]init];
    sm.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:sm animated:true];

    }
      }
     

- (IBAction)clickParcels:(id)sender {
    
    PaxParcel_newViewController *parcelVc = [[PaxParcel_newViewController alloc] init];

    [self.navigationController pushViewController:parcelVc animated:true];
}


- (IBAction)clickLaundry:(id)sender{
    PaxWashing_newViewController *washingVc = [[PaxWashing_newViewController alloc] init];
 
    [self.navigationController pushViewController:washingVc animated:true];
}
- (IBAction)clickShopGlobally:(id)sender
{
    [PaxHUD Pax_showSuccessWithStatus:PaxDevelopingPleasecontinuetofocuson];
}
- (IBAction)clickMoreCredits:(id)sender {
    PaxCreditsViewController *cre = [[PaxCreditsViewController alloc]init];
    
    [self.navigationController pushViewController:cre animated:true];
}


/**
 界面文字的设置
 */
- (void)setupText{
//   _haveCreditsTitle.text = []
    [[LXLNetWorkTool shareTools] Pax_AccountInfoWithTipMessage:nil Finish:^(id responseObject, NSError *error) {
        
        [PaxDataSave saveUserMessage:responseObject];
        _haveCreditsTitle.text = [NSString stringWithFormat:@"%@ %zd %@",PaxYouhave,[responseObject[@"integral"] intValue],Paxcreditsavailable];
    }];
    _moreCrrdits.text = Paxgetmorecredits;
    _jumpIn.text = PaxJumpin;
    _parcels.text = PaxParcels;
    _parcelsDetail.text = PaxCollecsendorreturnitemsyou;
    _laundry.text = PaxLaundry;
    _lanudryDetail.text = PaxGetyourlaundrydonethroughtasimplewash;
    _ShopGlobally.text = PaxShopglobally;
    _ShopGloballyDetails.text = PaxStopworryingabouthighshipingcostsbysettingupavirturaladdresstoday;
    
    
    NSDictionary *user = [PaxDataSave getUserMessage];
    [XGPush setAccount:user[@"id"] successCallback:^{
        NSLog(@"%@",user[@"id"]);
        NSString *deviceToken = [PaxDataSave getDeviceToken];
        [[LXLNetWorkTool shareTools]Pax_bindXGTokenWithTipMessage:@"" pushToken:deviceToken mobileClientType:@"IOS" Finish:^(id responseObject, NSError *error) {
            
        }];
        
    } errorCallback:^{
        NSLog(@"Error");
    }];
}

@end
