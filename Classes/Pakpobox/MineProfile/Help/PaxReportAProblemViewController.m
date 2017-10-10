//
//  PaxReportAProblemViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/27.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxReportAProblemViewController.h"

@interface PaxReportAProblemViewController ()
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) UIButton *submit;
@property (weak, nonatomic) UILabel *introLabel;
@end

@implementation PaxReportAProblemViewController


/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self setupText];
    [self rac_event];
}


/**
 UI界面设计
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: textView
    UITextView *textView = [[UITextView alloc]init];
    _textView = textView;
    [textView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(64 + 40);
        make.left.equalTo(Weakself.view).offset(40);
        make.right.equalTo(Weakself.view).offset(-40);
        make.height.mas_equalTo(120);
    }];
    //TODO: submit
    UIButton *submit = [[UIButton alloc]init];
    _submit = submit;
    [self.view addSubview:submit];
    [submit backColor:Pax_White cornerRadius:3 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(10);
        make.right.equalTo(textView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *intro = [[UILabel alloc]init];
    [self.view addSubview:intro];
    _introLabel = intro;
    intro.numberOfLines = 0;
    [intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submit.mas_bottom).offset(30);
        make.left.equalTo(Weakself.view).offset(24);
        make.right.equalTo(Weakself.view).offset(-24);
        
    }];
}

/**
 字体设置
 */
-(void)setupFont
{
    _submit.titleLabel.font = Pax_Font_Text;
    _textView.font = Pax_Font_Text;
    _introLabel.font = Pax_Font_Text;
}


/**
 颜色设置
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _textView.backgroundColor = Pax_White;
    _submit.backgroundColor = Pax_White;
    [_submit setTitleColor:Pax_Black forState:UIControlStateNormal];
    _introLabel.textColor = Pax_Text_Grey;
}

/**
 文字设置
 */
- (void)setupText
{
    
    [_submit setTitle:PaxSubmit forState:UIControlStateNormal];
    [_introLabel setText:@"asdjaksdjlakda"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_textView becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_textView resignFirstResponder];
}

- (void)rac_event
{
    [[_submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PaxLog(@"%@", @"点击了submit");
    }];
    
}
@end
