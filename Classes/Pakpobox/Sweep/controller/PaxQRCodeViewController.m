//
//  PaxQRCodeViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/7.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface PaxQRCodeViewController ()<UITabBarDelegate, UIImagePickerControllerDelegate, AVCaptureMetadataOutputObjectsDelegate>
/*
@IBOutlet weak var resultLabel: UILabel!
/// 容器视图
@IBOutlet weak var containerView: UIView!
/// 冲击波视图
@IBOutlet weak var scanLineView: UIImageView!
/// 扫描容器高度
@IBOutlet weak var containerViewHeightCons: NSLayoutConstraint!
/// 冲击波顶部约束
@IBOutlet weak var scanLineTopCons: NSLayoutConstraint!
/// 底部工具条
@IBOutlet weak var customTabbar: UITabBar!
 */
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *scanLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanLineTopCons;
@property (weak, nonatomic) IBOutlet UITabBar *customTabbar;
@property (strong, nonatomic) AVCaptureDeviceInput *inputDevice;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) CALayer *containerLayer;
@end

@implementation PaxQRCodeViewController
// MARK: - 懒加载设备
- (AVCaptureDeviceInput *)inputDevice
{
    if(_inputDevice == nil){
        AVCaptureDevice *model = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:model error:nil];
    }
    return _inputDevice;
}

- (AVCaptureMetadataOutput *)output
{
    if(_output == nil){
        // 1.创建输出对象
        AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc]init];
        
        // 2. 获取容器视图的 frame
        CGRect containerFrame = self.containerView.frame;
        CGRect screenFrame = [UIScreen mainScreen].bounds;
        
        // 3. 计算x/y/widt/height比例
        CGFloat x = containerFrame.origin.y / screenFrame.size.height;
        CGFloat y = containerFrame.origin.x / screenFrame.size.width;
        CGFloat width = containerFrame.size.height / screenFrame.size.height;
        CGFloat height = containerFrame.size.width / screenFrame.size.width;
        // 4.设置 解析数据感兴趣区域
        metadataOutput.rectOfInterest = CGRectMake( x,  y,  width,  height);
        _output = metadataOutput;
    }
    return _output;
}
- (AVCaptureSession *)session
{
    if(_session == nil){
        AVCaptureSession *model = [[AVCaptureSession alloc]init];
        _session = model;
    }
    return _session;
}
/// 预览图层
// 如果实在懒加载中用到self一般情况下是没有循环引用的
- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if(_previewLayer == nil){
        AVCaptureVideoPreviewLayer *model = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
        _previewLayer = model;
    }
    return _previewLayer;
}

- (CALayer *)containerLayer
{
    if(_containerLayer == nil){
        CALayer *model = [[CALayer alloc]init];
        _containerLayer = model;
    }
    return _containerLayer;
}
// MARK: -生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.设置默认选中item
    _customTabbar.selectedItem = _customTabbar.items.firstObject;
    _customTabbar.delegate = self;
    // 2.初始化二维码扫描
    [self setupScanQRCode];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startAnimation];
}

- (void)startAnimation
{
    // 0. 停止动画
    [_scanLineView.layer removeAllAnimations];
    // 1. 设置冲击波看不到
    _scanLineTopCons.constant = -_containerViewHeightCons.constant;
    [self.view layoutIfNeeded];
    
    // 2. 执行动画
    [UIView animateWithDuration:2.0 animations:^{
        [UIView setAnimationRepeatCount:MAXFLOAT];
        self.scanLineTopCons.constant = self.containerViewHeightCons.constant;
        [self.view layoutIfNeeded];
    }];
    
}
- (IBAction)closeBtnClick:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}




