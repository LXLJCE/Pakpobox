//
//  PaxTimeLineModel.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/2.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxTimeLineModel.h"

@implementation PaxTimeLineModel


- (CGFloat)height
{
    // 顶部间距
    CGFloat height = 70.0;
//    height += 5;
//    height += 20;
//    height += 5;
//    
//    height += [_sub boundingRectWithSize:CGSizeMake(ScreenWidth - 28 - 2 * 40 , MAXFLOAT) // 用于计算文本绘制时占据的矩形块
//                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
//                              attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}        // 文字的属性
//                                 context:nil].size.height;
//    
//    height += 10;
    
    return height;
}

- (NSString *)time{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_createTime / 1000];
    NSString *ago = [date timeAgo];
    
    return [NSString stringWithFormat:@"%@",ago];
}
@end
