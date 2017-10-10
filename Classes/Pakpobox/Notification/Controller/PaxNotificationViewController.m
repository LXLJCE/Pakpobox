//
//  ViewController.m
//  miSearch
//
//  Created by miicaa_ios on 16/8/3.
//  Copyright (c) 2016年 xuxuezheng. All rights reserved.
//

#import "PaxNotificationViewController.h"
#import "PaxNotificationCell.h"
#import "PaxNotificationDetailController.h"
@interface PaxNotificationViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic) BOOL isSearch;//判断是否在搜索

@property (assign, nonatomic) NSInteger num; // 虚拟数据用于显示行数



@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger maxCount;

@end

// cellid
static NSString *cellId = @"NotificationCell";
@implementation PaxNotificationViewController


/**
 声明周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor cz_colorWithRed:246 green:246 blue:246];
    self.arr = [NSMutableArray array];
    self.resultArr = [NSMutableArray array];
    [self setupSearchBar];
    [self setupTableView];
    [self setUpAndDown];
//    [self networkRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequest) name:@"remote" object:nil];
    
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
}

/**
 网络请求
 */
- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_GetNotificationsTipMessage:PaxPleasewaitamomentLoad page:self.currentPage maxCount:20  Finish:^(id responseObject, NSError *error) {
        
        NSArray *result = responseObject[@"resultList"];
        if (result.count == 0) {
            [PaxHUD Pax_showSuccessWithStatus:PaxSorrnodatayouwant];
        }else{
        
//            for (NSDictionary *dict in result) {
//                [Weakself.arr addObject:dict];
//            }
            Weakself.arr = [NSMutableArray arrayWithArray:result];
            [Weakself.tableView reloadData];
            
        }
        [Weakself.tableView.mj_header endRefreshing];
        [Weakself.tableView.mj_footer endRefreshing];
    }];
}


/**
 设置searchBar
 */
- (void)setupSearchBar
{
    //    self.navigationItem.title = PaxNotification;
    _searchBar = [[MiSearchBar alloc] initWithFrame:CGRectMake(16, 80, self.view.bounds.size.width - 2 * 18, 50) placeholder:PaxSearchMessage];
    _searchBar.delegate = self;
    //    _searchBar.barTintColor = [UIColor redColor];
    [_searchBar backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [self.view addSubview:_searchBar];
    
    _searchText = @"";
}

/**
 设置tableView
 */
- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(18, 135, self.view.bounds.size.width - 2 * 16, self.view.bounds.size.height - 135) style:UITableViewStylePlain];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    //    _arr = [[NSMutableArray alloc] initWithObjects:@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您", nil];
    //    _resultArr = [[NSMutableArray alloc]init];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PaxNotificationCell" bundle:nil] forCellReuseIdentifier:cellId];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = false;
    _tableView.showsVerticalScrollIndicator = false;
    
    // 虚拟行数
    _num = 10;
}


#pragma mark - 数据源代理方法 - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        return _resultArr.count ;
    }else{
        return _arr.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (self.isSearch) {
        cell.dict = self.resultArr[indexPath.row];

    }else{
        cell.dict = self.arr[indexPath.row];

    }
        return cell;
}

/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    PaxNotificationDetailController *detail = [[PaxNotificationDetailController alloc]init];
    detail.Detail_title = @"Order #2538 Delivery Notice";
    detail.time = @"15 minutes ago";
    detail.Detail_content = @"This an automated message to inform you that your order has arrived at windsor house and is a this name china This an automated message to inform you that your order has arrived at windsor house and is a this name china This an automated message to inform you that your order has arrived at windsor house and is a this name china This an automated message to inform you that your order has arrived at windsor house and is a this name china";
    [self.navigationController pushViewController:detail animated:true];
}
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [dataArray removeObjectAtIndex:indexPath.row];
        _num--;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
#pragma mark - 代理方法 searchbar
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        _searchText = @"";
        self.isSearch = NO;
        [self.tableView reloadData];
    }
    NSLog(@" --- %@",searchText);
    [_resultArr removeAllObjects];
    
    
    for (NSDictionary *dict in _arr){
    
        NSString *searchStr = dict[@"title"];
        if ([searchStr rangeOfString:searchText].location != NSNotFound) {
            [_resultArr addObject:dict];
        }
    }
    
//    for (NSString *searchStr in _arr) {
//        
//    }
    if (_resultArr.count) {
        self.isSearch = YES;
        [self.tableView reloadData];
    }
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.isSearch = NO;
}

#pragma mark - 手势监听
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.isSearch = NO;
    [self.tableView reloadData];
}




#pragma mark - 系统方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark - 设置上啦下拉
- (void)setUpAndDown
{
    self.currentPage = 0;
    MJRefreshHeader *header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(clickHeader)];
    self.tableView.mj_header =  header;
    [self.tableView.mj_header beginRefreshing];
    MJRefreshAutoNormalFooter *footer= [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(clickFooter)];
    self.tableView.mj_footer =  footer;
    //    [self.myTableView.mj_footer beginRefreshing];
}
- (void)clickHeader
{
    [self.arr removeAllObjects];
    self.currentPage = 0;
    [self networkRequest];
}
- (void)clickFooter
{
    
    [self networkRequest];
}

@end
