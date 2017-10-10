//
//  LXLNetWorkTool.h
//  Application
//
//  Created by 博兴 on 2017/1/16.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum : NSUInteger {
    GET,
    POST,
} TKRequestMethod;


@interface LXLNetWorkTool : AFHTTPSessionManager


#pragma mark - 登陆接口
+(instancetype)shareTools;
/**
 登陆接口

 @param loginName 用户名
 @param password 密码
 @param loginType 登陆方式(可不传) : 默认：账号登录 (用户名+密码)
                            ACCOUNT 账号登录
                                MOBILE 手机号码登陆
                                MOBILE_QUICK 手机无密码快捷登录
 @param finish 返回值
 */
- (void)Pax_LoginWithTipMessage:(NSString *)tipMessage
                andLoginName:(NSString *)loginName
                   andPassword:(NSString *)password
                  andLoginType:(NSString *)loginType
                    WithFinish:(FinishBlock)finish;


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
                       andFinish:(FinishBlock)finish;


/**
 找回密码接口->email 通过邮箱找回

 @param tipMessage 提示message
 @param email email
 @param finish 回调
 */
- (void)Pax_RetrievePasswordWitnTipMessage:(NSString *)tipMessage
                                 andEmasil:(NSString *)email
                                andFinish:(FinishBlock)finish;



/**
 
 找回密码接口 ->code 验证吗
 @param tipMessage 提示message
 @param code code
 @param email email
 @param finish 回调
 */
- (void)Pax_CodeWitnTipMessage:(NSString *)tipMessage
                       andCode:(NSString *)code
                      andEmail:(NSString *)email
                     andFinish:(FinishBlock)finish;



/**
 重置密码

 @param tipMessage 提示信息
 @param token token
 @param password password
 @param finish 回调
 */
- (void)Pax_RestPasswordWithTipMessage:(NSString *)tipMessage
                       andToken:(NSString *)token
                      andPassword:(NSString *)password
                     andFinish:(FinishBlock)finish;



/**
 获取所有未取得包裹信息

 @param tipMessage 提示
 @param finish 回调
 */
- (void)Pax_unpickListWithTipMessage:(NSString *)tipMessage
                             andFinish:(FinishBlock)finish;

/**
 获取附近箱子

 @param finish 回调
 */
- (void)Pax_GetNearbyBoxWithTipMessage:(NSString *)tipMessage
                                      longitude:(CGFloat)longitude
                                        latitude:(CGFloat)latitude
                                        page :(NSInteger)page
                                        maxCount:(NSInteger)maxCount
                                        Finish:(FinishBlock)finish;



/**
 寄件下单

 @param tipMessage 提示语
 @param receiverName 收件人姓名
 @param receiverPhone 收件人手机
 @param deliveryBox 寄件From派宝箱
 @param recipientBox 收件To派宝箱 可为空
 @param payType 付款方式  ONLINE PAY_AT_LOCKER
 @param mouthSize 格口尺寸
 @param image 图片 需转成base64之后的数据
 @param credits 积分
 @param giftcardCode 优惠券
 @param sendType LOCKER_TO_LOCKER,
                LOCKER_TO_ADDRESS
 @parm finish 回调
 */
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
                                          Finish:(FinishBlock)finish;



/**
 退件下单

 @param tipMessage 提示语
 @param locker locker
 @param expressNumber 订单号
 @param mouthSize 大小
 @param finish 回调
 */
- (void)Pax_CreateReturnExpressOrderWithTipMessage:(NSString *)tipMessage
                                       locker:(NSDictionary *)locker
                                     expressNumber:(NSString *)expressNumber
                                         mouthSize:(NSString *)mouthSize
                                            Finish:(FinishBlock)finish;



/**
 获取服务价格列表

 @param tipMessage 提示语
 @param finish 回调函数
 */
- (void)Pax_GetServicePriceWithTipMessage:(NSString *)tipMessage
                                     type:(NSString *)type
                                   Finish:(FinishBlock)finish;





/**
 创建洗衣订单

 @param tipMessage 提示语
 @param login_name 会员名
 @param Phone 电话(可为空)
 @param amount amount(支付金额)
 @param giftcard_amount 优惠券支付金额(可为空)
 @param total_amount 总金额
 @param product_name 商品名称(可为空)
 @param product_desc 商品描述(可为空)
 @param goods_info 商品信息JSON 字符串 
 @param client_type IOS
 @param giftcard_no 优惠券编码 (可为空)
 @param Integral 使用积分(可为空)
 @param order_type 订单类型
 @param Box Location
 @param pay_type PAY_AT_LOCKER  NONE
 @param finish 回调
 */
- (void)Pax_WashCreateorderWithTipMessage:(NSString *)tipMessage
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
                                   Finish:(FinishBlock)finish;





/**
 获取我的订单

 @param tipMessage 提示语
 @param orderType 订单类型  寄件订单: DELIVERY_EXPRESS
                            退件单: RETURN_EXPRESS
                            洗衣服务: LAUNDRY_SERVICE
 @param page 页数 从0 开始
 @param maxCount 每页大小
 @param finish 回调
 */
- (void)Pax_GetMyOrdersWithTipMessage:(NSString *)tipMessage
                            orderType:(NSString *)orderType
                                 page:(NSInteger)page
                             maxCount:(NSInteger)maxCount
                                  Finish:(FinishBlock)finish;

