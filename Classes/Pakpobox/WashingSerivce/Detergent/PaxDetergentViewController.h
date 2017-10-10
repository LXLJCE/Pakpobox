//
//  PaxDetergentViewController.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/5.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaxDetergentModel;
typedef void(^ClickCellHandle)(PaxDetergentModel *model);
@interface PaxDetergentViewController : PaxBaseSubViewController
@property (strong, nonatomic) NSArray    *models;

@property (strong, nonatomic) ClickCellHandle    handle;
@end
