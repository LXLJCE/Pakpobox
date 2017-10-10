//
//  PaxNotificationCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxNotificationCell.h"

@interface PaxNotificationCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation PaxNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    _title.text = dict[@"title"];
    _content.text = dict[@"content"];
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dict[@"createTime"] floatValue] / 1000];
    NSString *ago = [date timeAgo];
    
    _time.text = ago;
    
}
@end
