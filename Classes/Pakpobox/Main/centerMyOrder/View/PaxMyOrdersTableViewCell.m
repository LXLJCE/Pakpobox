//
//  PaxMyOrdersTableViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/4/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxMyOrdersTableViewCell.h"
#import "PaxMyOrderModel.h"
@interface PaxMyOrdersTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *contentList;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *payStatus;
@property (weak, nonatomic) IBOutlet UILabel *order_status;

@end
@implementation PaxMyOrdersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_contentList backColor:Pax_White cornerRadius:20 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PaxMyOrderModel *)model
{
    
    _model = model;
    _name.text = model.name;
    _order_status.text = model.order_status;
    _payStatus.text = model.pay_status;
    _time.text = model.time;
}
@end
