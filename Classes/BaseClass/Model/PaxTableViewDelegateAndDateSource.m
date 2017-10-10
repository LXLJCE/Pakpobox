//
//  PaxTableViewDelegateAndDateSource.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/21.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxTableViewDelegateAndDateSource.h"

@implementation PaxTableViewDelegateAndDateSource


- (NSArray *)items
{
    if(_items == nil){
        NSArray *model = [[NSArray alloc]init];
        _items = model;
    }
    return _items;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 99;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellID];
//    [cell setValue:_items[indexPath.row] forKeyPath:@"model"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行", indexPath.row];
    cell.textLabel.font = Pax_Font_Collection_Selector_title;
    cell.textLabel.textColor = Pax_Color_Collection_Selector_Title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self clickSelectWith:[tableView cellForRowAtIndexPath:indexPath]];
}

- (void)clickSelectWith:(UITableViewCell *)cell{

}
@end
