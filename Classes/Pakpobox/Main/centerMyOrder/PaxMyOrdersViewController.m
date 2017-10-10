//
//  PaxMyOrdersViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/19.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyOrdersViewController.h"
#import "PaxMyOrdersTableViewCell.h"
#import "PaxMyOdersDetailViewController.h"
#import "PaxMyOrderModel.h"
@interface PaxMyOrdersViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView *tableView;
/**
 数据存储arr
 */
@property (nonatomic,retain) NSMutableArray *arr;

/**
 当前页
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 每页最大值
 */
@property (nonatomic, assign) NSInteger maxCount;
@end
// cellID
static NSString *cellID = @"MyOrderCell";

@implementation PaxMyOrdersViewController
- (NSMutableArray *)arr
{
    if(_arr == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _arr = model;
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = Pax_Bg_Grey;
    
    [self setupTableview];
    self.currentPage = 0;
    self.maxCount = 20;
    
    [self setUpAndDown];
    
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


/**
 设置tableview
 */
- (void)setupTableview
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(24, 80, self.view.bounds.size.width- 2 * 24, self.view.bounds.size.height - 80) style:UITableViewStylePlain];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PaxMyOrdersTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


#pragma mark - 数据源代理方法

#pragma mark - 数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 3;
    //    }else{
    //        return 10;
    //
    //    }
    return self.arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxMyOrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.arr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [PaxHUD Pax_showErrorWithStatus:@"没有对应接口获取数据"];
    PaxMyOdersDetailViewController *orderDetail = [[PaxMyOdersDetailViewController alloc]init];
    orderDetail.model = self.arr[indexPath.row];
    orderDetail.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:orderDetail animated:true];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10.0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0.01;
//    }else{
//        return 30;
//    }
//}


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [[UIView alloc]init];
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return [[UIView alloc]init];
//    }else{
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"Past Orders";
//        label.font = Pax_Font_Button;
//        label.bounds = CGRectMake(0, 0, tableView.width, 30);
//        label.backgroundColor = Pax_Bg_Grey;
//        return label;
//    }
//
//}




/**
 点击监听
 
 @param touches 手势
 @param event 事件
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.tableView reloadData];
}


- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_GetMyOrdersWithTipMessage:@"正在获取,请稍后..." orderType:@"" page:self.currentPage maxCount:self.maxCount Finish:^(id responseObject, NSError *error) {
        NSArray *list = responseObject[@"resultList"];
        if (list == 0) {
            [PaxHUD showSuccessWithStatus:@"对不起,没有更多数据了"];
        }else{
            [PaxHUD showSuccessWithStatus:@"获取成功"];
            [Weakself.arr addObjectsFromArray:[PaxMyOrderModel mj_objectArrayWithKeyValuesArray:list]];
            Weakself.currentPage++;
            
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_header endRefreshing];
        [Weakself.tableView.mj_footer endRefreshing];
    }];
}
@end
