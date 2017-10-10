//
//  PaxMyOrdersViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/19.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyOrdersViewController.h"
@interface PaxMyOrdersViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic) BOOL isSearch;//判断是否在搜索

@end
@implementation PaxMyOrdersViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    //    self.navigationItem.title = PaxNotification;
    _searchBar = [[MiSearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40) placeholder:@"搜索"];
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor redColor];
    [self.view addSubview:_searchBar];
    
    _searchText = @"";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 + 64, self.view.bounds.size.width, self.view.bounds.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _arr = [[NSMutableArray alloc] initWithObjects:@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您",@"Paxpobox 欢迎您", nil];
    _resultArr = [[NSMutableArray alloc]init];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(clickClose)];
    
}
- (void)clickClose
{
    [self dismissViewControllerAnimated:true completion:nil];
}
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.isSearch) {
        cell.textLabel.text = _resultArr[indexPath.row];
    }else{
        cell.textLabel.text = _arr[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        _searchText = @"";
        self.isSearch = NO;
        [self.tableView reloadData];
    }
    NSLog(@" --- %@",searchText);
    [_resultArr removeAllObjects];
    
    for (NSString *searchStr in _arr) {
        if ([searchStr rangeOfString:searchText].location != NSNotFound) {
            [_resultArr addObject:searchStr];
        }
    }
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.isSearch = NO;
    [self.tableView reloadData];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
