//
//  PaxNotificationDetailController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxNotificationDetailController.h"

@interface PaxNotificationDetailController ()

/**
 顶部标签文字
 */
@property (weak, nonatomic) UILabel *titleLabel;

/**
 时间标签
 */
@property (weak, nonatomic) UILabel *timeLabel;


/**
 内容
 */
@property (weak, nonatomic) UITextView *content;
@end

@implementation PaxNotificationDetailController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupContent];
    [self setupFont];
    [self setupColor];
}


/**
 界面设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 顶部标题
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(90);
        make.left.equalTo(Weakself.view).offset(16);
        make.right.equalTo(Weakself.view).offset(-16);
        make.height.equalTo(@(30));
    }];
    
    //TODO: time
    UILabel *timeLabel = [[UILabel alloc]init];
    _timeLabel = timeLabel;
    [self.view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    
    //TODO: content
    UITextView *content = [[UITextView alloc]init];
    
    _content = content;
    [self.view addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(10);
        make.left.right.equalTo(titleLabel);
        make.width.mas_equalTo(ScreenWidth - 2*16);
        make.bottom.equalTo(Weakself.view).offset(-44);
    }];
    content.editable = false;
}


/**
 内容设置
 */
- (void)setupContent
{
    _titleLabel.text = _Detail_title;
    _timeLabel.text = _time;
    _content.text = _Detail_content;
}

/**
 字体设置
 */
- (void)setupFont
{
    _titleLabel.font = [UIFont systemFontOfSize:21];
    _timeLabel.font = Pax_Font_Text;
    _content.font = [UIFont systemFontOfSize:14];
}

/**
 颜色设置
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _titleLabel.textColor = Pax_Black;
    _timeLabel.textColor = Pax_Black;
    _content.textColor = Pax_Text_Grey;
    _content.backgroundColor = [UIColor clearColor];
}
@end
