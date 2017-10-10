//
//  PaxSelectMapViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSelectMapViewController.h"
#import "PaxNearbyModel.h"
@interface PaxSelectMapViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate>

/**
 搜索按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

/**
 顶部容器
 */
@property (weak, nonatomic) IBOutlet UIView *contentView;

/**
 地图容器
 */
@property (weak, nonatomic) IBOutlet UIView *mapContent;

/**
 大头针详细信息容器
 */
@property (weak, nonatomic) IBOutlet UIView *detail;

/**
 大头针名字
 */
@property (weak, nonatomic) IBOutlet UILabel *detailName;

/**
 大头针地址
 */
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;


/**
    用于存储点击的地址
 */
@property (strong,nonatomic) PaxNearbyModel *model;




/**
 大头针集合
 */
@property (strong, nonatomic) NSMutableArray *marks;
/**
 位置授权管理
 */
@property (nonatomic, strong) CLLocationManager* locationManager;


/**
 googlemap
 */
@property (weak , nonatomic) GMSMapView *mapView;

/**
 地点集合
 */
@property (strong, nonatomic) NSMutableArray *models;
@property (assign, nonatomic) CLLocationCoordinate2D coor;


/**
 记录地图请求
 */
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

@implementation PaxSelectMapViewController

- (NSMutableArray *)marks
{
    if(_marks == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _marks = model;
    }
    return _marks;
}

- (NSMutableArray *)models
{
    if(_models == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _models = model;
    }
    return _models;
}
/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_contentView backColor:Pax_White cornerRadius:6 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    self.navText = PaxMAP;
    self.view.backgroundColor = [UIColor cz_colorWithRed:246 green:246 blue:246];
    [_detail backColor:Pax_White cornerRadius:6 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [_searchBtn setTitle:PaxPleaseinputsearchaddress forState:UIControlStateNormal];
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

/**
 根据经纬度确定地图位置

 @param latitude 维度
 @param longitude 精度
 */
- (void)setupGoogleMapWithLa:(CGFloat)latitude andLo: (CGFloat)longitude
{
    
    if (_mapView == nil) {
        GMSMutableCameraPosition *camera = [GMSMutableCameraPosition cameraWithLatitude:latitude
                                                                              longitude:longitude
                                                                                   zoom:14];
        GMSMapView *mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        self.mapView = mapView_;
        mapView_.delegate = self;
        mapView_.myLocationEnabled = YES;
        mapView_.frame = self.mapContent.bounds;
        [self.mapContent addSubview:mapView_];
        _coor = CLLocationCoordinate2DMake(latitude, longitude);
//        [self networkRequestWith:_coor];
    }
    
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

- (IBAction)clickSearchBtn:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self clearMarker];
    [self dismissViewControllerAnimated:YES completion:nil];
    CLLocationCoordinate2D cll = place.coordinate;
    _mapView.camera = [GMSCameraPosition cameraWithTarget:cll zoom:14];

}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

/**
 网络请求
 */

- (void)networkRequestWith:(CLLocationCoordinate2D)coor
{
    LXLWeakSelf(self);
    
    [[LXLNetWorkTool shareTools]Pax_GetNearbyBoxWithTipMessage:PaxPleasewaitamomentLoad longitude:coor.longitude latitude:coor.latitude page:0 maxCount:100 Finish:^(id responseObject, NSError *error) {
        
        [Weakself clearMarker];
        //        PaxLog(@"%@",responseObject);
        NSArray *result = responseObject[@"resultList"];
        
        if (result.count != 0) {
            [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
            [Weakself.models addObjectsFromArray:[PaxNearbyModel mj_objectArrayWithKeyValuesArray:result]];
            
            [Weakself setMarkWithData:_models];
        }else{
            [PaxHUD Pax_showSuccessWithStatus:PaxSorroynoboxinside];
        }
       
       
        
    }];
}
/**
 根据数据添加大头针
 
 @param array 传入数据
 */
- (void)setMarkWithData:(NSArray *)array
{
    
    for (PaxNearbyModel *model in array) {
        if (model.latitude == 0 || model.longitude == 0 ) {
            break;
        }
        GMSMarker *mark = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(model.latitude, model.longitude)];
        mark.appearAnimation = kGMSMarkerAnimationPop;
        mark.tappable = true;
        mark.title = model.name;
        mark.snippet = model.address;
        mark.map = _mapView;
        mark.userData = model;
        [self.marks addObject:mark];
        
    }
}



- (void)clearMarker
{
    for (GMSMarker *mark in self.marks) {
        mark.map = nil;
    }
    [self.marks removeAllObjects];
}
#pragma mark - 点击了大头针
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    _detail.hidden = false;
    _detailName.text = marker.title;
    _detailAddress.text = marker.snippet;
    _model = marker.userData;
    return true;
}

/**
 点击了Detail

 @param sender btn
 */
- (IBAction)clickDetail:(id)sender {
    
    
    self.selectLoction(_model);
    [self.navigationController popViewControllerAnimated:true];
}




- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    _detail.hidden = true;
    LXLWeakSelf(self);
    if (_task != nil) {
        [_task cancel];
        _task = nil;
        NSLog(@"请求取消");
    }
    _task = [self mapAboutWith:@{@"latitude":@(position.target.latitude)
                                 ,@"longitude":@(position.target.longitude),
                                 @"maxCount":@100}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Weakself.task resume];
    });
    
    
}

/**
 地图相关
 */
- (NSURLSessionDataTask *)mapAboutWith:(NSDictionary *)parameters
{

    LXLWeakSelf(self);
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[[[LXLNetWorkTool shareTools].baseURL absoluteString]  stringByAppendingPathComponent:@"box/member/nearBox"]  parameters:parameters error:NULL];
    
    // 设置postBody
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"] ;
    [req setValue:token forHTTPHeaderField:@"userToken"];
    NSURLSessionDataTask *task = [[LXLNetWorkTool shareTools] dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            // 返回数据成功
            NSLog(@"请求成功");
            
            [Weakself clearMarker];
            NSArray *result = responseObject[@"resultList"];
            
            if (result.count != 0) {
                Weakself.models  = [PaxNearbyModel mj_objectArrayWithKeyValuesArray:result];
                
                [Weakself setMarkWithData:_models];
            }else{
                [PaxHUD Pax_showSuccessWithStatus:PaxSorroynoboxinside];
            }

        } else {
            // 解析失败
        
        }
    }];
    return task;
}
@end
