//
//  PaxShopGoodsListTableViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/25.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxShopGoodsListTableViewCell.h"
@interface PaxShopGoodsListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;

@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation PaxShopGoodsListTableViewCell

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
    /*
     @{@"id":model.shopID,
     @"pic":model.pic_url,
     @"price":@(model.price),
     @"amount": @0
     
     */
    if (dict[@"first"] != nil && ![dict[@"first"] isEqualToString:@""]) {
        self.firstLabel.text = dict[@"first"];
        self.amount.text = dict[@"amount"];
        self.price.text = dict[@"price"];
    }else if(dict[@"last"] != nil){
        self.price.text = [NSString stringWithFormat:@"%.2f",[dict[@"price"] floatValue]];
    }else{
    
//    self.firstLabel.text = dict[@"firstLabel"];
    self.amount.text = [NSString stringWithFormat:@"%zd",[dict[@"amount"] integerValue]];
    self.price.text = [NSString stringWithFormat:@"%.2f",[dict[@"price"] floatValue]];
    
    if([dict[@"pic"] isEqualToString:@""] || dict[@"pic"] == nil){
        
        
        
        
    }else{
        
        
        
        [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"pic"]] placeholderImage:[UIImage imageNamed:@"snap1"]];
    }
    
    }
    
}

@end
