//
//  PaxCollectionViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/20.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxCollectionViewController.h"
#import "PaxTableViewDelegateAndDateSource.h"



static NSString *cellID = @"collectionCell";

@interface PaxCollectionViewController ()
@property (weak, nonatomic) UIView *selectView; /**选择框*/
@property (weak, nonatomic) UILabel *selectLabel;
@property (weak, nonatomic) UIButton *selectBtn;
@property (weak, nonatomic) UIView *contentView;/**列表内容框*/
@property (weak, nonatomic) UITableView *list;/**列表table*/
@property (weak, nonatomic) UIView *detailView;/**详情内容框*/

@property (weak, nonatomic) UILabel *DetailTitle;/**标题信息*/
@property (weak, nonatomic) UILabel *DetailStatus;/**状态信息*/
@property (weak, nonatomic) UILabel *DetailLocation;/**地址信息*/
@property (weak, nonatomic) UILabel *DetailPin;/*二维码信息*/
@property (weak, nonatomic) UIImageView *qrcodeIm;/**生成二维码*/

@property (weak, nonatomic) UILabel *DetailIntro;/**详情信息*/
@property (strong, nonatomic) PaxTableViewDelegateAndDateSource *delegateAndDateSource;
@end

@implementation PaxCollectionViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Pax_Bg_Grey;
    
    self.delegateAndDateSource = [[PaxTableViewDelegateAndDateSource alloc]init];
    _delegateAndDateSource.cellID = cellID;
    
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self rac_event];
    [self setupContent];
}


/**
 界面设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    /*
        1. 对于取件订单的选择
     */
    UIView *selectView = [[UIView alloc]init];
    [self.view addSubview:selectView];
    self.selectView = selectView;
    selectView.layer.cornerRadius = 5;
    selectView.layer.masksToBounds = true;
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(64 + 60);
        make.left.equalTo(Weakself.view).offset(40);
        make.right.equalTo(Weakself.view).offset(-40);
        make.height.equalTo(@(30));
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    self.selectBtn = btn;
    [selectView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(selectView);
    }];
    
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    selectImage.image = [UIImage imageNamed:@"img_jlcx_xl_sanjiao"];
    selectImage.contentMode = UIViewContentModeCenter;
    [selectView addSubview: selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(selectView);
        make.width.equalTo(@(50));
    }];
    
    UILabel *selectLabel = [[UILabel alloc]init];
    self.selectLabel = selectLabel;
    selectLabel.text = PaxPleaseSelectALocker;
    [selectView addSubview:selectLabel];
    [selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(selectView);
        make.left.equalTo(selectView).offset(20);
        make.right.equalTo(selectImage);
    }];
    
    /*
        详情
     */
    UIView *detailView = [[UIView alloc]init];
    self.detailView = detailView;
    detailView.layer.cornerRadius = 5;
    detailView.layer.masksToBounds = true;
    [self.view addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(selectView);
        make.top.equalTo(selectView.mas_bottom).offset(20);
        make.height.equalTo(@(ScreenWidth - 50));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    _DetailTitle = titleLabel;
    titleLabel.text = PaxDetail;
    [detailView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailView);
        make.left.equalTo(detailView).offset(3);
        make.right.equalTo(detailView).offset(-3);
        make.height.equalTo(@(35));
    }];
    UILabel *status = [[UILabel alloc]init];
    _DetailStatus = status;
    status.text = PaxStatus;
    [detailView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailView).offset(3);
        make.right.equalTo(detailView).offset(-3);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.equalTo(@(30));
    }];
    UILabel *location = [[UILabel alloc]init];
    _DetailLocation = location;
    location.text = PaxLocation;
    [detailView addSubview:location];
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailView).offset(3);
        make.right.equalTo(detailView).offset(-3);
        make.top.equalTo(status.mas_bottom).offset(10);
        make.height.equalTo(@(30));
    }];
    UILabel *pin = [[UILabel alloc]init];
    _DetailPin = pin;
    pin.text = PaxPin;
    [detailView addSubview:pin];
    [pin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailView).offset(40);
        make.right.equalTo(detailView).offset(-66);
        make.top.equalTo(location.mas_bottom).offset(15);
        make.height.equalTo(@(60));
    }];
    UIImageView *qrcodeImage = [[UIImageView alloc]init];
    _qrcodeIm = qrcodeImage;
    [detailView addSubview:qrcodeImage];
    [qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(detailView).offset(-40);
        make.top.equalTo(location.mas_bottom).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    
    
    UILabel *intro = [[UILabel alloc]init];
    _DetailIntro = intro;
    intro.text = PaxUsethepinorQR;
    intro.numberOfLines = 0;
    [detailView addSubview:intro];
    [intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailView).offset(3);
        make.right.equalTo(detailView).offset(-3);
        make.top.equalTo(pin.mas_bottom).offset(15);
        make.height.equalTo(@(50));
    }];
    
    
    
    
    /*
        列表信息
     */
    UIView *contentView = [[UIView alloc]init];
    self.contentView = contentView;
    _contentView.hidden = true;
    [self.view addSubview:contentView];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = true;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(selectView);
        make.top.equalTo(selectView.mas_bottom).offset(10);
        make.height.equalTo(@(ScreenWidth - 50));
    }];
    
    UITableView *list = [[UITableView alloc]initWithFrame:contentView.bounds style:UITableViewStylePlain];
    [contentView addSubview:list];
    _list = list;
    list.delegate = _delegateAndDateSource;
    list.dataSource = _delegateAndDateSource;
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(contentView).offset(5);
        make.right.bottom.equalTo(contentView).offset(-5);
    }];
    [_list registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    _list.separatorStyle = UITableViewCellSeparatorStyleNone;
}




