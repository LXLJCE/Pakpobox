//
//  PaxShopCollectionViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/24.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxShopCollectionViewCell.h"
#import "PaxSampleShopModel.h"
@interface PaxShopCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end

@implementation PaxShopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView backColor:Pax_White cornerRadius:6 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
}

- (void)setModel:(PaxSampleShopModel *)model
{
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"snap1" ]];
    
    self.name.text = model.name;
    self.price.text = [NSString stringWithFormat:@"$%.2f",model.price];
    self.count.text = [NSString stringWithFormat:@"剩余:%zd",model.quantity];
}
- (IBAction)clickPlus:(id)sender {
    
    self.clickPlus(_model);
}
@end
