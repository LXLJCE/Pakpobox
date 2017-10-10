//
//  PaxCollect_QRCODEViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/26.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxCollect_QRCODEViewController.h"
#import "PaxCollectionModel.h"
@interface PaxCollect_QRCODEViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrImg;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *pin;

@end

@implementation PaxCollect_QRCODEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navText = @"Order #05 - XT393994";
//    _qrImg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:@"http://www.baidu.com" imageViewWidth:180.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.model = _model;
}
- (void)setModel:(PaxCollectionModel *)model
{
    _model = model;
    self.navText = model.expressNumber;
    _pin.text = model.validateCode;
    _status.text = model.status;
    _qrImg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:model.shortLink imageViewWidth:180.0f];
    _location.text = model.location;
}

@end
