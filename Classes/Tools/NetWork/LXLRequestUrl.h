//
//  LXLRequestUrl.h
//  Application
//
//  Created by 博兴 on 2017/1/16.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 登陆请求
UIKIT_EXTERN NSString *const url_user_login;

#pragma mark - 注册请求
UIKIT_EXTERN NSString *const url_member_register;

#pragma mark - 找回密码
UIKIT_EXTERN NSString *const url_retrievePassword;
#pragma mark - 找回密码-验证
UIKIT_EXTERN NSString *const url_retrievePasswordVerify;
#pragma mark - 找回密码-重置密码
UIKIT_EXTERN NSString *const url_resetPassword;

#pragma mark - 未取包裹列表
UIKIT_EXTERN NSString *const url_unpickList;
#pragma mark - 周围箱子
UIKIT_EXTERN NSString *const url_nearby;

#pragma mark - 寄件下单
UIKIT_EXTERN NSString *const url_creatSendExpressOrder;


#pragma mark - 退件
UIKIT_EXTERN NSString *const url_createReturnExpressOrde;


#pragma mark - 洗衣服务 价格列表
UIKIT_EXTERN NSString *const url_washmembergetServicePrice;

#pragma mark - 洗衣订单创建
UIKIT_EXTERN NSString *const url_washcreate;


#pragma mark - 个人中心 退出登录
UIKIT_EXTERN NSString *const url_memberlogout;

#pragma mark - 个人中心 账号信息
UIKIT_EXTERN NSString *const url_memberaccountInfo;


#pragma mark - 个人中心 修改密码
UIKIT_EXTERN NSString *const url_memberupdatePassword;


#pragma mark - 个人中心 账号设置
UIKIT_EXTERN NSString *const url_membersetting;


#pragma mark - 个人订单管理
UIKIT_EXTERN NSString *const url_myOrders;

#pragma mark - 订单详情
UIKIT_EXTERN NSString *const url_myOrdersDetail;

#pragma mark - 兴趣标签
UIKIT_EXTERN NSString *const url_interestTag;

#pragma mark - 完善资料
UIKIT_EXTERN NSString *const url_completeProfile;


#pragma mark - 扫码取件
UIKIT_EXTERN NSString *const url_scanToUnlock;

#pragma mark - 商城分类列表
UIKIT_EXTERN NSString *const url_goodList;


#pragma mark - 商城列表
UIKIT_EXTERN NSString *const url_goodsquery;

#pragma mark - 样品商城订单
UIKIT_EXTERN NSString *const url_createSample;

#pragma mark - 第三方开放平台登录
UIKIT_EXTERN NSString *const url_memberOpenLogin;

#pragma mark - 设置常用柜子
UIKIT_EXTERN NSString *const url_setPreferredBox;


#pragma mark - 信鸽推送 Token绑定
UIKIT_EXTERN NSString *const url_bindXGToken;
