//
//  PaxAlertView.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/17.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxAlertView.h"

@implementation PaxAlertView
/*
 弹框样式
typedef NS_ENUM(NSInteger, SCLAlertViewStyle)
{
    SCLAlertViewStyleSuccess, // 成功
    SCLAlertViewStyleError, // 错误
    SCLAlertViewStyleNotice, // 通知
    SCLAlertViewStyleWarning, // 警告
    SCLAlertViewStyleInfo, // 内容
    SCLAlertViewStyleEdit, // 编辑
    SCLAlertViewStyleWaiting, // 等待
    SCLAlertViewStyleQuestion, // 问题
    SCLAlertViewStyleCustom // 自定义
};
 
  隐藏动画样式
 typedef NS_ENUM(NSInteger, SCLAlertViewHideAnimation)
 {
 SCLAlertViewHideAnimationFadeOut,
 SCLAlertViewHideAnimationSlideOutToBottom,
 SCLAlertViewHideAnimationSlideOutToTop,
 SCLAlertViewHideAnimationSlideOutToLeft,
 SCLAlertViewHideAnimationSlideOutToRight,
 SCLAlertViewHideAnimationSlideOutToCenter,
 SCLAlertViewHideAnimationSlideOutFromCenter,
 SCLAlertViewHideAnimationSimplyDisappear
 };

 开始动画样式
    typedef NS_ENUM(NSInteger, SCLAlertViewShowAnimation)
    {
    SCLAlertViewShowAnimationFadeIn,
    SCLAlertViewShowAnimationSlideInFromBottom,
    SCLAlertViewShowAnimationSlideInFromTop,
    SCLAlertViewShowAnimationSlideInFromLeft,
    SCLAlertViewShowAnimationSlideInFromRight,
    SCLAlertViewShowAnimationSlideInFromCenter,
    SCLAlertViewShowAnimationSlideInToCenter,
    SCLAlertViewShowAnimationSimplyAppear
    };
 
 背景颜色
 typedef NS_ENUM(NSInteger, SCLAlertViewBackground)
 {
 SCLAlertViewBackgroundShadow,
 SCLAlertViewBackgroundBlur,
 SCLAlertViewBackgroundTransparent
 };
*/



/**
 测试 SCLAlter
 */
- (void)testAlter{
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(@"Send", ^{ /*work here*/ });
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleWarning)
    .title(@"Title")
    .subTitle(@"Subtitle")
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    // or even
    showBuilder.show(builder.alertView, [UIApplication sharedApplication].keyWindow.rootViewController);
}
- (void)testAlter2{
    NSString *title = @"Title";
    NSString *message = @"Message";
    NSString *cancel = @"Cancel";
    NSString *done = @"Done";
    
    SCLALertViewTextFieldBuilder *textField = [SCLALertViewTextFieldBuilder new].title(@"Code");
    SCLALertViewButtonBuilder *doneButton = [SCLALertViewButtonBuilder new].title(done)
    .validationBlock(^BOOL{
        NSString *code = [textField.textField.text copy];
        //        return [code isVisible];
        NSLog(@"%@",code);
        return true;
    })
    .actionBlock(^{
        NSString *code = [textField.textField.text copy];
        //        [self confirmPhoneNumberWithCode:code];
        NSLog(@"%@",code);
    });
    
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .showAnimationType(SCLAlertViewShowAnimationFadeIn)
    .hideAnimationType(SCLAlertViewHideAnimationFadeOut)
    .shouldDismissOnTapOutside(NO)
    .addTextFieldWithBuilder(textField)
    .addButtonWithBuilder(doneButton);
    
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleCustom)
    .image([SCLAlertViewStyleKit imageOfInfo])
    .color([UIColor blueColor])
    .title(title)
    .subTitle(message)
    .closeButtonTitle(cancel)
    .duration(0.0f);
    
    [showBuilder showAlertView:builder.alertView onViewController:self];
}

@end
