//
//  UIView+CZAddition.h
//
//  Created by 刘凡 on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CZAddition)

/// 返回视图截图
- (UIImage *)cz_snapshotImage;
/**增加圆角以及颜色*/
- (void)backColor:(UIColor *)backColor cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth isShadow:(BOOL)isShadow;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)x;
- (CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
@end
