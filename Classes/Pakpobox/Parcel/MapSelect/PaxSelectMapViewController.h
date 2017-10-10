//
//  PaxSelectMapViewController.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaxNearbyModel;
typedef void(^SelectLocation)(PaxNearbyModel *model);
    
@interface PaxSelectMapViewController : PaxBaseSubViewController
@property (strong, nonatomic) SelectLocation selectLoction;
@end
