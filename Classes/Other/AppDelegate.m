//
//  AppDelegate.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/23.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import <JSPatchPlatform/JSPatch.h>
#import "PaxMainViewController.h"
#import "PaxLanuchViewController.h"
#import "PaxNotificationHandle.h"
#import "XGPush.h"
#import "BPush.h"
#import "XGSetting.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end
static NSString *googleMapKey = @"AIzaSyC45YR57kURAUL__rhBpLmlXlfjDfPloMM";
static NSString *paypolClientID = @"AacaPhTkF8VWc-o6XbewR27I4DNZv3j1B0ve7W5GJIIlBIzFoKn5Ss188z3you8QPvzSMWAGX7kJDspJ";
static NSString *jPatchAppKey = @"7c1c4836c494438b";

static NSString *xingeKey = @"IMAJ7Q9232FR";
//static NSInteger xingeId = 2200259674;
static NSString *baidutuisong = @"Fi0gUVLbdnI1ljdXQf24dOAW";
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*信鸽*/
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [self setXG:application didFinishLaunchingWithOptions:launchOptions];
    
    
    [self registGoogleMap];
    [self registGoogleAPi];
    [self registJPatch];
    [self paypalRegist];
    [self facebookLoginConfAbountApplication:application didFinishLaunchingWithOptions:launchOptions];
    [PaxInternationalControl initUserLanguage];
    [self IQKeyConfig];
    [self globaNav];
    [PaxHUD load];
    [self countryAndLanuage];
    [self initNotificationAuthorWith:application];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[PaxLanuchViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    return YES;
}


/**
 设置信鸽推送相关
 */
- (void)setXG:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[XGSetting getInstance] enableDebug:true];
    [XGPush startApp:2200259766 appKey:xingeKey];
    [XGPush isPushOn:^(BOOL isOn) {
        NSLog(@"Push is %@", isOn ? @"ON": @"OFF");
    }];
    [self registerAPNS];
    [XGPush handleLaunching:launchOptions successCallback:^{
        NSLog(@"handle launching success");
    } errorCallback:^{
        NSLog(@"handle launching error");
    }];
}
- (void)registerAPNS
{
    float sysVer = [[[UIDevice currentDevice] systemVersion]floatValue];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        if (sysVer >= 10) {
            [self registerPush10];
        }else if(sysVer >= 8){
            [self registerPush8to9];
        }else{
            [self registerPushBefore8];
        }
#else
        if (sysVer < 8) {
            [self registerPushBefore8];
        }else{
            [self registerPush8to9];
        }
#endif
    
}
- (void)registerPush10{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        }
    }];
    [[UIApplication sharedApplication]registerForRemoteNotifications];
#endif
}

- (void)registerPush8to9
{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication]registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication]registerForRemoteNotifications];
}

- (void)registerPushBefore8
{
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}



- (void)initNotificationAuthorWith:(UIApplication *)application
{
    [UNUserNotificationCenter currentNotificationCenter].delegate = [PaxNotificationHandle shareInstance];
    
    [[PaxNotificationHandle shareInstance] authorizationPushNotificaton:application];
}


/**
 初始化 语言和城市
 */
- (void)countryAndLanuage
{
    if ([PaxDataSave getCountry] == nil) {
        [PaxDataSave saveCountry:@"HongKong"];
    }
    if ([PaxDataSave getLanuage] == nil) {
        [PaxDataSave saveLanguage:@"English"];
    }
}

// MARK: - NAV 设置
- (void)globaNav
{
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
//    [UINavigationBar appearance].barTintColor = Pax_TineColor;
    [UITextField appearance].tintColor = Pax_TineColor;
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    [UITabBar appearance].tintColor = Pax_Orange;
}
// MARK: -谷歌地图注册
- (void)registGoogleMap
{
    [GMSServices provideAPIKey:googleMapKey];
}
// MARK: -谷歌APi
- (void)registGoogleAPi
{
    [GMSPlacesClient provideAPIKey:googleMapKey];
}
// MARK: -注册jPatch
- (void)registJPatch
{
    [JSPatch startWithAppKey:jPatchAppKey];
//    [JSPatch testScriptInBundle];
//
    
}

// MARK: -支付Paypal zhuce
- (void)paypalRegist
{
    /*PayPalEnvironmentProduction : nil*/
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox : paypolClientID}];
}

// MARK: -Facebook三方登陆
- (void)facebookLoginConfAbountApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}


// MARK: -IQKey相关配置
- (void)IQKeyConfig
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
 
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnterForeground" object:nil];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [self syncJsPatch];
}
// MARK: -唤醒进行更新JSpatch补丁
- (void)syncJsPatch
{
    [JSPatch sync];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
 
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:^{
        NSLog(@"register Push Success");
    } errorCallback:^{
        NSLog(@"register Push Error");
    }];
    
    [PaxDataSave saveDeviceToken:deviceTokenStr];
    NSLog(@"%@",deviceTokenStr);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"register APNS Failed:%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Reciver Notification");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remote" object:nil];
    [XGPush handleReceiveNotification:userInfo successCallback:^{
        NSLog(@"Handle Receive Success");
    } errorCallback:^{
        NSLog(@"Handle Receive error");
    }];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Reciver Notification");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remote" object:nil];
    [XGPush handleReceiveNotification:userInfo successCallback:^{
        NSLog(@"Handle Receive Success");
    } errorCallback:^{
        NSLog(@"Handle Receive error");
    }];
    
    completionHandler(UIBackgroundFetchResultNewData);

}
@end
