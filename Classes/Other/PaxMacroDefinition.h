//
//  PaxMacroDefinition.h
//  Pakpobox
//
//  Created by 博兴 on 2017/2/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>
// MARK: -界面宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// MARK: -对于self弱化
#define LXLWeakSelf(type)  __weak typeof(type) Weakself = type;




@interface PaxMacroDefinition : NSObject

@end 
