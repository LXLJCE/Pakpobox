//
//  PaxTableViewDelegateAndDateSource.h
//  Pakpobox
//
//  Created by 博兴 on 2017/3/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxTableViewDelegateAndDateSource : NSObject<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *cellID;
@end
