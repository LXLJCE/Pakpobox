//
//  PaxDetergentCollectionViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/5.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxDetergentCollectionViewCell.h"
#import "PaxDetergentModel.h"
@interface PaxDetergentCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
@implementation PaxDetergentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(PaxDetergentModel *)model
{
    _model = model;
    _name.text = model.name;
    _price.text = [NSString stringWithFormat:@"$%f",model.price];
}
@end
