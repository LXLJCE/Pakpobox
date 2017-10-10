//
//  LXLNetWorkTool.m
//  Application
//
//  Created by 博兴 on 2017/1/16.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "LXLNetWorkTool.h"
#import "LXLRequestUrl.h"
#import "PaxRequestRegual.h"
@interface LXLNetWorkTool ()

@end
#define Post @"POST"
#define Get @"GET"

typedef enum : NSUInteger {
    Login,
    Regist,
    forgotPassword,
} NAME;

@implementation LXLNetWorkTool

- (void)TestWith:(NAME)name reponseObject:(id)responseObject{
    
    switch (name) {
        case Login:
            
            break;
            
        default:
            break;
    }
    
}



+(instancetype)shareTools{
    
    static LXLNetWorkTool *tools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://47.90.16.40:18080/ebox/api/v1/"];
        
        tools =[[self alloc]initWithBaseURL:url];
        
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        tools.requestSerializer.timeoutInterval = 10.0f;
//        tools.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    });
    
    return tools;
}
#pragma mark - 登陆接口
- (void)Pax_LoginWithTipMessage:(NSString *)tipMessage
                   andLoginName:(NSString *)loginName
                    andPassword:(NSString *)password
                   andLoginType:(NSString *)loginType
                     WithFinish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_loginWithLoginName:loginName andPassword:password andLoginType:loginType WithMessage:^(NSString *message, NSDictionary *parameters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //TODO: 模仿网络延迟
             [Weakself Pax_requestMethod:Post Url:url_user_login Parameters:parameters finish:finish];
        });
       
        
    }];
   
}
#pragma mark - 注册
/**
 注册
 
 @param tipMessage 提醒文字
 @param phoneNumber 电话号码 可以为空
 @param name 姓名
 @param email 邮箱
 @param loginName 登录名
 @param password 密码
 @param inviteCode 推荐人
 @param registerType ios
 @param lanuage 语言
 @param country 国家
 @param finish 返回值
 */
- (void)Pax_RegistWithTipMessage:(NSString *)tipMessage
                 andPhoneNumberL:(NSString *)phoneNumber
                         andName:(NSString *)name
                        andEmail:(NSString *)email
                    andLoginName:(NSString *)loginName
                     andPassword:(NSString *)password
                   andInviteCode:(NSString *)inviteCode
                 andRegisterType:(NSString *)registerType
                      andLanuage:(NSString *)lanuage
                      andCountry:(NSString *)country
                       andFinish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_registWithPhoneNumberL:phoneNumber andName:name andEmail:email andLoginName:loginName andPassword:password andInviteCode:inviteCode andRegisterType:registerType andLanuage:lanuage andCountry:country WithMessage:^(NSString *message,NSDictionary *parameters) {
        //TODO: 关于弹出框的处理
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //TODO: 模仿网络延迟
            [Weakself Pax_requestMethod:Post Url:url_member_register Parameters:parameters finish:finish];
        });
        
    }];
}

#pragma mark - 忘记密码
/**
 忘记密码接口
 
 @param tipMessage 提示message
 @param phone 手机号
 @param email email
 @param finish 回调
 */
- (void)Pax_RetrievePasswordWitnTipMessage:(NSString *)tipMessage
                                 andEmasil:(NSString *)email
                                 andFinish:(FinishBlock)finish;
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_retrievePasswordWithEmasil:email  WithMessage:^(NSString *message, NSDictionary *parameters) {
        
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //TODO: 模仿网络延迟
            [Weakself Pax_requestMethod:Post Url:url_retrievePassword Parameters:parameters finish:finish];
        });
    }];
}

- (void)Pax_CodeWitnTipMessage:(NSString *)tipMessage
                       andCode:(NSString *)code
                      andEmail:(NSString *)email
                     andFinish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_CodeWithEmail:email andCode:code  WithMessage:^(NSString *message, NSDictionary *parameters) {
        
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //TODO: 模仿网络延迟
            [Weakself Pax_requestMethod:Post Url:url_retrievePasswordVerify Parameters:parameters finish:finish];
        });
    }];
}

- (void)Pax_RestPasswordWithTipMessage:(NSString *)tipMessage
                              andToken:(NSString *)token
                           andPassword:(NSString *)password
                             andFinish:(FinishBlock)finish{

    LXLWeakSelf(self);
    [PaxRequestRegual request_RestPasswordWithToken:token andPassword:password  WithMessage:^(NSString *message, NSDictionary *parameters) {
        
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //TODO: 模仿网络延迟
            [Weakself Pax_requestMethod:Post Url:url_resetPassword Parameters:parameters finish:finish];
        });
    }];
}
- (void)Pax_unpickListWithTipMessage:(NSString *)tipMessage
                           andFinish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //TODO: 模仿网络延迟
        [Weakself Pax_requestMethod:Post Url:url_unpickList Parameters:nil finish:finish];
    });

    
}

