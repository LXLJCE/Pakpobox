//
//  PaxShopCollectionViewCell.h
//  Pakpobox
//
//  Created by 博兴 on 2017/5/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  PaxSampleShopModel;
typedef void(^ClickPlus)(PaxSampleShopModel *model);


@interface PaxShopCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) PaxSampleShopModel    *model;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) ClickPlus    clickPlus;
@end
