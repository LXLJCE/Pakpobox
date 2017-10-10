//
//  PaxRequestRegual.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxRequestRegual.h"
#import <CommonCrypto/CommonDigest.h>
@implementation PaxRequestRegual
+ (void)request_loginWithLoginName:(NSString *)loginName andPassword:(NSString *)password andLoginType:(NSString *)loginType WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    [dict setObject:loginName forKey:@"account"];
    [dict setObject:password forKey:@"password"];
//    [dict setObject:loginType forKey:@"loginType"];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}

+ (void)request_registWithPhoneNumberL:(NSString *)phoneNumber andName:(NSString *)name andEmail:(NSString *)email andLoginName:(NSString *)loginName andPassword:(NSString *)password andInviteCode:(NSString *)inviteCode andRegisterType:(NSString *)registerType andLanuage:(NSString *)lanuage andCountry:(NSString *)country WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:phoneNumber forKey:@"phoneNumber"];
    [dict setObject:name forKey:@"name"];
    [dict setObject:email forKey:@"email"];
    [dict setObject:loginName forKey:@"loginName"];
    [dict setObject:password forKey:@"password"];
    [dict setObject:inviteCode forKey:@"inviteCode"];
    [dict setObject:registerType forKey:@"registerType"];
    [dict setObject:[PaxDataSave getLanuage] forKey:@"lanuage"];
    [dict setObject:[PaxDataSave getCountry] forKey:@"country"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil,parameters);
}

+ (void)request_retrievePasswordWithEmasil:(NSString *)email
                              WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:phone forKey:@"phone"];
    [dict setObject:email forKey:@"email"];
//    [dict setObject:code forKey:@"code"];
//    [dict setObject:token forKey:@"token"];
//    [dict setObject:password forKey:@"password"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}
+ (void)request_CodeWithEmail:(NSString *)email
                      andCode:(NSString *)code
                  WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setObject:phone forKey:@"phone"];
    [dict setObject:email forKey:@"email"];
        [dict setObject:code forKey:@"code"];
    //    [dict setObject:token forKey:@"token"];
    //    [dict setObject:password forKey:@"password"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}
+ (void)request_RestPasswordWithToken:(NSString *)Token
                          andPassword:(NSString *)password
                          WithMessage:(HUDMessageBlock)messageBlock{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setObject:phone forKey:@"phone"];
    [dict setObject:Token forKey:@"token"];
    [dict setObject:password forKey:@"password"];
    //    [dict setObject:token forKey:@"token"];
    //    [dict setObject:password forKey:@"password"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}

+ (void)requet_nearbyBoxWithlongitude:(CGFloat)longitude
                             latitude:(CGFloat)latitude
                                 page:(NSInteger)page
                             maxCount:(NSInteger)maxCount
                          WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(longitude) forKey:@"longitude"];
    [dict setObject:@(latitude) forKey:@"latitude"];
    [dict setObject:@(page) forKey:@"page"];
    [dict setObject:@(maxCount) forKey:@"maxCount"];
//    [dict setObject:password forKey:@"password"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
    
}



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
                                      WithMessage:(HUDMessageBlock)messageBlock{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(credits) forKey:@"credits"];
    [dict setObject:giftcardCode forKey:@"giftcardCode"];
    [dict setObject:mouthSize forKey:@"mouthSize"];
    [dict setObject:payType forKey:@"payType"];
    
    [dict setObject:receiverName forKey:@"receiverName"];
    [dict setObject:receiverPhone forKey:@"receiverPhone"];
    [dict setObject:sendType forKey:@"sendType"];
    // TODO: 这里需要注意,我将图片上传给去掉了
    
//    NSData *data = UIImagePNGRepresentation(image);
//     NSString *string = [NSString stringWithUTF8String:[data bytes]];
//    [dict setObject:string forKey:@"image"];
    

    
    NSData *_data = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *_encodedImageStr =[NSString stringWithFormat:@"%@;%@",@"jpg" ,[_data base64Encoding]];
    
     [dict setObject:_encodedImageStr forKey:@"image"];
    
    
    if (recipientAddress != nil) {
        [dict setObject:recipientAddress forKey:@"recipientAddress"];
    }
    if (recipientBox != nil){
        [dict setObject:recipientBox forKey:@"recipientBox"];
    }
    if (deliveryBox != nil){
        [dict setObject:deliveryBox forKey:@"deliveryBox"];
    }
    
    
    
    
    //    [dict setObject:password forKey:@"password"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);

}



+ (void)request_CreateReturnExpressOrderlocker:(NSDictionary *)locker
                                 expressNumber:(NSString *)expressNumber
                                     mouthSize:(NSString *)mouthSize
                                   WithMessage:(HUDMessageBlock)messageBlock
{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:expressNumber forKey:@"expressNumber"];
    [dict setObject:mouthSize forKey:@"mouthSize"];
    [dict setObject:locker forKey:@"locker"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);

}