- (void)Pax_GetNearbyBoxWithTipMessage:(NSString *)tipMessage
                             longitude:(CGFloat)longitude
                              latitude:(CGFloat)latitude
                                 page :(NSInteger)page
                              maxCount:(NSInteger)maxCount
                                Finish:(FinishBlock)finish;
{
    LXLWeakSelf(self);
   [PaxRequestRegual requet_nearbyBoxWithlongitude:longitude latitude:latitude page:page maxCount:maxCount WithMessage:^(NSString *message, NSDictionary *paramters) {
       [Weakself HudWithMessage:message andTipMessage:tipMessage];
       
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           //TODO: 模仿网络延迟
           [Weakself Pax_requestMethod:Get Url:url_nearby Parameters:paramters finish:finish];
       });
   }];

}

- (void)Pax_CreateSendExpressOrderWithTipMessage:(NSString *)tipMessage
                                    ReceiverName:(NSString *)receiverName
                                   receiverPhone:(NSString *)receiverPhone
                                     deliveryBox:(NSDictionary *)deliveryBox
                                    recipientBox:(NSDictionary *)recipientBox
                                    recipientAddress:(NSDictionary *)recipientAddress
                                         payType:(NSString *)payType
                                       mouthSize:(NSString *)mouthSize
                                           image:(UIImage *)image
                                         credits:(NSInteger)credits
                                    giftcardCode:(NSString *)giftcardCode
                                        sendType:(NSString *)sendType
                                          Finish:(FinishBlock)finish{

    LXLWeakSelf(self);
    [PaxRequestRegual requet_CreateSendExpressOrderReceiverName:receiverName receiverPhone:receiverPhone deliveryBox:deliveryBox recipientBox:recipientBox recipientAddress:recipientAddress payType:payType mouthSize:mouthSize image:image credits:credits giftcardCode:giftcardCode sendType:sendType  WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //TODO: 模仿网络延迟
            [Weakself Pax_requestMethod:Post Url:url_creatSendExpressOrder Parameters:paramters finish:finish];
        });
    }];
    
}

- (void)Pax_CreateReturnExpressOrderWithTipMessage:(NSString *)tipMessage
                                            locker:(NSDictionary *)locker
                                     expressNumber:(NSString *)expressNumber
                                         mouthSize:(NSString *)mouthSize
                                            Finish:(FinishBlock)finish{

    LXLWeakSelf(self);
    [PaxRequestRegual request_CreateReturnExpressOrderlocker:locker expressNumber:expressNumber mouthSize:mouthSize  WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //TODO: 模仿网络延迟
            [Weakself Pax_requestMethod:Post Url:url_createReturnExpressOrde Parameters:paramters finish:finish];
        });
    }];
    

}
- (void)Pax_GetServicePriceWithTipMessage:(NSString *)tipMessage
                                     type:(NSString *)type
                                   Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [Weakself HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //TODO: 模仿网络延迟
        [Weakself Pax_requestMethod:Get Url:url_washmembergetServicePrice Parameters:@{@"type":type} finish:finish];
    });
}

- (void)Pax_logOutWithTipMessage:(NSString *)tipMessage
                          Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //TODO: 模仿网络延迟
        [Weakself Pax_requestMethod:Post Url:url_memberlogout Parameters:nil finish:finish];
    });
}

- (void)Pax_AccountInfoWithTipMessage:(NSString *)tipMessage
                               Finish:(FinishBlock)finish{
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //TODO: 模仿网络延迟
        [Weakself Pax_requestMethod:Get Url:url_memberaccountInfo Parameters:nil finish:finish];
    });
}

- (void)Pax_updatePasswordWithTipMessage:(NSString *)tipMessage password:(NSString *)password originalPassword:(NSString *)originalPassword Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_updatePasswordPassword:password originalPassword:originalPassword WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_memberupdatePassword Parameters:paramters finish:finish];
        });
    }];
}

- (void)Pax_settingWithTipMessage:(NSString *)tipMessage openLocation:(BOOL)openLocation openAppNotify:(BOOL)openAppNotify openEmailNotify:(BOOL)openEmailNotify openSmsNotify:(BOOL)openSmsNotify language:(NSString *)language Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_settingWithOpenLocation:openLocation openAppNotify:openAppNotify openEmailNotify:openEmailNotify openSmsNotify:openSmsNotify language:language WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_membersetting Parameters:paramters finish:finish];
        });
    }];

}

