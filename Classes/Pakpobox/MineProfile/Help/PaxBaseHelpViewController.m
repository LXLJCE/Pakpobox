//
//  PaxBaseHelpViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxBaseHelpViewController.h"

@interface PaxBaseHelpViewController ()
@property (weak, nonatomic) UITextView *textView;
@property (copy, nonatomic) NSString *text;
@end

@implementation PaxBaseHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self setupFont];
    [self setupColor];
    [self setupText];
}

- (void)setupUI
{
    LXLWeakSelf(self);
    UITextView *textView = [[UITextView alloc] init];
    _textView = textView;
    textView.editable = false;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(64 + 40);
        make.right.equalTo(Weakself.view).offset(-24);
        make.left.equalTo(Weakself.view).offset(24);
        make.bottom.equalTo(Weakself.view).offset(-20);
        make.height.mas_equalTo(MAXFLOAT);
    }];
}
- (void)setupColor
{
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = Pax_Text_Grey;
    self.view.backgroundColor = Pax_Bg_Grey;
}
- (void)setupFont
{
    _textView.font = Pax_Font_Text;
}
- (void)setupText{
    _textView.text = _text;
}
- (void)setupTextWith:(NSString *)text
{
    _text = [text copy];
}
@end