+ (void)request_updatePasswordPassword:(NSString *)password
                      originalPassword:(NSString *)originalPassword
                           WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:password forKey:@"password"];
    [dict setObject:originalPassword forKey:@"originalPassword"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}

+ (void)request_settingWithOpenLocation:(BOOL)openLocation
                          openAppNotify:(BOOL)openAppNotify
                        openEmailNotify:(BOOL)openEmailNotify
                          openSmsNotify:(BOOL)openSmsNotify
                               language:(NSString *)language
                            WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(openLocation) forKey:@"openLocation"];
    [dict setObject:@(openAppNotify) forKey:@"openAppNotify"];
    [dict setObject:@(openEmailNotify) forKey:@"openEmailNotify"];
    [dict setObject:@(openSmsNotify) forKey:@"openSmsNotify"];
    [dict setObject:language forKey:@"language"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
    
}


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
                              WithMessage:(HUDMessageBlock)messageBlock
{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:login_name forKey:@"login_name"];
    [dict setObject:Phone forKey:@"phone"];
    [dict setObject:@(amount) forKey:@"amount"];
    [dict setObject:@(giftcard_amount) forKey:@"giftcard_amount"];
    [dict setObject:@(total_amount) forKey:@"total_amount"];
    [dict setObject:@"洗衣订单" forKey:@"product_name"];
    [dict setObject:product_desc forKey:@"product_desc"];
    [dict setObject:goods_info forKey:@"goods_info"];
    [dict setObject:client_type forKey:@"client_type"];
    [dict setObject:giftcard_no forKey:@"giftcard_no"];
    [dict setObject:@(Integral) forKey:@"integral"];
    [dict setObject:order_type forKey:@"order_type"];
    [dict setObject:Box forKey:@"box"];
    [dict setObject:@"NONE" forKey:@"pay_type"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);


}


+ (void)request_GetMyOrdersWithOrderType:(NSString *)orderType
                                     page:(NSInteger)page
                                 maxCount:(NSInteger)maxCount
                              WithMessage:(HUDMessageBlock)messageBlock{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:orderType forKey:@"orderType"];
    [dict setObject:@(maxCount) forKey:@"maxCount"];
    [dict setObject:@(page) forKey:@"page"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}

+ (void)request_CompleteProfileWithID:(NSString *)ID
                               gender:(NSString *)gender
                             birthday:(NSTimeInterval)birthday
                         interestTags:(NSArray *)interestTags
                          WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:ID forKey:@"id"];
    [dict setObject:gender forKey:@"gender"];
    [dict setObject:@(birthday) forKey:@"birthday"];
    
    [dict setObject:interestTags forKey:@"interestTags"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
    
}

+(void)request_ScanToUnlockWithQrcode:(NSString *)qrcode
                            timestamp:(NSString *)timestap
                          WithMessage:(HUDMessageBlock)messageBlock
{
    NSString *author = @"580b41ccef2c4d00979f3456e028687f";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:qrcode forKey:@"qrcode"];
    
    
    
    
    [dict setObject:timestap forKey:@"timestamp"];
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@",author,userToken,qrcode,timestap];
    NSString *sign = [self md532BitLowerWith:md5];
    [dict setObject:sign forKey:@"sign"];
   
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}


+ (void)request_GetSampleListCategoryType:(NSString *)categoryType
                              WithMessage:(HUDMessageBlock)messageBlock{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"SAMPLE" forKey:@"categoryType"];
    
 
    
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
}



+ (void)request_OpenLoginTipAppId:(NSString *)appId
                           openId:(NSString *)openId
                      accessToken:(NSString *)accessToken
                 openPlatformType:(NSString *)openPlatformType
                       clientType:(NSString *)clientType
                      WithMessage:(HUDMessageBlock)messageBlock
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:appId forKey:@"appId"];
    [dict setObject:openId forKey:@"openId"];
    [dict setObject:accessToken forKey:@"accessToken"];
    [dict setObject:openPlatformType forKey:@"openPlatformType"];
    [dict setObject:clientType forKey:@"clientType"];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:dict];
    messageBlock(nil, parameters);
    
}
#pragma mark - 正则判断试

/**
 关于正则判断

 @param regual 正则表达式
 @param string 判断的字符串
 @return 判断结果
 */
- (BOOL)regual:(NSString *)regual toString:(NSString *)string
{
    return true;
}


#pragma mark - MD5 32
+ (NSString *)md532BitLowerWith:(NSString *)sender
{
    const char *cStr = [sender UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
