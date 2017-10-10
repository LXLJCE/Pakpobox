//
//  PaxSelectorPick.m
//  Pakpobox
//
//  Created by 博兴 on 2017/2/28.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSelectorPick.h"
@interface PaxSelectorPick()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) UIButton *complection;
@property (weak, nonatomic) UIPickerView *pickView;
@end
@implementation PaxSelectorPick

- (instancetype)init
{
    
    if (self = [super init]) {
        [self setupBaseView2];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setupBaseView
{
    LXLWeakSelf(self);
    /*顶部条 关于*/
    UIToolbar *tool = [[UIToolbar alloc] init];
    
    [self addSubview:tool];
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(Weakself);
        make.height.equalTo(@(44));
    }];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:PaxComplete style:UIBarButtonItemStyleDone target:self action:@selector(clickCompletion)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    [tool setItems:@[item, item1]];
    
    UIPickerView *pick = [[UIPickerView alloc]init];
    [self addSubview: pick];
    [pick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(Weakself);
        make.top.equalTo(Weakself).offset(44);
    }];
}


- (void)setupBaseView2{
    LXLWeakSelf(self);
    UIView *topview = [[UIView alloc]init];
    [topview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:topview];
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(Weakself);
        make.height.equalTo(@(44));
    }];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(clickCompletion) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:PaxComplete forState:UIControlStateNormal];
    [topview addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topview);
        make.right.equalTo(topview).offset(-16);
        make.width.equalTo(@(100));
    }];
    
    
    UIPickerView *pick = [[UIPickerView alloc]init];
    _pickView = pick;
    pick.delegate = self;
    pick.dataSource = self;
    [self addSubview: pick];
    [pick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(Weakself);
        make.top.equalTo(Weakself).offset(44);
    }];
    
}
// MARK: - 点击了完成
- (void)clickCompletion
{
    
}


//MARK: - 数据源代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"第%zd行",row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    PaxLog(@"%@",[NSString stringWithFormat:@"第%zd行",row]);
}
@end
