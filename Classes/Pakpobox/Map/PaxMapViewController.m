//
//  PaxMapViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMapViewController.h"

@interface PaxMapViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
/**
 googlemap
 */
@property (weak , nonatomic) GMSMapView *mapView;
@end

@implementation PaxMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navText = @"定位地点";
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:_coll zoom:14];
    GMSMapView *mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView = mapView_;
    mapView_.myLocationEnabled = YES;
    mapView_.frame = CGRectMake(0, 80, self.view.width, self.view.height - 80);
    [self.view addSubview:mapView_];
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    GMSMarker *mark = [GMSMarker markerWithPosition:_coll];
    mark.map = _mapView;
}

@end
