//
//  PaxLRButton.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/30.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxRLButton.h"

@implementation PaxRLButton
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.frame = CGRectMake(0, 0, 80, self.height);
    self.titleLabel.frame = CGRectMake(80, 0, self.width - 80, self.height);
}
@end
