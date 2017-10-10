//
//  PaxCustomBtn.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxCustomBtn.h"

@implementation PaxCustomBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.titleLabel.frame.size.width, self.bounds.size.height);
}
@end
