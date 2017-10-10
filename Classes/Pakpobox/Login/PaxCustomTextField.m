//
//  PaxCustomTextField.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxCustomTextField.h"
@interface PaxCustomTextField()
@property (nonatomic , weak) UITextField *textFiled;
@property (nonatomic , weak) UIView *line;
@property (assign, nonatomic) CGFloat width;
@end

@implementation PaxCustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
        [self setupChildrenView];
        [self setupFont];
        [self setupColor];
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self setupChildrenView];
        [self setupFont];
        [self setupColor];
    }
    return self;
}
- (void)setupChildrenView
{
    UITextField *textField = [[UITextField alloc]init];
    self.textFiled = textField;
    textField.borderStyle = UITextBorderStyleNone;
    [self addSubview:textField];
    
//    UIView *line = [[UIView alloc]init];
//    self.line = line;
//    line.backgroundColor = [UIColor clearColor];
//    [self addSubview:line];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textFiled.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 2);
  
    self.line.frame = CGRectMake(0, self.textFiled.frame.size.height, self.bounds.size.width, _width == 0 ? 2 : _width);
}
- (void)setPlaceholder:(NSString *)placeholder
{
    self.textFiled.placeholder = [placeholder copy];
}
- (void)setText:(NSString *)text
{
    self.textFiled.text = [text copy];
}
- (NSString *)placeholder
{
    return self.textFiled.placeholder;
}
- (NSString *)text
{
    return self.textFiled.text;
}
- (UITextField *)textFiled
{
    return _textFiled;
}
- (void)setLineWidth:(CGFloat)lineWidth
{
    _width = lineWidth;
}

- (void)setupFont{
    _textFiled.font = Pax_Font_Login_AP;
}

- (void)setupColor
{
    _line.backgroundColor = Pax_Color_Login_Line;
    _textFiled.textColor = Pax_Color_AP_Text;
    
}
- (void)setIsSecuire:(BOOL)isSecuire
{
    _isSecuire = isSecuire;
    _textFiled.secureTextEntry = _isSecuire;
}
@end
