//
//  PaxHomeViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxHomeViewController.h"
#import "PaxHomeTopView.h"
#import "PaxHomeCenterView.h"
#import "PaxHomeBottomView.h"
#import "PaxWashingService1ViewController.h"
#import "PaxWashingServiceViewController.h"
#import "PaxParcelViewController.h"
#import "PaxSamplesViewController.h"
#import "PaxActivateSamplesViewController.h"
@interface PaxHomeViewController ()
@property (weak, nonatomic) UIView *centerView;
@property (weak, nonatomic) PaxHomeTopView *topView;

@property (assign, nonatomic) BOOL isFirstLogin;
@end

@implementation PaxHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationItem.title = PaxPaxName;
    [self setupBaseView];
    [self rac_event];
    [self setupFont];
    [self setupColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupBaseView
{
    LXLWeakSelf(self);
    PaxHomeTopView *topView = [[PaxHomeTopView alloc]init];
    _topView = topView;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(Weakself.view);
        make.top.equalTo(Weakself.view).offset(100);
        make.height.equalTo(@(Pax_Home_Ad_Height));
    }];

    PaxHomeCenterView *centerView = [[PaxHomeCenterView alloc]init];
    self.centerView = centerView;
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(Weakself.view);
        make.height.equalTo(@(Pax_Home_center_Height));
    }];
    
    PaxHomeBottomView *bottomView = [[PaxHomeBottomView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_bottom);
        make.left.right.equalTo(Weakself.view);
        make.bottom.equalTo(Weakself.view).offset(-44);
    }];
}
//MARK: -事件监听
/*
 - (void)clickExpressageBtn{}
 - (void)clickWashingBtn{}
 - (void)clickLeaseBtn{}
 - (void)clickTransferBtn{}
 */
- (void)rac_event{
    LXLWeakSelf(self);
    [[self.centerView rac_signalForSelector:@selector(clickExpressageBtn)]subscribeNext:^(id x) {
        PaxParcelViewController *parcelVc = [[PaxParcelViewController alloc] init];
        parcelVc.tineColor = Pax_Color_Home_Parcel_Segment_Back;
        parcelVc.titleColor_nor = Pax_Color_Home_Parcel_Segment_Title_Nor;
        parcelVc.titleColor_sel = Pax_Color_Home_Parcel_Segment_Title_Seg;
        parcelVc.items = @[PaxSender,PaxReturn];
        parcelVc.rightImageName = @"collect";
        parcelVc.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:parcelVc animated:true];
    }];
    [[self.centerView rac_signalForSelector:@selector(clickWashingBtn)]subscribeNext:^(id x) {
        
        _isFirstLogin = !_isFirstLogin;
        if (_isFirstLogin) {
            
        PaxWashingService1ViewController *washingVc = [[PaxWashingService1ViewController alloc] init];
//        washingVc.tineColor = [UIColor blueColor];
//        washingVc.items = @[@"洗衣",@"干洗"];
        
        washingVc.tineColor = Pax_Color_Home_Parcel_Segment_Back;
        washingVc.titleColor_nor = Pax_Color_Home_Parcel_Segment_Title_Nor;
        washingVc.titleColor_sel = Pax_Color_Home_Parcel_Segment_Title_Seg;
        washingVc.items = @[PaxWash,PaxDryCleaning];
        washingVc.rightImageName = @"collect";
        washingVc.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:washingVc animated:true];
        }else{
            PaxWashingServiceViewController *washingVc = [[PaxWashingServiceViewController alloc] init];
            //        washingVc.tineColor = [UIColor blueColor];
            //        washingVc.items = @[@"洗衣",@"干洗"];
            
            washingVc.tineColor = Pax_Color_Home_Parcel_Segment_Back;
            washingVc.titleColor_nor = Pax_Color_Home_Parcel_Segment_Title_Nor;
            washingVc.titleColor_sel = Pax_Color_Home_Parcel_Segment_Title_Seg;
            washingVc.items = @[PaxWash,PaxDryCleaning];
//            washingVc.rightImageName = @"collect";
            washingVc.hidesBottomBarWhenPushed = true;
            
            [Weakself.navigationController pushViewController:washingVc animated:true];
        }
        
    }];
    [[self.centerView rac_signalForSelector:@selector(clickLeaseBtn)]subscribeNext:^(id x) {
        
    }];
    [[self.centerView rac_signalForSelector:@selector(clickTransferBtn)]subscribeNext:^(id x) {
        
    }];
    
    //TODO: 顶部view事件
    _topView.ClickTopView = ^(){
        
        UIViewController *pushVc;
        _isFirstLogin = !_isFirstLogin;
        if (_isFirstLogin) {
            pushVc = [[PaxActivateSamplesViewController alloc]init];
        }else{
            pushVc = [[PaxSamplesViewController alloc]init];
        }
        pushVc.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:pushVc animated:true];
    };
    
}

- (void)setupFont
{

}

- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
}
@end
