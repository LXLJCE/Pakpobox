//
//  PaxNearbyTableViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/2.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxNearbyTableViewCell.h"
#import "PaxNearbyModel.h"
@interface PaxNearbyTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end
@implementation PaxNearbyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(PaxNearbyModel *)model
{
    _model = model;
    _name.text = model.name;
    _address.text = model.address;
    _distance.text = [NSString stringWithFormat:@"%zdkm",model.distance];
}
@end
