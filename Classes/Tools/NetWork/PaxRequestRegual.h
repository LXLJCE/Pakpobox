//
//  PaxRequestRegual.h
//  Pakpobox
//
//  Created by 博兴 on 2017/3/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaxRequestRegual : NSObject

/**
 校验 登陆接口参数

 @param loginName 登陆名
 @param password 密码
 @param loginType 登陆类型
 @param messageBlock block回调
 */
+ (void)request_loginWithLoginName:(NSString *)loginName
                       andPassword:(NSString *)password
                      andLoginType:(NSString *)loginType
                       WithMessage:(HUDMessageBlock)messageBlock;


/**
 校验注册参数

 @param phoneNumber 电话号码
 @param name 用户姓名
 @param email email
 @param loginName 通过邮箱注册的话loginName 与 email 相同
 @param password 用户密码
 @param inviteCode 注册邀请码
 @param registerType 注册类型 iOS
 @param lanuage 语言
 @param country 国家
 @param messageBlock 回调
 */
+ (void)request_registWithPhoneNumberL:(NSString *)phoneNumber
                         andName:(NSString *)name
                        andEmail:(NSString *)email
                    andLoginName:(NSString *)loginName
                     andPassword:(NSString *)password
                   andInviteCode:(NSString *)inviteCode
                 andRegisterType:(NSString *)registerType
                      andLanuage:(NSString *)lanuage
                      andCountry:(NSString *)country
                       WithMessage:(HUDMessageBlock)messageBlock;
/**
 忘记密码接口

 @param email email
 @param messageBlock 回调
 */
+ (void)request_retrievePasswordWithEmasil:(NSString *)email
                               WithMessage:(HUDMessageBlock)messageBlock;



/**
 忘记密码验证

 @param email email
 @param code code
 @param messageBlock 回调
 */
+ (void)request_CodeWithEmail:(NSString *)email
                      andCode:(NSString *)code
                  WithMessage:(HUDMessageBlock)messageBlock;



/**
 重置密码

 @param Token userToken
 @param password password
 @param messageBlock 回调
 */
+ (void)request_RestPasswordWithToken:(NSString *)Token
                      andPassword:(NSString *)password
                  WithMessage:(HUDMessageBlock)messageBlock;
/**
 校验附近

 @param longitude 精度
 @param latitude 未读
 @param page 页数
 @param maxCount 条数
 @param messageBlock 返回值
 */
+ (void)requet_nearbyBoxWithlongitude:(CGFloat)longitude
                             latitude:(CGFloat)latitude
                                 page:(NSInteger)page
                             maxCount:(NSInteger)maxCount
                          WithMessage:(HUDMessageBlock)messageBlock;


/**
 寄件下单
 @param receiverName 收件人姓名
 @param receiverPhone 收件人手机
 @param deliveryBox 寄件From派宝箱
 @param recipientBox 收件To派宝箱 可为空
 @param payType 付款方式  ONLINE PAY_AT_LOCKER
 @param mouthSize 格口尺寸
 @param image 图片 需转成base64之后的数据
 @param credits 积分
 @param giftcardCode 优惠券
 @param sendType LOCKER_TO_LOCKER,LOCKER_TO_ADDRESS
 @param messageBlock 回调
 */
+ (void)requet_CreateSendExpressOrderReceiverName:(NSString *)receiverName
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
                                        WithMessage:(HUDMessageBlock)messageBlock;

/**
 退件下单

 @param locker locker
 @param expressNumber 订单号
 @param mouthSize 大小
 @param messageBlock 回调
 */
+ (void)request_CreateReturnExpressOrderlocker:(NSDictionary *)locker
                                     expressNumber:(NSString *)expressNumber
                                         mouthSize:(NSString *)mouthSize
                                            WithMessage:(HUDMessageBlock)messageBlock;

/**
 修改密码

 @param password 新密码
 @param originalPassword 原始密码
 @param messageBlock 回调
 */
+ (void)request_updatePasswordPassword:(NSString *)password
                        originalPassword:(NSString *)originalPassword
                                  WithMessage:(HUDMessageBlock)messageBlock;


/**
 账号设置
 
 @param openLocation 打开位置
 @param openAppNotify 打开通知
 @param openEmailNotify 打开email
 @param openSmsNotify 打开短信
 @param language 语言
 @param messageBlock 回调
 */
+ (void)request_settingWithOpenLocation:(BOOL)openLocation
                    openAppNotify:(BOOL)openAppNotify
                  openEmailNotify:(BOOL)openEmailNotify
                    openSmsNotify:(BOOL)openSmsNotify
                         language:(NSString *)language
                           WithMessage:(HUDMessageBlock)messageBlock;


/**
 创建洗衣订单
 
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
 @param messageBlock 回调
 */
+ (void)request_WashCreateorderLogin_name:(NSString *)login_name
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
                                   WithMessage:(HUDMessageBlock)messageBlock;



/**
 获取我的订单
 
 @param orderType 订单类型  寄件订单: DELIVERY_EXPRESS
 退件单: RETURN_EXPRESS
 洗衣服务: LAUNDRY_SERVICE
 @param page 页数 从0 开始
 @param maxCount 每页大小
 @param messageBlock 回调
 */
+ (void)request_GetMyOrdersWithOrderType:(NSString *)orderType
                                 page:(NSInteger)page
                             maxCount:(NSInteger)maxCount
                               WithMessage:(HUDMessageBlock)messageBlock;


/**
 完善个人资料
 
 @param ID id
 @param gender 性别  FEMALE 女 MALE 男
 @param birthday 生日 时间戳
 @param interestTags 兴趣数组
 @param messageBlock 回调
 */
+ (void)request_CompleteProfileWithID:(NSString *)ID
                                   gender:(NSString *)gender
                                 birthday:(NSTimeInterval)birthday
                             interestTags:(NSArray *)interestTags
                                   WithMessage:(HUDMessageBlock)messageBlock;



/**
 扫码取件
 
 @param qrcode 二维码扫描结果
 @param timestap 时间戳 毫秒值
 @param messageBlock 回调
 */

+(void)request_ScanToUnlockWithQrcode:(NSString *)qrcode
                             timestamp:(NSString *)timestap
                                WithMessage:(HUDMessageBlock)messageBlock;




/**
 获取 商城 列表
 @param categoryType 分类
 @param messageBlock 回调
 */
+ (void)request_GetSampleListCategoryType:(NSString *)categoryType
                             WithMessage:(HUDMessageBlock)messageBlock;



/**
 第三方登录请求
 
 @param appId facebook id
 @param openId openId
 @param accessToken accessToken
 @param openPlatformType 鹏泰
 @param clientType 终端
 @param messageBlock 回调
 */
+ (void)request_OpenLoginTipAppId:(NSString *)appId
                         openId:(NSString *)openId
                    accessToken:(NSString *)accessToken
               openPlatformType:(NSString *)openPlatformType
                     clientType:(NSString *)clientType
                         WithMessage:(HUDMessageBlock)messageBlock;
@end
