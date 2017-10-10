//
//  ViewController.h
//  miSearch
//
//  Created by miicaa_ios on 16/8/3.
//  Copyright (c) 2016年 xuxuezheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiSearchBar.h"
@interface PaxNotificationViewController : PaxBigTitleViewController

@property (nonatomic,strong) MiSearchBar *searchBar;
@property (nonatomic,strong) NSString *searchText;

@property (nonatomic,retain) UITableView *tableView;

@property (nonatomic,retain) NSMutableArray *arr;
@property (nonatomic,retain) NSMutableArray *resultArr;
@end

