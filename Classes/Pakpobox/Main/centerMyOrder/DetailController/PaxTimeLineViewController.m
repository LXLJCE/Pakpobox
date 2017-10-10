//
//  PaxTimeLineViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxTimeLineViewController.h"
#import "PaxTimeLineTableViewCell.h"
#import "PaxTimeLineModel.h"

@interface PaxTimeLineViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *models;
@end

static NSString *cellID = @"PaxTimeLineTableViewCell";

@implementation PaxTimeLineViewController

//- (NSArray *)models
//{
//    
//    NSMutableArray *array = [NSMutableArray array];
//    if(_models == nil){
//        
//        Boolean isShow = true;
//        for (int i = 0; i <= 10 ; i++) {
//            PaxTimeLineModel *model = [[PaxTimeLineModel alloc] init];
//            model.isShow = isShow;
//            model.sub = @"Order Received and ComfiredOrder Received and ComfiredOrder Received and ComfiredOrder Received and ComfiredOrder Received and ComfiredOrder Received and ComfiredOrder Received and Comfired";
//            if (i == 9) {
//                isShow = false;
//            }
//            [array addObject:model];
//        };
//        
//        _models = array;
//    }
//    return _models;
//}


- (void)setItems:(NSArray *)items
{
    _items = items;
    
    
    self.models = [PaxTimeLineModel mj_objectArrayWithKeyValuesArray:items];
    for (PaxTimeLineModel *model in self.models) {
        model.isShow = true;
    }
    [self.tableView reloadData];
}


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navText = @"Time Progress";
    
}


/**
 UI设置
 */
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = false;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 70) style:UITableViewStyleGrouped];
    _tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark - DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxTimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.models[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxTimeLineModel *model = self.models[indexPath.row];
    return model.height;
}
@end
