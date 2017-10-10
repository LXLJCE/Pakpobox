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
#import "PaxNearbyModel.h"
#import "PaxNearbyTableViewCell.h"
#import "PaxLocationConvert.h"
@interface PaxAroundPaxViewController ()<CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate>


/**
 搜索按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

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


/**
 地点集合
 */
@property (strong, nonatomic) NSMutableArray *models;

/**
 当前页
 */
@property (assign, nonatomic) NSInteger currentPage;

/**
 大头针集合
 */
@property (strong, nonatomic) NSMutableArray *marks;

/**
 记录坐标
 */
@property (assign, nonatomic) CLLocationCoordinate2D coor;


/**
 当前位置
 */
@property (weak, nonatomic) UIButton *currentLocation;

/**
 刷新
 */
@property (weak, nonatomic) UIButton *refresh;


/**
 当前位置
 */
@property (assign, nonatomic) CLLocationCoordinate2D currentCoor;


/**
 当前标志
 */
//@property (weak, nonatomic) GMSMarker *MyLocationmarker;


//@property (assign, nonatomic) BOOL isnotFirst;


/**
 大头针标题
 */
@property (weak, nonatomic) UILabel *detailTitle;

/**
 大头针地址
 */
@property (weak, nonatomic) UILabel *address;



/**
 大头针内容
 */
@property (weak, nonatomic)UIView *detailView;

/**
 记录地图请求
 */
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

static NSString *cellID = @"PaxNearbyTableViewCell";

@implementation PaxAroundPaxViewController

- (NSMutableArray *)models
{
    if(_models == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _models = model;
    }
    return _models;
}

- (NSMutableArray *)marks
{
    if(_marks == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _marks = model;
    }
    return _marks;
}
/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = PaxAround;
    self.navTitle.hidden = true;
    
    self.listView.hidden = true;
    [self setupUI];
    
    [self setUpAndDown];
    [self setupText];
    
    
}

/**
 主界面UI设计
 */
- (void)setupUI
{
    [_search backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [_listView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self locationAuthorization];
}

/**
 根据经纬度定位

 @param latitude 维度
 @param longitude 精度
 */
- (void)setupGoogleMapWithLa:(CGFloat)latitude andLo: (CGFloat)longitude
{
    
    if (_mapView == nil) {
        GMSMutableCameraPosition *camera = [GMSMutableCameraPosition cameraWithLatitude:latitude
                                                                longitude:longitude
                                                                     zoom:11];
        GMSMapView *mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        self.mapView = mapView_;
        mapView_.delegate = self;
        mapView_.myLocationEnabled = YES;
        mapView_.frame = self.contentView.bounds;
        [self.contentView addSubview:mapView_];
        

        
        
        UIView *detailView = [[UIView alloc]init];
        [detailView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
        [_mapView addSubview:detailView];
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_mapView).offset(40);
            make.right.equalTo(_mapView).offset(-40);
            make.bottom.equalTo(_mapView).offset(-15);
            make.height.mas_equalTo(80);
        }];
        
        _detailView = detailView;
        
        UILabel *detailTitle = [[UILabel alloc]init];
        [detailView addSubview:detailTitle];
        [detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(detailView).offset(15);
            make.top.equalTo(detailView).offset(5);
            make.height.mas_equalTo(40);
        }];
        detailTitle.font = [UIFont boldSystemFontOfSize:16];
        detailTitle.textColor = Pax_Black;
        
        _detailTitle = detailTitle;
        
        UILabel *addressTitle = [[UILabel alloc]init];
        [detailView addSubview:addressTitle];
        [addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(detailView).offset(15);
            make.top.equalTo(detailTitle.mas_bottom);
            make.height.mas_equalTo(30);
        }];
        addressTitle.font = [UIFont systemFontOfSize:13];
        addressTitle.textColor = Pax_Black;
        _address = addressTitle;
        
        detailView.hidden = true;
        
        [self rac_event];
//        [self networkRequestWith:_coor];
        
    }
    
}

/**
 事件绑定
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_currentLocation rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _mapView.camera = [GMSMutableCameraPosition cameraWithTarget:_currentCoor zoom:14];
    }];
    [[_refresh rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself networkRequestWith:_coor];
    }];
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
//    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    _currentCoor = coordinate;
    
    [self setupGoogleMapWithLa:coordinate.latitude andLo: coordinate.longitude];
    
    
    // 2.停止定位
//    [manager stopUpdatingLocation];

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
    [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
//    self.listView .hidden = false;
//    if (self.perviousBtn == sender) {
//        
//    }else{
//    self.perviousBtn = sender;
//    [self moveBottomLine:sender];
//    }
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
    
    self.listView .hidden = true;
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
        
        [UIView animateWithDuration:0.5 animations:^{
            self.left_cons.constant = 20;
            [self.view layoutIfNeeded];
            
        }];
    }else if (_listBtn == sender){
        [UIView animateWithDuration:0.25 animations:^{
            self.left_cons.constant = 20 + ScreenWidth / 2;
            [self.view layoutIfNeeded];
        }];
    }else if (_savedBtn == sender){
        [UIView animateWithDuration:0.25 animations:^{
            self.left_cons.constant = 20 + ScreenWidth / 3 * 2;
            [self.view layoutIfNeeded];
        }];
    }
}


/**
 网络请求
 */

