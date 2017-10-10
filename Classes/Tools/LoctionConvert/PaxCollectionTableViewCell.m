//
//  PaxCollectionTableViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/3.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxCollectionTableViewCell.h"
#import "PaxCollectionModel.h"
@interface PaxCollectionTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *expressNum;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIView *superView;

@end

@implementation PaxCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_superView backColor:Pax_White cornerRadius:20 borderColor:[UIColor clearColor] borderWidth:1 isShadow:true];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PaxCollectionModel *)model
{
    _model = model;
    _expressNum.text = model.expressNumber;
    _location.text = model.location;
    _status.text = [NSString stringWithFormat:@"%@ >",model.status];
}

@end
