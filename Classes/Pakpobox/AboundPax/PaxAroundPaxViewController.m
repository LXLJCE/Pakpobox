//
//  PaxAroundPaxViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/6.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxAroundPaxViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface PaxAroundPaxViewController ()<CLLocationManagerDelegate>

/**
 位置授权管理
 */
@property (nonatomic, strong) CLLocationManager* locationManager;

/**
 googlemap
 */
@property (weak , nonatomic) GMSMapView *mapView;
/**
 内容视图, 可以添加三个不同内容
 */
@property (weak, nonatomic) IBOutlet UIView *contentView;


/**
 搜索
 */
@property (weak, nonatomic) IBOutlet UIView *search;

/**
 map
 */
@property (weak, nonatomic) IBOutlet UIButton *mapBtn;

/**
 list
 */
@property (weak, nonatomic) IBOutlet UIButton *listBtn;

/**
 saved
 */
@property (weak, nonatomic) IBOutlet UIButton *savedBtn;

/**
 bottomLine
 */
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

/**
 约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_cons;


/**
 listView
 */
@property (weak, nonatomic) IBOutlet UITableView *listView;


/**
 记录上一次点击按钮
 */
@property (weak, nonatomic) UIButton *perviousBtn;
@end

@implementation PaxAroundPaxViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = PaxAround;
    self.navTitle.hidden = true;
    self.view.backgroundColor = Pax_White;
    self.listView.hidden = true;
    [self setupUI];
    
    [[LXLNetWorkTool shareTools]Pax_GetNearbyBox:113.88071 latitude:22.569349 page:1 maxCount:100 Finish:^(id responseObject, NSError *error) {
        
    }];
    
}

/**
 主界面UI设计
 */
- (void)setupUI
{
    [_search backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self locationAuthorization];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupGoogleMapWithLa:(CGFloat)latitude andLo: (CGFloat)longitude
{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:14];
    GMSMapView *mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView = mapView_;
    mapView_.myLocationEnabled = YES;
    mapView_.frame = self.contentView.bounds;
    [self.contentView addSubview:mapView_];
    

//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(22.290664, 114.195304);
//    marker.title = @"香港";
//    marker.snippet = @"Hong Kong";
//    marker.map = mapView_;
}




/*
    定位授权
 */

- (void)locationAuthorization{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self findMe];
}


- (void)findMe
{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    NSLog(@"start gps");
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    [self setupGoogleMapWithLa:coordinate.latitude andLo: coordinate.longitude];
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

/**
 方法监听
 */
- (IBAction)clickSaved:(UIButton *)sender {
    self.listView .hidden = false;
    if (self.perviousBtn == sender) {
        
    }else{
    self.perviousBtn = sender;
    [self moveBottomLine:sender];
    }
}
- (IBAction)clickList:(UIButton *)sender {
    self.listView .hidden = false;
    if (self.perviousBtn == sender) {
        
    }else{
        self.perviousBtn = sender;
        [self moveBottomLine:sender];
    }
}
- (IBAction)clickMap:(UIButton *)sender {
    self.listView .hidden = false;
    if (self.perviousBtn == sender) {
        
    }else{
        self.perviousBtn = sender;
        [self moveBottomLine:sender];
    }
}


/**
 bottomLine 移动 是否坐或者右移
 */
- (void)moveBottomLine:(UIButton *)sender{
    if (_mapBtn == sender) {
        [UIView animateWithDuration:0.25 animations:^{
            self.left_cons.constant = 20;
            [self.view setNeedsLayout];
        }];
    }else if (_listBtn == sender){
        [UIView animateWithDuration:0.25 animations:^{
            self.left_cons.constant = 20 + ScreenWidth / 3;
            [self.view setNeedsLayout];
        }];
    }else if (_savedBtn == sender){
        [UIView animateWithDuration:0.25 animations:^{
            self.left_cons.constant = 20 + ScreenWidth / 3 * 2;
            [self.view setNeedsLayout];
        }];
    }
}
@end
