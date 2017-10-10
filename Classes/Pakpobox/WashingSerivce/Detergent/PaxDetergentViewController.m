//
//  PaxDetergentViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/5/5.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxDetergentViewController.h"
#import "PaxDetergentCollectionViewCell.h"
#import "PaxDetergentModel.h"
@interface PaxDetergentViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

static NSString *cellID = @"PaxDetergentCollectionViewCell";
@implementation PaxDetergentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navText = @"商品表";
    [self.collection registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)_collection.collectionViewLayout;
    
    CGFloat width = (self.collection.width - 16 * 2) / 3;
    flow.itemSize = CGSizeMake(width, 200);
    flow.minimumLineSpacing = 16;
    flow.minimumInteritemSpacing = 16;
    [self.collection registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    PaxDetergentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.handle(self.models[indexPath.row]);
    [self.navigationController popViewControllerAnimated:true];
}
@end
