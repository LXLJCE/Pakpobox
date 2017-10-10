//
//  PaxConfigSetting.h
//  Pakpobox
//
//  Created by 博兴 on 2017/2/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^FinishBlock)(id responseObject, NSError *error);
typedef void(^HUDMessageBlock)(NSString *message, NSDictionary *paramters);

// MARK: -CountryAndLanuage Setting
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


// MARK: - 登录界面的参数

#define Pax_Login_Top_Image_Height 130.0f
#define Pax_Login_Center_Login_Height 40.0f
#define Pax_Login_Center_Button_Height 50.0f
#define Pax_Login_Bottom_Button_Height 50.0f
// MARK: - 注册界面的参数
#define Pax_Regist_Top_Height 35.0f

#define Pax_Login_Center_TextField_Height 40.0f

#define Pax_Regist_BottomBtn_Height 40.0f

#define Pax_Regist_Bottom_margin 20.0f
#define Pax_Regist_XiyiLeft_Width 35.0f
#define Pax_Regist_SelectorPicker_Height 300.0f
#define Pax_Regist_RegistBtn_LR_Margin 20.f
#define Pax_Regist_Bottom_Button_Height 50.0f
// MARK: - 忘记密码界面设置
#define Pax_ForgetPass_Top  64 + 40.0f
#define Pax_ForgetPass_LeftRight 24.0f
#define Pax_ForgetPass_Height 180.0f
// MARK: - SMS界面设置
#define Pax_SMS_Top  64 + 40.0f
#define Pax_SMS_LeftRight 24.0f


// MARK: - Home
#define Pax_Home_Ad_Height 190.f
#define Pax_Home_center_LR_Margin 40.0f
#define Pax_Home_center_Height 100.0f


#define Pax_Home_WashingService_TopView_Height 100.0f
#define Pax_Home_WashingService_BottomView_Height 44.0f

