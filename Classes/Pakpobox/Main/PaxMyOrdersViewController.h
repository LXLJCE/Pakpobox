//
//  PaxMyOrdersViewController.h
//  Pakpobox
//
//  Created by 博兴 on 2017/4/19.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiSearchBar.h"
@interface PaxMyOrdersViewController : UIViewController
@property (nonatomic,strong) MiSearchBar *searchBar;
@property (nonatomic,strong) NSString *searchText;

@property (nonatomic,retain) UITableView *tableView;

@property (nonatomic,retain) NSMutableArray *arr;
@property (nonatomic,retain) NSMutableArray *resultArr;
@end
