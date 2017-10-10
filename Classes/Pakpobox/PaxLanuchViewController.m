//
//  PaxLanuchViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/5.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxLanuchViewController.h"
#import "PaxLanuageViewController.h"
@interface PaxLanuchViewController ()
@property (weak, nonatomic) IBOutlet UIButton *start;

- (IBAction)clickStart:(id)sender;

@end

@implementation PaxLanuchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_start backColor:Pax_Border_Grey cornerRadius:5 borderColor:Pax_Orange borderWidth:1 isShadow:true];
    [_start setTitle:PaxGetStart forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)clickStart:(id)sender {
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[PaxLanuageViewController alloc]init];
}
@end
