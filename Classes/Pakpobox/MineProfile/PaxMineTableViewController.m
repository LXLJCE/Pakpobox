//
//  PaxMineTableViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/7.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMineTableViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PaxSpeakWithUsViewController.h"
@interface PaxMineTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation PaxMineTableViewController


/**
 懒加载Picker

 @return 相机
 */
- (UIImagePickerController *)imagePickerController
{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;

        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

/**
 声明周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = PaxMine;
}


#pragma mark - delegate dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaxSpeakWithUsViewController *speak = [[PaxSpeakWithUsViewController alloc]init];
    speak.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:speak animated:true];
}


- (IBAction)clickIcon:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //        [self selectImageFromAlbum];
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action3];
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
 
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    self.image = editingInfo[UIImagePickerControllerEditedImage];
}
//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片c
        self.image = info[UIImagePickerControllerEditedImage];
        //压缩图片
        NSData *fileData = UIImageJPEGRepresentation(self.image, 1.0);
        //上传图片
//        [self uploadImageWithData:fileData];
        
    }else{
       
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    return;
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"修改图像失败" ;
        
    }else{
        
        msg = @"修改头像成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改头像结果提示"
                          
                                                    message:msg
                          
                                                   delegate:self
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
    
}


#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}

@end