// MARK: - 图片选择监听方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 1.取出选中图片
    UIImage *image;
    if (info[UIImagePickerControllerOriginalImage] != nil){
        image = info[UIImagePickerControllerOriginalImage];
    }else{
        return;
    }
    
    CIImage *ciImage = [[CIImage alloc]initWithImage:image];
    
    // 2. 创建一个探测器
    NSDictionary *dict = @{CIDetectorAccuracy : CIDetectorAccuracyHigh};
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:dict];
    
    // 3. 利用探测器探测结果
    NSArray *features = [detector featuresInImage:ciImage];
    // 4. 取出结果
    for (CIQRCodeFeature *result in features) {
        PaxLog(@"%@",result.messageString);
    }
    
    // 只要实现代理方法, 就需要我们自己手动关闭浏览器
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

// MARK: - 扫描二维码相关
- (void)setupScanQRCode{
    // 1.判断输入是否能够添加到会话中
    if(![self.session canAddInput:self.inputDevice]){
        return;
    }
    // 2. 判断输出是否能够添加到会话中
    if(![self.session canAddOutput:self.output]){
        return;
    }
    // 3. 将输入和输出添加到会话中
    [self.session addInput:self.inputDevice];
    [self.session addOutput:self.output];
    
    // 4. 设置输出对象能够解析的数据类型
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    
    // 5. 设置代理监听解析后数据
   [ self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 6. 设置预览画面
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    // 7. 添加专门用于保存描边的图层
    self.containerLayer.frame = self.view.bounds;
    self.containerLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:self.containerLayer];
    
    // 8.开始扫描二维码
    [self.session startRunning];
}

// MAKR: - AVCaptureMetadataOutputObjectsDelegate
/**
 当解析到扫描到的数据时就会调用
 所有扫描到的数据都存在在metadataObjects
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 1. 清空描边
    [self clearContainerLayer];
    
    for (AVMetadataMachineReadableCodeObject *objc in metadataObjects) {
        // 1. 取出结果, 设置到界面上
        self.resultLabel.text = objc.stringValue;
        // 2. 给二维码描边
        [self drawCorners:objc];
    }
}

/**
 绘制描边
 
 - parameter objc: 扫描到的结果对象
 */

- (void)drawCorners:(AVMetadataMachineReadableCodeObject *)objc
{
    // 1. 利用预览图层将 corners转换为 我们可以识别的标志
    AVMetadataMachineReadableCodeObject *metadataObject = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:objc];
    
    // 2. 取出转换之后的 corners
    NSArray *corners = metadataObject.corners;
    
    // 3. 生成绘制路径
    UIBezierPath *path;
    if(![self createPath:corners] != nil){
        path = [self createPath:corners];
    }else{
        return;
    }
    
    // 4. 绘图
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = path.CGPath;
    
    // 5. 添加图层
    [self.containerLayer addSublayer:shapeLayer];
    
}

/**
 生成需要绘制路径
 
 - parameter corners: 坐标字典数组
 */

- (UIBezierPath *)createPath:(NSArray *)corners
{
    if (corners == nil || corners.count == 0) {
        return nil;
    }
    
    // 1. 遍历数组, 将数组中的字典转换成GCPoint
    int index = 0;
    CGPoint point = CGPointZero;
    // 2. 取出的数组中的只一个元素, 将取出的字典转换成CGPoint
    CFDictionaryRef  dict =  (__bridge CFDictionaryRef )corners[index];
    CGPointMakeWithDictionaryRepresentation(dict, &point);
    index++;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:point];
    
    while (index < corners.count) {
        CFDictionaryRef  dict =  (__bridge CFDictionaryRef )corners[index];
        CGPointMakeWithDictionaryRepresentation(dict, &point);
        index++;

    }
    [path closePath];
    
    return path;
}

- (void)clearContainerLayer
{
    NSArray *subLayers = self.containerLayer.sublayers;
    if (self.containerLayer.sublayers !=nil && self.containerLayer.sublayers.count != 0) {
        for (CALayer *layer in  subLayers) {
            [layer removeFromSuperlayer];
        }
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        // 二维码
        self.containerViewHeightCons.constant = 300;
    }else{
        // 条形码
        self.containerViewHeightCons.constant = 150;
    }
    // 重新开始动画
    [self startAnimation];
}
- (void)dealloc
{
    PaxLog(@"%@",@"死掉了");
}
@end
