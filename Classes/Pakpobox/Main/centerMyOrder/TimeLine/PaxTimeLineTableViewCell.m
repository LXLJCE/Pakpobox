//
//  PaxTimeLineTableViewCell.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/2.
//  Copyright © 2017年 bx. All rights reserved.
//
#import "PaxTimeLineTableViewCell.h"
#import "PaxTimeLineModel.h"

@interface PaxTimeLineTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *circleLine;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
@implementation PaxTimeLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
}


- (void)setModel:(PaxTimeLineModel *)model
{
    _model = model;

    if (model.isShow) {
        [_circleLine backColor:Pax_White cornerRadius:9 borderColor:Pax_Orange borderWidth:2 isShadow:false];
        _line.backgroundColor = Pax_Orange;
    }else{
        [_circleLine backColor:Pax_White cornerRadius:9 borderColor:Pax_Border_Grey borderWidth:2 isShadow:false];
        _line.backgroundColor = Pax_Border_Grey;
    }
    
    
    
    _title.text = model.time;
    _subTitle.text = model.customerStoreNumber;
    _status.text = model.status;
}
@end