- (void)Pax_WashCreateorderWithTipMessage:(NSString *)tipMessage login_name:(NSString *)login_name Phone:(NSString *)Phone amount:(float)amount giftcardamount:(float)giftcard_amount totalamount:(float)total_amount productname:(NSString *)product_name productdesc:(NSString *)product_desc goodsinfo:(NSString *)goods_info clienttype:(NSString *)client_type giftcardno:(NSString *)giftcard_no Integral:(NSInteger)Integral ordertype:(NSString *)order_type Box:(NSDictionary *)Box paytype:(NSString *)pay_type Finish:(FinishBlock)finish
{

    LXLWeakSelf(self);
    [PaxRequestRegual request_WashCreateorderLogin_name:login_name Phone:Phone amount:amount giftcardamount:giftcard_amount totalamount:total_amount productname:product_name productdesc:product_desc goodsinfo:goods_info clienttype:client_type giftcardno:giftcard_no Integral:Integral ordertype:order_type Box:Box paytype:pay_type  WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_washcreate Parameters:paramters finish:finish];
        });
    }];
    
}
- (void)Pax_CreateSampleTipMessage:(NSString *)tipMessage
                        login_name:(NSString *)login_name
                             Phone:(NSString *)Phone
                            amount:(float)amount
                    giftcardamount:(float)giftcard_amount
                       totalamount:(float)total_amount
                       productname:(NSString *)product_name
                       productdesc:(NSString *)product_desc
                         goodsinfo:(NSString *)goods_info
                        clienttype:(NSString *)client_type
                        giftcardno:(NSString *)giftcard_no
                          Integral:(NSInteger)Integral
                         ordertype:(NSString *)order_type
                               Box:(NSDictionary *)Box
                           paytype:(NSString *)pay_type
                            Finish:(FinishBlock)finish{
    LXLWeakSelf(self);
    [PaxRequestRegual request_WashCreateorderLogin_name:login_name Phone:Phone amount:amount giftcardamount:giftcard_amount totalamount:total_amount productname:product_name productdesc:product_desc goodsinfo:goods_info clienttype:client_type giftcardno:giftcard_no Integral:Integral ordertype:order_type Box:Box paytype:pay_type  WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_createSample Parameters:paramters finish:finish];
        });
    }];
}

- (void)Pax_GetMyOrdersWithTipMessage:(NSString *)tipMessage orderType:(NSString *)orderType page:(NSInteger)page maxCount:(NSInteger)maxCount Finish:(FinishBlock)finish
{

    LXLWeakSelf(self);
    [PaxRequestRegual request_GetMyOrdersWithOrderType:orderType page:page maxCount:maxCount   WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_myOrders Parameters:paramters finish:finish];
        });
    }];
}

- (void)Pax_MyOrdersDetailWithTipMessage:(NSString *)tipMessage
                                detailID:(NSString *)orderId
                                  Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [Weakself Pax_requestMethod:Get Url:[NSString stringWithFormat:@"%@/%@",url_myOrdersDetail,orderId] Parameters:nil finish:finish];
    });
}
- (void)Pax_GetInsterestTagWithTipMessage:(NSString *)tipMessage
                                   Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Weakself Pax_requestMethod:Get Url:url_interestTag Parameters:nil finish:finish];
    });


}

- (void)Pax_CompleteProfileWithTipMessage:(NSString *)tipMessage
                                       ID:(NSString *)ID
                                   gender:(NSString *)gender
                                 birthday:(NSTimeInterval)birthday
                             interestTags:(NSArray *)interestTags
                                   Finish:(FinishBlock)finish{
    
    LXLWeakSelf(self);
    [PaxRequestRegual request_CompleteProfileWithID:ID gender:gender birthday:birthday interestTags:interestTags    WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_completeProfile Parameters:paramters finish:finish];
        });
    }];
}

- (void)Pax_ScanToUnlockWithTipMessage:(NSString *)tipMessage
                                qrcode:(NSString *)qrcode
                             timestamp:(NSString *)timestap
                                Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_ScanToUnlockWithQrcode:qrcode timestamp:timestap  WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_scanToUnlock Parameters:paramters finish:finish];
        });
    }];
}


- (void)Pax_GetSampleListTipMessage:(NSString *)tipMessage
                       categoryType:(NSString *)categoryType
                             Finish:(FinishBlock)finish{
    LXLWeakSelf(self);
    [PaxRequestRegual request_GetSampleListCategoryType:categoryType   WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Get Url:url_goodList Parameters:paramters finish:finish];
        });
    }];

}
- (void)Pax_GetGoodsQueryTipMessage:(NSString *)tipMessage
                         categoryID:(NSString *)categoryID
                             Finish:(FinishBlock)finish
{

    LXLWeakSelf(self);
   
        [Weakself HudWithMessage:nil andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Get Url:url_goodsquery Parameters:@{@"categoryId" : categoryID} finish:finish];
        });
    
}