/**
 点击cell跳转

 @param cell 点击的cell
 */
- (void)selectorCellWithCell:(UITableViewCell *)cell
{
    //TODO: 点击Cell 方法
    
    NSString *celltitle = cell.textLabel.text;
    _selectLabel.text = celltitle;
    _DetailTitle.text = [NSString stringWithFormat:@"%@",PaxDetail];
    _DetailLocation.text = [NSString stringWithFormat:@"%@:%@",PaxStatus,celltitle];
    _DetailPin.text = [NSString stringWithFormat:@"%@:%@",PaxLocation,celltitle];
    _DetailStatus.text = [NSString stringWithFormat:@"%@:%@",PaxPin,celltitle];
    _DetailIntro.text = [NSString stringWithFormat:@"%@",PaxUsethepinorQR];
    
    _contentView.hidden = true;
    _selectBtn.selected = false;
}
/*
 字体设置
 */
- (void)setupFont
{
    _selectLabel.font = Pax_Font_Collection_Selector_title;
    
    _DetailTitle.font = Pax_Font_Section_header;
    _DetailTitle.textAlignment = NSTextAlignmentCenter;
    _DetailStatus.font = Pax_Font_H3;
    _DetailPin.font = Pax_Font_H3;
    _DetailLocation.font = Pax_Font_H3;
    _DetailIntro.font = Pax_Font_Text;
}

/**
 颜色设置
 */
- (void)setupColor
{
    _detailView.backgroundColor = [UIColor whiteColor];
    _selectView.backgroundColor = [UIColor whiteColor];
    _contentView.backgroundColor = [UIColor whiteColor];
    _selectLabel.textColor = Pax_Color_Collection_Selector_Title;
}

/**
 设置内容
 */
- (void)setupContent
{
    _qrcodeIm.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:@"http://www.baidu.com" imageViewWidth:60.0f];
}
/**
 事件
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        sender.selected = !sender.selected;
        
        Weakself.contentView.hidden = sender.selected ? false : true;
    }];
    
    [[_delegateAndDateSource rac_signalForSelector:@selector(clickSelectWith:)]subscribeNext:^(id x) {
        RACTuple *items = (RACTuple *)x;
        
        UITableViewCell *cell = items.allObjects.firstObject;
        [Weakself selectorCellWithCell:cell];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _contentView.hidden = true;
}
@end
