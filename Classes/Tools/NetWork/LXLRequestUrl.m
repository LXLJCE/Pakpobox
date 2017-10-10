//
//  LXLRequestUrl.m
//  Application
//
//  Created by 博兴 on 2017/1/16.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "LXLRequestUrl.h"

//
//  LXLRequestUrl.h
//  Application
//
//  Created by 博兴 on 2017/1/16.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 登陆请求
NSString *const url_user_login = @"member/login";

#pragma mark - 注册请求
NSString *const url_member_register = @"member/register";

#pragma mark - 找回密码
NSString *const url_retrievePassword = @"member/retrievePassword";

#pragma mark - 找回密码-验证
NSString *const url_retrievePasswordVerify = @"member/retrievePasswordVerify";
#pragma mark - 找回密码-重置密码
NSString *const url_resetPassword = @"member/resetPassword";
#pragma mark - 未取包裹列表
NSString *const url_unpickList = @"express/member/unpickList";

NSString *const url_nearby = @"box/member/nearBox";


#pragma mark - 寄件下单
NSString *const url_creatSendExpressOrder = @"express/member/createSendExpressOrder";

#pragma mark - 退件
NSString *const url_createReturnExpressOrde = @"express/member/createReturnExpressOrder";


#pragma mark - 洗衣服务 价格列表
NSString *const url_washmembergetServicePrice = @"wash/member/getServicePrice";
#pragma mark - 洗衣订单创建
NSString *const url_washcreate = @"order/create";

#pragma mark - 个人中心 退出登录
NSString *const url_memberlogout = @"member/logout";

#pragma mark - 个人中心 账号信息
NSString *const url_memberaccountInfo = @"member/accountInfo";


#pragma mark - 个人中心 修改密码
NSString *const url_memberupdatePassword = @"member/updatePassword";


#pragma mark - 个人中心 账号设置
NSString *const url_membersetting = @"member/setting";

#pragma mark - 个人订单管理
NSString *const url_myOrders = @"order/member/query";

#pragma mark - 订单详情
NSString *const url_myOrdersDetail = @"order/member/info";

#pragma mark - 兴趣标签
NSString *const url_interestTag = @"interestTag/list";

#pragma mark - 完善资料
NSString *const url_completeProfile = @"member/completeProfile";

#pragma mark - 扫码取件
NSString *const url_scanToUnlock = @"task/mouth/scanToUnlock";

#pragma mark - 商城分类列表
NSString *const url_goodList = @"goods/member/category/list";

#pragma mark - 商城列表
NSString *const url_goodsquery = @"goods/member/query";

#pragma mark - 样品商城订单
NSString *const url_createSample = @"order/createSample";


#pragma mark - 第三方开放平台登录
NSString *const url_memberOpenLogin = @"member/openLogin";

#pragma mark - 设置常用柜子
NSString *const url_setPreferredBox = @"member/setPreferredBox";

#pragma mark - 信鸽推送 Token绑定
NSString *const url_bindXGToken = @"member/bindPushToken";