- (void)Pax_OpenLoginTipMessage:(NSString *)tipMessage
                          appId:(NSString *)appId
                         openId:(NSString *)openId
                    accessToken:(NSString *)accessToken
               openPlatformType:(NSString *)openPlatformType
                     clientType:(NSString *)clientType
                         Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [PaxRequestRegual request_OpenLoginTipAppId:appId openId:openId accessToken:accessToken openPlatformType:openPlatformType clientType:clientType    WithMessage:^(NSString *message, NSDictionary *paramters) {
        [Weakself HudWithMessage:message andTipMessage:tipMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself Pax_requestMethod:Post Url:url_memberOpenLogin Parameters:paramters finish:finish];
        });
    }];

}

- (void)Pax_SetPreferredBoxTipMessage:(NSString *)tipMessage
                         preferredBox:(NSDictionary *)preferredBox
                               Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Weakself Pax_requestMethod:Post Url:url_setPreferredBox Parameters:@{@"preferredBox":preferredBox} finish:finish];
    });
}

- (void)Pax_GetNotificationsTipMessage:(NSString *)tipMessage
page:(NSInteger)page maxCount:(NSInteger)maxCount Finish:(FinishBlock)finish
{
    
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Weakself Pax_requestMethod:Get Url:@"notification/query" Parameters:@{@"page":@(page), @"maxCount":@(maxCount)} finish:finish];
    });
}

- (void)Pax_bindXGTokenWithTipMessage:(NSString *)tipMessage
                            pushToken:(NSString *)pushToken
                     mobileClientType:(NSString *)mobileClientType
                               Finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    [self HudWithMessage:nil andTipMessage:tipMessage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Weakself Pax_requestMethod:Post Url:url_bindXGToken Parameters:@{@"pushToken": pushToken, @"mobileClientType":mobileClientType} finish:finish];
    });
}
#pragma mark - 对于弹出框处理
- (void)HudWithMessage:(NSString *)message andTipMessage:(NSString *)tipMessage
{
    message == nil? [PaxHUD dismiss] : [PaxHUD Pax_showErrorWithStatus:message];
    
    if (message != nil) {
        return ;
    }
    
    if (tipMessage != nil) {
        [PaxHUD Pax_showWithStatus:tipMessage];
    }
}
#pragma mark 请求总方法

/**
 请求总方法

 @param method 方法名
 @param url 接口
 @param parameters 参数
 @param finish 返回值
 */
- (void)Pax_requestMethod:(NSString *)method Url:(NSString *)url Parameters:(NSDictionary *)parameters finish:(FinishBlock)finish
{
    LXLWeakSelf(self);
    if ([method  isEqual: Get]) {
            // TODO: Get请求方法
        NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:Get URLString:[[self.baseURL absoluteString]  stringByAppendingPathComponent:url]  parameters:parameters error:NULL];
        
        // 设置postBody
        NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"] ;
        [req setValue:token forHTTPHeaderField:@"userToken"];
        [[self dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                // 返回数据成功
                [Weakself disposeToResponseObject:responseObject error:nil  finish:finish];
            } else {
                // 解析失败
                [Weakself disposeToResponseObject:nil error:error  finish:finish];
            }
        }] resume];
        
    }else{
        // TODO: Post请求方法

        
        NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:Post URLString:[[self.baseURL absoluteString]  stringByAppendingPathComponent:url]  parameters:parameters error:NULL];
        
        // 设置postBody
        NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"] ;
        [req setValue:token forHTTPHeaderField:@"userToken"];
        [[self dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

            if (!error) {
                // 返回数据成功
                [Weakself disposeToResponseObject:responseObject error:nil  finish:finish];
            } else {
                // 解析失败
                [Weakself disposeToResponseObject:responseObject error:error  finish:finish];
            }
        }] resume];
    }
}



/**
 处理返回值

 @param responseObject 返回值
 */
- (void)disposeToResponseObject:(id)responseObject error:(NSError *)error finish:(FinishBlock)finish
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            if (responseObject == nil) {
                [PaxHUD Pax_showErrorWithStatus:@"服务器中断"];
            }else{
            [PaxHUD Pax_showErrorWithStatus:responseObject[@"errorMessage"]];
            }
        }else{
            [PaxHUD dismiss];
            finish(responseObject,nil);
        }
    });
    
}
- (void)ErrorCodeAnlayzeWithNum:(NSString *)number
{


}
@end
