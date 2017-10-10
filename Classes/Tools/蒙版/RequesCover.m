//
//  RequesCover.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/21.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RequesCover.h"

@interface RequesCover ()
@property (weak, nonatomic) IBOutlet UIImageView *animView;

@end

@implementation RequesCover


+ (instancetype)requestCover
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}



@end
