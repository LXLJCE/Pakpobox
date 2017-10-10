//
//  PaxTipCollectionViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/17.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxTipCollectionViewCell.h"
#import "PaxTipModel.h"
#import "PaxRLButton.h"
@interface PaxTipCollectionViewCell ()

@property (weak, nonatomic) IBOutlet PaxRLButton *content;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation PaxTipCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _checkImg.image = [UIImage imageNamed:@"check"];
}
- (void)setModel:(PaxTipModel *)model
{
    _model = model;
    _nameLabel.text = model.name;
    if (model.isSelect) {
        _checkImg.image = [UIImage imageNamed:@"check_on"];
    }else{
        _checkImg.image = [UIImage imageNamed:@"check"];
    }
    
}
- (IBAction)clickContent:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _checkImg.image = [UIImage imageNamed:@"check_on"];
        _model.isSelect = true;
    }else{
        _checkImg.image = [UIImage imageNamed:@"check"];
        _model.isSelect = false;
    }
    
}
@end