- (void)networkRequestWith:(CLLocationCoordinate2D)coor
{
    LXLWeakSelf(self);
    
    [[LXLNetWorkTool shareTools]Pax_GetNearbyBoxWithTipMessage:PaxGetting longitude:coor.longitude latitude:coor.latitude page:self.currentPage maxCount:20 Finish:^(id responseObject, NSError *error) {
        
        [Weakself clearMarker];
//        PaxLog(@"%@",responseObject);
        NSArray *result = responseObject[@"resultList"];
        
        
        if (result.count != 0) {
            [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
            Weakself.currentPage ++;
            
            [Weakself.models addObjectsFromArray:[PaxNearbyModel mj_objectArrayWithKeyValuesArray:result]];
            
            [_listView reloadData];
            [Weakself setMarkWithData:_models];
        }else{
            [PaxHUD Pax_showSuccessWithStatus:PaxSorroynoboxinside];
        }
        
        
        
        [_listView.mj_header endRefreshing];
        [_listView.mj_footer endRefreshing];

//        _isnotFirst = true;
    }];
}
- (void)clearMarker
{
    for (GMSMarker *mark in self.marks) {
        mark.map = nil;
    }
    [self.marks removeAllObjects];
}

#pragma mark - 设置上啦下拉
- (void)setUpAndDown
{
    self.currentPage = 0;
    MJRefreshHeader *header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(clickHeader)];
    _listView.mj_header =  header;
//    [_listView.mj_header beginRefreshing];
    MJRefreshAutoNormalFooter *footer= [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(clickFooter)];
    _listView.mj_footer =  footer;
    //    [self.myTableView.mj_footer beginRefreshing];
}
- (void)clickHeader
{
    [self.models removeAllObjects];
    self.currentPage = 0;
    [self networkRequestWith:_coor];
}
- (void)clickFooter
{
    
   [self networkRequestWith:_coor];
}

/**
 搜索

 @param sender btn
 */
- (IBAction)clickSearchBtn:(id)sender {
    
    _detailView.hidden = true;
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
    //TODO: 地图区域
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

#pragma mark - DataSource Detegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxNearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.model = self.models[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxNearbyModel *model = self.models[indexPath.row];
    _detailTitle.text = model.name;
    _address.text = model.address;
    
    [self clickMap:_mapBtn];
//    [self clearMarker];
   
//    GMSMarker *mark = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(model.latitude, model.longitude)];
//    mark.appearAnimation = kGMSMarkerAnimationPop;
//    mark.tappable = true;
//    mark.title = model.name;
//    mark.snippet = model.address;
//    mark.map = _mapView;
//    [self.marks addObject:mark];
    
    if (model.latitude ==0 || model.longitude == 0) {
        [PaxHUD Pax_showSuccessWithStatus:@"未知位置信息"];
    }else{
    GMSCameraPosition *position = [GMSCameraPosition cameraWithLatitude:model.latitude longitude:model.longitude zoom:12];
    _mapView.camera = position;
    }
//    [self mapView:_mapView didTapInfoWindowOfMarker:mark];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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

        [self.marks addObject:mark];
    }
}


#pragma mark - GMSMapViewDelegate
//点击大头针时调用
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    _detailView.hidden = false;
    _detailTitle.text = marker.title;
    _address.text = marker.snippet;
    
    return true;
}


- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    _detailView.hidden = true;
    LXLWeakSelf(self);
    if (_task != nil) {
        [_task cancel];
        _task = nil;
        NSLog(@"请求取消");
    }
    _task = [self mapAboutWith:@{@"latitude":@(position.target.latitude)
                                 ,@"longitude":@(position.target.longitude),
                                 @"maxCount":@20}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Weakself.task resume];
    });
    
    _coor = position.target;
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
                
                [Weakself.listView reloadData];
            }else{
                [PaxHUD Pax_showSuccessWithStatus:PaxSorroynoboxinside];
            }
            
        } else {
            // 解析失败
            
        }
    }];
    return task;
}



/**
 设置内容
 */
- (void)setupText
{
    [_searchBtn setTitle:PaxPleaseinputsearchaddress forState:UIControlStateNormal];
    [_mapBtn setTitle:PaxMAP forState:UIControlStateNormal];
    [_listBtn setTitle:PaxLIST forState:UIControlStateNormal];
    [_savedBtn setTitle:PaxSAVED forState:UIControlStateNormal];
}
@end
