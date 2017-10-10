//
//  PaxCreditsViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/4.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxCreditsViewController.h"
#import <Social/Social.h>
@interface PaxCreditsViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentTop;
@property (weak, nonatomic) IBOutlet UIButton *fuzhi;
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UILabel *creditsLabel;

/**
 底部内容
 */
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *howWorkBtn;

@end

@implementation PaxCreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navText = PaxMyCredits;
    self.view.backgroundColor = Pax_Bg_Grey;
    [_contentTop backColor:Pax_White cornerRadius:6 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [_fuzhi backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [_tip backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [self setupText];
    [self networkRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 内容设置
 */
- (void)setupText{
    _label1.text = PaxWantFreeCredits;
    _label2.text = PaxShareyourloveforPakpobox;
    _label3.text = PaxGetcreditswhenyoureferPakpobox;
    [_howWorkBtn setTitle:PaxHowinviteswork forState:UIControlStateNormal];
    [_fuzhi setTitle:PaxCopy forState:UIControlStateNormal];
}
- (IBAction)clickFuZhi:(id)sender {
    
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        NSLog(@"不可用");
        return;
    }
    
    /* *****可以分享的平台*****
     SOCIAL_EXTERN NSString *const SLServiceTypeTwitter NS_AVAILABLE(10_8, 6_0);//Twitter
     SOCIAL_EXTERN NSString *const SLServiceTypeFacebook NS_AVAILABLE(10_8, 6_0);//Facebook
     SOCIAL_EXTERN NSString *const SLServiceTypeSinaWeibo NS_AVAILABLE(10_8, 6_0);//新浪微博
     SOCIAL_EXTERN NSString *const SLServiceTypeTencentWeibo NS_AVAILABLE(10_9, 7_0);//腾讯微博
     SOCIAL_EXTERN NSString *const SLServiceTypeLinkedIn NS_AVAILABLE(10_9, NA);//领英
     */
    
    // 创建控制器，并设置ServiceType（指定分享平台）
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if (composeVC == nil) {
        return;
    }
    // 添加要分享的图片
    [composeVC addImage:[UIImage imageNamed:@"snap1"]];
    // 添加要分享的文字
    [composeVC setInitialText:_tip.text];
    // 添加要分享的url
    [composeVC addURL:[NSURL URLWithString:@"http://www.putclub.com"]];
    // 弹出分享控制器
    [self presentViewController:composeVC animated:YES completion:nil];
    // 监听用户点击事件
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            NSLog(@"点击了发送");
        }
        else if (result == SLComposeViewControllerResultCancelled)
        {
            NSLog(@"点击了取消");
        }
    };

}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0) {
//        /* **************系统分享方法一************** */
//        //初始化分享控件
//        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"百度",[NSURL URLWithString:@"http://www.baidu.com"]] applicationActivities:nil];
//        //不显示哪些分享平台
//        //        avc.excludedActivityTypes = @[UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard,UIActivityTypeAddToReadingList];
//        
//        [self presentViewController:avc animated:YES completion:nil];
//        //分享结果回调方法
//        UIActivityViewControllerCompletionHandler myblock = ^(NSString *type,BOOL completed){
//            NSLog(@"%d %@",completed,type);
//        };
//        avc.completionHandler = myblock;
//    }else if (buttonIndex==1){
//        /* **************系统分享方法二************** */
//        
//        // 首先判断某个平台是否可用（如果未绑定账号则不可用）
//        
//        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
//            NSLog(@"不可用");
//            return;
//        }
//        
//        /* *****可以分享的平台*****
//         SOCIAL_EXTERN NSString *const SLServiceTypeTwitter NS_AVAILABLE(10_8, 6_0);
//         SOCIAL_EXTERN NSString *const SLServiceTypeFacebook NS_AVAILABLE(10_8, 6_0);
//         SOCIAL_EXTERN NSString *const SLServiceTypeSinaWeibo NS_AVAILABLE(10_8, 6_0);
//         SOCIAL_EXTERN NSString *const SLServiceTypeTencentWeibo NS_AVAILABLE(10_9, 7_0);
//         SOCIAL_EXTERN NSString *const SLServiceTypeLinkedIn NS_AVAILABLE(10_9, NA);
//         */
//        
//        // 创建控制器，并设置ServiceType
//        SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        // 添加要分享的图片
//        [composeVC addImage:[UIImage imageNamed:@"Nameless"]];
//        // 添加要分享的文字
//        [composeVC setInitialText:@"share to PUTClub"];
//        // 添加要分享的url
//        [composeVC addURL:[NSURL URLWithString:@"http://www.putclub.com"]];
//        // 弹出分享控制器
//        [self presentViewController:composeVC animated:YES completion:nil];
//        // 监听用户点击事件
//        composeVC.completionHandler = ^(SLComposeViewControllerResult result){
//            if (result == SLComposeViewControllerResultDone) {
//                NSLog(@"点击了发送");
//            }
//            else if (result == SLComposeViewControllerResultCancelled)
//            {
//                NSLog(@"点击了取消");
//            }
//        };
//        
//    }else{
//        NSLog(@"点击了取消");
//    }
//}
/**
 网络请求
 */
- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_AccountInfoWithTipMessage:PaxPleasewaitamomentLoad Finish:^(id responseObject, NSError *error) {
        
        Weakself.creditsLabel.text = [NSString stringWithFormat:@"%@ %zd %@",PaxYouhave,[responseObject[@"integral"] intValue],Paxcreditsavailable];
        
    }];
}

@end
