//
//  PaxLockerSnapViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/11.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxLockerSnapViewController.h"
#import "PaxSelectDimensionViewController.h"

/**用于ImagePickerController */
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface PaxLockerSnapViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) UILabel * titleLabel;
//@property (weak, nonatomic) UIImageView *snapPicture;
@property (weak, nonatomic) UIButton *capture;

/**下一步上传按钮*/
@property (weak, nonatomic) UIButton *upload;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation PaxLockerSnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupColor];
    [self setupFont];
    [self setupText];
    [self setupContent];
    [self rac_event];
    [self setupImagePicker];
}

/**
 _imagePickerController 初始化
 */
- (void)setupImagePicker
{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}
#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    

    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{

    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}


//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
//        //如果是图片
       UIImage * image = info[UIImagePickerControllerEditedImage];
        self.capture.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.capture setImage:image forState:UIControlStateNormal];
//        //压缩图片
        NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
//        //保存图片至相册
//        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //上传图片
//        [self uploadImageWithData:fileData];
        
    }    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}
/**
 界面设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 容器
    UIView *contentView = [[UIView alloc]init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(60);
        make.height.mas_equalTo(ScreenWidth - 100);
    }];
    
    //TODO: topTitle
    UILabel *titlelabel = [[UILabel alloc]init
                           ];
    _titleLabel = titlelabel;
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(30);
    }];
    
    //TODO: detailView
    UIView *detailView = [[UIView alloc]init];
    detailView.backgroundColor = Pax_White;
    [contentView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlelabel.mas_bottom);
        make.bottom.left.right.equalTo(contentView);
    }];
    
    // TODO: snapPhoto
    UIButton *capture = [[UIButton alloc]init];
    [detailView addSubview:capture];
    _capture = capture;
    [capture backColor:Pax_White cornerRadius:6 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [capture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(detailView);
    }];
    
//    // TODO: Capture
//    UIButton *capture = [[UIButton alloc]init];
//    _capture = capture;
//    [detailView addSubview:capture];
    
    UIButton *upload = [[UIButton alloc]init];
    _upload = upload;
    [self.view addSubview:upload];
    [upload backColor:Pax_White cornerRadius:25 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [upload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(50);
    }];
    
}

/**
 内容设置
 */
- (void)setupContent
{
    [_capture setImage:[UIImage imageNamed:@"Capture"] forState:UIControlStateNormal];
}

/**
 颜色设置
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _titleLabel.textColor = Pax_Black;
    [_upload setTitleColor:Pax_Black forState:UIControlStateNormal];
}

/**
 字体设置
 */
- (void)setupFont
{
    _titleLabel.font = Pax_Font_Text;
    _upload.titleLabel.font = Pax_Font_Button;
}

/**
 文字设置
 */
- (void)setupText
{
    self.navText = PaxCapture;
    _titleLabel.text = PaxPleasesnapapictureoftheproduct;
    [_upload setTitle:PaxContinue forState:UIControlStateNormal];
}

/**
 事件绑定
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_capture rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [Weakself setupAlertController];
    }];
    
    _sender.image = self.capture.imageView.image;
    [[_upload rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PaxSelectDimensionViewController *selectVc = [[PaxSelectDimensionViewController alloc]init];
        selectVc.sender = _sender;
        [Weakself.navigationController pushViewController:selectVc animated:true];
    }];
}



// MARK: - 对于弹框的描述

/**
 建立弹出框

 */
- (void)setupAlertController
{
    
    LXLWeakSelf(self);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:PaxPlease message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:PaxFromthealbum style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [Weakself selectImageFromAlbum];
        }];
            [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:PaxTakeaphoto style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Weakself selectImageFromCamera];
        
    }];
        [alert addAction:action2];
    
    [alert addAction: [UIAlertAction actionWithTitle:PaxCancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
}
@end