/**
 退出登录

 @param tipMessage 提示语
 @param finish 回调
 */
- (void)Pax_logOutWithTipMessage:(NSString *)tipMessage
                          Finish:(FinishBlock)finish;

/**
 账号详情
 
 @param tipMessage 提示语
 @param finish 回调
 */
- (void)Pax_AccountInfoWithTipMessage:(NSString *)tipMessage
                          Finish:(FinishBlock)finish;



/**
 修改密码

 @param tipMessage 提示语
 @param password 新密码
 @param originalPassword 原始密码
 @param finish 回调
 */
- (void)Pax_updatePasswordWithTipMessage:(NSString *)tipMessage
                                password:(NSString *)password
                        originalPassword:(NSString *)originalPassword
                                  Finish:(FinishBlock)finish;


/**
 账号设置

 @param tipMessage 提示语
 @param openLocation 打开位置
 @param openAppNotify 打开通知
 @param openEmailNotify 打开email
 @param openSmsNotify 打开短信
 @param language 语言
 @param finish 回调
 */
- (void)Pax_settingWithTipMessage:(NSString *)tipMessage
                    openLocation:(BOOL)openLocation
                    openAppNotify:(BOOL)openAppNotify
                  openEmailNotify:(BOOL)openEmailNotify
                    openSmsNotify:(BOOL)openSmsNotify
                         language:(NSString *)language
                           Finish:(FinishBlock)finish;



/**
 订单详情

 @param tipMessage 提示语
 @param orderId 订单id
 @param finish 回调
 */
- (void)Pax_MyOrdersDetailWithTipMessage:(NSString *)tipMessage
                                detailID:(NSString *)orderId
                                  Finish:(FinishBlock)finish;



/**
 获取标签列表

 @param tipMessage 提示
 @param finish 回调
 */
- (void)Pax_GetInsterestTagWithTipMessage:(NSString *)tipMessage
                                    Finish:(FinishBlock)finish;


/**
 完善个人资料

 @param tipMessage 提示语
 @param ID id
 @param gender 性别  FEMALE 女 MALE 男
 @param birthday 生日 时间戳
 @param interestTags 兴趣数组
 @param finish 回调
 */
- (void)Pax_CompleteProfileWithTipMessage:(NSString *)tipMessage
                                       ID:(NSString *)ID
                                   gender:(NSString *)gender
                                 birthday:(NSTimeInterval)birthday
                             interestTags:(NSArray *)interestTags
                                   Finish:(FinishBlock)finish;


/**
 扫码取件

 @param tipMessage 提示
 @param qrcode 二维码扫描结果
 @param timestap 时间戳 毫秒值
 @param finish 回调
 */
- (void)Pax_ScanToUnlockWithTipMessage:(NSString *)tipMessage
                                qrcode:(NSString *)qrcode
                             timestamp:(NSString *)timestap
                                Finish:(FinishBlock)finish;




/**
 获取 商城 列表

 @param tipMessage 提示信息
 @param categoryType 分类
 @param finish 回调
 */
- (void)Pax_GetSampleListTipMessage:(NSString *)tipMessage
                       categoryType:(NSString *)categoryType
                             Finish:(FinishBlock)finish;



/**
 获取 商城 列表
 
 @param tipMessage 提示信息
 @param categoryID 分类
 @param finish 回调
 */
- (void)Pax_GetGoodsQueryTipMessage:(NSString *)tipMessage
                       categoryID:(NSString *)categoryID
                             Finish:(FinishBlock)finish;



/**
 创建洗衣订单
 
 @param tipMessage 提示语
 @param login_name 会员名
 @param Phone 电话(可为空)
 @param amount amount(支付金额)
 @param giftcard_amount 优惠券支付金额(可为空)
 @param total_amount 总金额
 @param product_name 商品名称(可为空)
 @param product_desc 商品描述(可为空)
 @param goods_info 商品信息JSON 字符串
 @param client_type IOS
 @param giftcard_no 优惠券编码 (可为空)
 @param Integral 使用积分(可为空)
 @param order_type 订单类型
 @param Box Location
 @param pay_type PAY_AT_LOCKER  NONE
 @param finish 回调
 */
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
                            Finish:(FinishBlock)finish;



/**
 第三方登录请求

 @param tipMessage 提示语
 @param appId facebook id
 @param openId openId
 @param accessToken accessToken
 @param openPlatformType 鹏泰
 @param clientType 终端
 @param finish 回调
 */
- (void)Pax_OpenLoginTipMessage:(NSString *)tipMessage
                          appId:(NSString *)appId
                         openId:(NSString *)openId
                    accessToken:(NSString *)accessToken
               openPlatformType:(NSString *)openPlatformType
                     clientType:(NSString *)clientType
                         Finish:(FinishBlock)finish;


- (void)Pax_SetPreferredBoxTipMessage:(NSString *)tipMessage
                         preferredBox:(NSDictionary *)preferredBox
                               Finish:(FinishBlock)finish;



- (void)Pax_GetNotificationsTipMessage:(NSString *)tipMessage
                                  page:(NSInteger)page
                              maxCount:(NSInteger)maxCount
                                Finish:(FinishBlock)finish;



- (void)Pax_bindXGTokenWithTipMessage:(NSString *)tipMessage
                            pushToken:(NSString *)pushToken
                     mobileClientType:(NSString *)mobileClientType
                               Finish:(FinishBlock)finish;

@end
