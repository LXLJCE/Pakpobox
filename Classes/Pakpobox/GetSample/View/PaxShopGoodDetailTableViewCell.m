//
//  PaxShopGoodDetailTableViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/25.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxShopGoodDetailTableViewCell.h"
#import "PaxShopGoodDetail.h"
@interface PaxShopGoodDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *pin;
@property (weak, nonatomic) IBOutlet UIImageView *sqimg;

@end


@implementation PaxShopGoodDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(PaxShopGoodDetail *)model
{
    _model = model;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"snap1"]];
    
    self.pin.text = model.pin;
    self.sqimg.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:model.qrcode imageViewWidth:self.sqimg.height];
    
}
@end
