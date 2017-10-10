//
//  MiSearchBar.m
//  miSearch
//
//  Created by miicaa_ios on 16/8/3.
//  Copyright (c) 2016年 xuxuezheng. All rights reserved.
//

#import "MiSearchBar.h"

@interface MiSearchBar()<UITextFieldDelegate>{
    
    
}

@property (strong, nonatomic) UILabel *searchLabel;

@end

@implementation MiSearchBar

-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    
   
    self.searchBarStyle = UISearchBarStyleMinimal;
    
    NSMutableString *blankString = [[NSMutableString alloc] init];
    
    int numberOfBlankCharacter = frame.size.width * 0.2;
    
    for (int i = 0; i < numberOfBlankCharacter; i++) {   //根据searchBar的长度计算应该插入多少个空格占位
        
        [blankString appendString:@" "];
    }
    
    self.placeholder = blankString;
//    self.backgroundColor = [UIColor colorWithWhite:1 alpha:1.0];
    UITextField *searchField = [self valueForKey:@"searchField"];
    self.searchTextField = searchField;
    self.searchTextField.delegate = self;
    self.searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 255, 30)];
    self.searchLabel.textColor = [UIColor colorWithWhite:0.418 alpha:0.650];
    self.searchLabel.font = Pax_Font_Button;
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.font = Pax_Font_Button;
    //        searchField.background = [UIImage imageNamed:@"ic_top"];
//    searchField.backgroundColor = searchField.backgroundColor = [UIColor whiteColor];
//    searchField.layer.cornerRadius = 10.0;
    [searchField backColor:Pax_White cornerRadius:6.0 borderColor:Pax_Border_Grey borderWidth:1.0 isShadow:false];
//    searchField.layer.masksToBounds = true;
    searchField.leftViewMode=UITextFieldViewModeNever;
    searchField.textColor=Pax_Black;
    //改变placeholder的颜色
    
    [searchField setValue:Pax_Text_Grey forKeyPath:@"_placeholderLabel.textColor"];
    searchField.placeholder = placeholder;
    [self.searchTextField addSubview:self.searchLabel];
    
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.searchLabel setHidden:YES];

}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length == 0) {
        
        [self.searchLabel setHidden:NO];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.searchTextField.frame = self.bounds;
}
@end
