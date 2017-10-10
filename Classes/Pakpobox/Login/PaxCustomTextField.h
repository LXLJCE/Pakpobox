//
//  PaxCustomTextField.h
//  Pakpobox
//
//  Created by 博兴 on 2017/2/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaxCustomTextField : UIView
//@property (copy, nonatomic) NSString *title;
//@property (copy, nonatomic) NSString *placeholder;
- (UITextField *)textFiled;
- (void)setPlaceholder:(NSString *)placeholder;
- (NSString *)placeholder;
- (void)setText:(NSString *)text;
- (NSString *)text;
- (void)setLineWidth:(CGFloat)lineWidth;
@property (nonatomic, assign) BOOL isSecuire;
@end
