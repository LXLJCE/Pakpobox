//
//  PaxSamplesViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/29.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxSamplesViewController.h"
#import "PaxSelectMapViewController.h"
#import "PaxNearbyModel.h"
#import "PaxSampleShopModel.h"
#import "PaxShopCollectionViewCell.h"
#import "PaxPaypal.h"
#import "PaxShopGoodsListTableViewCell.h"
#import "PaxShopGoodDetailViewController.h"
@interface PaxSamplesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource,PayPalPaymentDelegate>


@property (strong, nonatomic) PaxPaypal *model;

@property (weak,nonatomic) UILabel *numLabel;

@property (assign, nonatomic) float total;

@property (strong, nonatomic) PaxNearbyModel *locationModel;

/**
 说明性文字
 */
@property (weak, nonatomic) UILabel *intro1Label;
@property (weak, nonatomic) UILabel *intro2Label;

/**
 商品列表内容
 */
@property (weak, nonatomic) UIView *bottomView;

/**
 购物车列表
 */
@property (strong, nonatomic) UIView *shoppingView;


/**
 购物列表
 */
@property (weak, nonatomic) UIView *shopGoodsView;

@property (weak, nonatomic) UITableView *shopGoodsList;

/*
 产品 介绍
 */
@property (strong, nonatomic)UIView *shoppingDetail;


/**
 提交
 */
@property (weak, nonatomic) UIButton *confirm;

/**
 取消
 */
@property (weak, nonatomic) UIButton *cancelX;


/**
 freeSample
 */
@property (weak, nonatomic) UILabel *freeList;

/**
 location
 */
@property (weak, nonatomic) UILabel *locationLabel;


/**
 商品分类列表
 */
@property (weak, nonatomic) UITableView *listTable;


/**
 商品分类列表囊括图
 */
@property (weak ,nonatomic) UIView *listView;



/**
 商品分类 数据
 */
@property (strong, nonatomic) NSArray *listArr;



/**
 商品信息
 */
@property (strong, nonatomic) NSMutableArray *shopArr;

/**
 商品视图
 */
@property (weak, nonatomic) UICollectionView *shopColl;


/**
 蒙版
 */
@property (weak, nonatomic) UIView *cover;



/**
 购物车数据
 */
@property (strong, nonatomic) NSMutableArray *shoppingCarData;


@property (strong, nonatomic) NSDictionary *responObject;
@end


static NSString *cellID = @"PaxShopCollectionViewCell";

static NSString *goodCellID = @"PaxShopGoodsListTableViewCell";

@implementation PaxSamplesViewController


- (NSMutableArray *)shoppingCarData
{
    if(_shoppingCarData == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _shoppingCarData = model;
        [_shoppingCarData insertObject:@{@"first":@"图片", @"amount":@"数量", @"price":@"价格"} atIndex:0];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"last":@"1", @"price":@(_total)}];
        [_shoppingCarData addObject:dict];
    }
    return _shoppingCarData;
}

- (NSMutableArray *)shopArr
{
    if(_shopArr == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _shopArr = model;
    }
    return _shopArr;
}

- (NSArray *)listArr
{
    if(_listArr == nil){
        NSArray *model = [[NSArray alloc]init];
        _listArr = model;
    }
    return _listArr;
}


#pragma mark - 生命周期方法
/**
 声明周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupColor];
    [self setupFont];
    [self setupText];
    [self rac_event];
    _total = 0;
    self.model = [[PaxPaypal alloc]init];
    [self networkRequestFreeList];
    
}

- (void)addShoppingView
{
    
    
    
    
    LXLWeakSelf(self);
    [self.view addSubview:self.shoppingView];
    [_shoppingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(24);
        make.height.mas_equalTo(50 * (2+2) + 30 + 10 + 50);
    }];
    _shoppingView.hidden = true;
}
/**
 UI设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 顶部资源
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 24, 25, 20, 20)];
    label.textColor = Pax_White;
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [label backColor:Pax_Red cornerRadius:10 borderColor:[UIColor clearColor] borderWidth:0 isShadow:false];
    [self.view addSubview:label];
    label.text = @"0";
    _numLabel = label;
    label.hidden = true;
    
    
    UIView *topContent = [[UIView alloc]init];
    [self.view addSubview:topContent];
    [topContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(64 + 20);
        make.left.equalTo(Weakself.view).offset(24);
        make.right.equalTo(Weakself.view).offset(-24);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *intro1 = [[UILabel alloc]init];
    _intro1Label = intro1;
    intro1.numberOfLines = 0;
    [topContent addSubview:intro1];
    [intro1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topContent);
    }];
    
    UILabel *intro2 = [[UILabel alloc]init];
    _intro2Label = intro2;
    [topContent addSubview:intro2];
    [intro2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(intro1.mas_bottom).offset(10);
        make.left.right.equalTo(topContent);
    }];
    
    //TODO: 中间资源
    UIView *centerTop = [[UIView alloc]init];
    [self.view addSubview:centerTop];
    [centerTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topContent.mas_bottom).offset(10);
        make.centerX.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(40);
        make.height.mas_equalTo(90);
    }];
    
    UIView *select1 = [self setupUnit:PaxFreeSamples click:@selector(clickfreeList)];
    [centerTop addSubview:select1];
    [select1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerTop);
        make.height.mas_equalTo(40);
    }];
    
    
    
    
    
    
    
    
    
    UIView *select2 = [self setupUnit:PaxShowNearstLocker click:@selector(clickLocation)];
    [centerTop addSubview:select2];
    [select2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(select1.mas_bottom).offset(10);
        make.left.right.equalTo(centerTop);
        make.height.mas_equalTo(40);
    }];
    
    
    //TODO: 底部资源
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerTop.mas_bottom).offset(10);
        make.left.right.equalTo(topContent);
        make.bottom.equalTo(Weakself.view).offset(-44);
    }];
    
    
    
    //TODO: 导航栏右
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"购物车" style:UIBarButtonItemStyleDone target:self action:@selector(clickShopping)];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view addSubview:[self setupBottomView:_bottomView.frame]];
    
    
    
    [self addShoppingView];
    
    
    [self notStartSet];
    
}
- (void)addShopGoodsList
{
    if (_shopGoodsList != nil) {
        return;
    }
    
    UITableView *list = [[UITableView alloc]initWithFrame:_shopGoodsView.bounds style:UITableViewStylePlain];
    [_shopGoodsView addSubview:list];
    _shopGoodsList = list;
    list.delegate = self;
    list.dataSource = self;
    
    [list registerNib:[UINib nibWithNibName:goodCellID bundle:nil] forCellReuseIdentifier:goodCellID];
    
    
}
- (void)addListView{

    if(_cover == nil){
    UIView *cover = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:cover];
    _cover = cover;
    cover.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    cover.hidden = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCover)];
    [_cover addGestureRecognizer:tap];
    
    
    
    UIView *list = [[UIView alloc]initWithFrame:CGRectMake(40, 200, self.view.width - 80, 120)];
    [self.view addSubview:list];
    
    
    
    [list backColor:Pax_White cornerRadius:6 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    
    
    _listView = list;
    list.hidden = true;
    
    UITableView *table = [[UITableView alloc]initWithFrame:_listView.bounds style:UITableViewStylePlain];
    _listTable = table;
    [_listView addSubview:_listTable];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listView.hidden = true;
    }
}


- (void)clickCover
{
    _cover.hidden = true;
    _listView.hidden = true;
}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.shopGoodsList) {
        return self.shoppingCarData.count;
    }else{
    
    return self.listArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.shopGoodsList) {
        PaxShopGoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodCellID];
        
        cell.dict = self.shoppingCarData[indexPath.row];
        
        return cell;
        
    }else{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.listArr[indexPath.row][@"name"];
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.listView setHidden:true];
    self.cover.hidden = true;
    _freeList.textColor = Pax_Black;
    
    if (![_freeList.text isEqualToString:self.listArr[indexPath.row][@"name"]]) {
        _freeList.text = self.listArr[indexPath.row][@"name"];
        
        
        
        [self networkRequestShopWith:self.listArr[indexPath.row][@"id"]];
    }
    
    
}

/**
 设置底部
 */
- (UICollectionView *)setupBottomView:(CGRect)frame
{
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor clearColor];
    CGFloat width = (ScreenWidth - 2 * 24 - 20)/3;
    CGFloat height = width * 1.5;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(width, height);
    collectionView.collectionViewLayout = flowLayout;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    
    _shopColl = collectionView;
    return collectionView;
}

#pragma mark - Dategate/DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shopArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PaxShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor cz_randomColor];
    
    LXLWeakSelf(self);
    
    
    cell.model = self.shopArr[indexPath.row];
    
//    CGRect rect =[cell.image convertRect:cell.image.frame toView:self.view];
//    
//    rect.origin.x = rect.origin.x + 24;
//    rect.origin.y = rect.origin.y + 254;
//    
//    NSLog(@"%@",NSStringFromCGRect(rect));
//    UIImageView *image = [[UIImageView alloc]initWithFrame:rect];
//    image.contentMode = UIViewContentModeCenter;
    cell.clickPlus = ^(PaxSampleShopModel *model){

        _total = _total + model.price;
        Weakself.numLabel.hidden = false;
        Weakself.numLabel.text = [NSString stringWithFormat:@"%zd", [Weakself.numLabel.text integerValue] + 1];
        
        BOOL have = false;
        for (NSMutableDictionary *dict in Weakself.shoppingCarData) {
            if ([dict[@"id"] isEqualToString:model.shopID]) {
                have = true;
                NSInteger amount = [dict[@"amount"] integerValue];
                
                [dict setValue:@(amount + 1) forKey:@"amount"];
            }
            
        }
        if (!have) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary: @{@"id":model.shopID,
                                   @"pic":model.pic_url,
                                    @"amount": @1,
                                   @"price":@(model.price),
                                       }];
            [Weakself.shoppingCarData insertObject:dict atIndex:Weakself.shoppingCarData.count - 1];
        }
        
    };
    [cell backColor:Pax_White cornerRadius:0 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    return cell;
}


- (void)networkRequestShopWith:(NSString *)liId
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_GetGoodsQueryTipMessage:PaxPleasewaitamomentLoad categoryID:liId Finish:^(id responseObject, NSError *error) {
        NSArray *resy = (NSArray *)responseObject[@"resultList"];
        
        if (resy.count == 0) {
            [PaxHUD Pax_showSuccessWithStatus:PaxSorrnodatayouwant];
            return ;
        }
        [Weakself.shopArr addObjectsFromArray: [PaxSampleShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"resultList"]]];
        
        [Weakself.shopColl reloadData];
        
        
    }];
}


/**
 点击地点触发
 */
- (void)clickLocation
{
    LXLWeakSelf(self);
    PaxSelectMapViewController *sm = [[PaxSelectMapViewController alloc]init];
    sm.selectLoction = ^(PaxNearbyModel *model) {
        Weakself.locationLabel.textColor = Pax_Black;
        Weakself.locationLabel.text = model.name;
        Weakself.locationModel = model;
    };
    sm.hidesBottomBarWhenPushed  = true;
    [self.navigationController pushViewController:sm animated:true];
}

/**
 点击分类触发
 */
- (void)clickfreeList
{
    [self addListView];
    [self.listTable reloadData];
    _listView.hidden = false;
    _cover.hidden = false;
}

/**
 单元组件

 @param title 占位符
 @return 返回组件
 */
- (UIView *)setupUnit:(NSString *)title click:(SEL)block
{
    UIView *contentView = [[UIView alloc]init];
    [contentView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    UILabel *textLabel = [[UILabel alloc]init];
    [contentView addSubview:textLabel];
    textLabel.font = Pax_Font_Text;
    textLabel.textColor = Pax_Text_Grey;
    textLabel.text = title;
    if ([title isEqualToString:PaxFreeSamples]) {
        _freeList = textLabel;
    }else if([title isEqualToString:PaxShowNearstLocker]){
        _locationLabel = textLabel;
    }
    
    
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.left.equalTo(contentView).offset(10);
        make.right.equalTo(contentView).offset(-50);
    }];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:@"img_jlcx_xl_sanjiao"];
    [contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(contentView);
        make.width.mas_equalTo(50);
    }];
    if (block != nil) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:block];
        [contentView addGestureRecognizer:tap];
    }
    
    
    return contentView;
}

/**
 字体设置
 */
- (void)setupFont
{
    _intro1Label.font = Pax_Font_Text;
    _intro2Label.font = Pax_Font_Text;
    
}

/**
 颜色设置
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _intro1Label.textColor = Pax_Black;
    _intro2Label.textColor = Pax_Black;
    
}

/**
 内容设置
 */
- (void)setupText
{
    self.navText = PaxSamples;
    self.rightTitle = @"购物车";
    _intro1Label.text = PaxYoucanredeemfreeandpremiumsamplesatPakpobox;
    _intro2Label.text = PaxYouget3freesampleseverymonth;
    
}

/**
 图片设置
 */
- (void)setupImage
{
    
}
/**
 事件设置
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    
}

- (void)clickPax
{
    [self clickShopping];
   
}

/**
 非开始设置
 */
- (void)notStartSet
{
    
    _confirm.titleLabel.font = Pax_Font_Button;
    [_cancelX setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    
    [_confirm setTitle:PaxConfirm forState:UIControlStateNormal];
    
    [_confirm setTitleColor:Pax_Black forState:UIControlStateNormal];
    
    
    
    
    
    LXLWeakSelf(self);
    [[_cancelX rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _shoppingView.hidden = true;
//        [_shoppingCarData removeLastObject];
    }];
    [[_confirm rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _shoppingView.hidden = true;
        
        [Weakself networkRequestShopGoods];
        
        
    }];
}

- (void)networkRequestShopGoods
{
    LXLWeakSelf(self);
    
    
    
    NSDictionary *user = [PaxDataSave getUserMessage];
    
    
    //NSDictionary *goodInfo = @{
    // @"items" : @[
    //   @{
    // @"amount":[NSString stringWithFormat:@"%f", _detergentModel.price * 1],
    //  @"price":[NSString stringWithFormat:@"%f", _detergentModel.price * 1],
    //    @"quantity":@"1",
    //     @"sku_id":_detergentModel.detergent_id
    //     }
    //          ]
    //  };
    /*
     NSString *goodsInfo = [NSString stringWithFormat:@"{\"items\":[{\"amount\":%f,\"price\":%f, \"quantity\":%zd,\"sku_id\":%@}]}",_detergentModel.price *1, _detergentModel.price,1,_detergentModel.detergent_id];
     */
    
    NSMutableDictionary *di = [NSMutableDictionary dictionary];
   
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < _shoppingCarData.count-1; i++) {
        NSDictionary *dict = _shoppingCarData[i];
        NSDictionary *data = @{@"amount": @([dict[@"price"] floatValue] * [dict[@"amount"] integerValue]),@"price": dict[@"price"], @"quantity":dict[@"amount"], @"product_id":dict[@"id"]};
        [arr addObject:data];
    }
    [di setObject:arr forKey:@"items"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:di options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSArray *strArr = [str componentsSeparatedByString:@"\n"];
    str = @"";
    for (NSString *substr in strArr) {
        str = [str stringByAppendingString:substr];
    }
    
    if (_locationModel == nil) {
        [PaxHUD Pax_showErrorWithStatus:PaxPleaseSelectALocker];
        return;
    }
    
    [[LXLNetWorkTool shareTools]Pax_WashCreateorderWithTipMessage:PaxPleasewaitamomentLoad login_name:user[@"email"] == nil? @"" :user[@"email"]Phone:user[@"phoneNumber"] == nil ? @"" :user[@"phoneNumber"]   amount:_total giftcardamount:0 totalamount:_total productname:@"商城订单" productdesc:@"" goodsinfo:str clienttype:@"IOS" giftcardno:@"" Integral:0 ordertype:@"SAMPLE" Box:@{@"id" : _locationModel.nearbyId} paytype:@"NONE" Finish:^(id responseObject, NSError *error) {
        
        
        Weakself.responObject = responseObject;
        [PaxHUD Pax_showSuccessWithStatus:PaxGetSuccess];
        
        [Weakself PayAbout];
        
        
        
    }];
}
- (void)clickShopping
{
    
    
     [self addShopGoodsList];
    
    _shoppingView.hidden = false;
    
    /*
     @{@"id":model.shopID,
     @"pic":model.pic_url,
     @"price":@(model.price),
     @"amount": @0

     */
    
    
    if ([_shoppingCarData.lastObject[@"last"] isEqualToString:@"1"]) {
        _shoppingCarData.lastObject[@"price"] = @(_total);
    }else{
        
    }
    
    
    
    
    [_shopGoodsList reloadData];
}


/**
 懒加载 shoppingView

 @return 购物详情界面
 */

- (UIView *)shoppingView
{
    if (_shoppingView == nil) {
        UIView *shoppingView = [[UIView alloc]init];
        _shoppingView = shoppingView;
        
        
        UIView *content = [[UIView alloc]init];
        [shoppingView addSubview:content];
        [content backColor:Pax_White cornerRadius:0 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(shoppingView).offset(15);
            make.bottom.right.equalTo(shoppingView).offset(-15);
        }];
        UIButton *cancel = [[UIButton alloc]init];
        cancel.imageView.contentMode = UIViewContentModeCenter;
        _cancelX = cancel;
        [shoppingView addSubview:cancel];
        [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(shoppingView);
            make.width.height.mas_equalTo(30);
        }];
        
        
        
        UIButton *confirm = [[UIButton alloc]init];
        _confirm = confirm;
        [confirm backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:true];
        [content addSubview:confirm];
        [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(content).offset(-15);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(80);
        }];
        
        UIView *order = [[UIView alloc]init];
        order.backgroundColor = [UIColor cz_randomColor];
        [content addSubview:order];
        [order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(content).offset(15);
            make.right.equalTo(content).offset(-15);
            make.bottom.equalTo(confirm.mas_top).offset(-10);
        }];
        
        self.shopGoodsView = order;
        
//        UIImageView *orderImg = [[UIImageView alloc]init];
//        [order addSubview:orderImg];
//        
//        orderImg.contentMode = UIViewContentModeScaleToFill;
//        orderImg.image = [UIImage imageNamed:@"pack"];
//        [orderImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.left.right.equalTo(order);
//        }];

        
    }
    
    return _shoppingView;
}


/**
 获取 free Sample 列表栏
 */
- (void)networkRequestFreeList{
    
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_GetSampleListTipMessage:PaxPleasewaitamomentLoad categoryType:@"" Finish:^(NSArray * responseObject, NSError *error) {
        
        if (responseObject.count == 0) {
            [PaxHUD Pax_showSuccessWithStatus:PaxSorrnodatayouwant];
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            [arr addObject:dict];
        }
        Weakself.listArr  = [NSArray arrayWithArray:arr];
//        [Weakself.listTable reloadData];
        if (arr.count != 0) {
            Weakself.freeList.textColor = Pax_Black;
            Weakself.freeList.text = arr[0][@"name"];
            [Weakself networkRequestShopWith:arr[0][@"id"]];
        }
        
        
    }]; 
}





- (void)PayAbout
{
    
    
    
            PayPalPayment *payment = [[PayPalPayment alloc] init];
    
                payment.amount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.f",_total]];
           
            
            
            //货币类型-RMB是没用的
            payment.currencyCode = @"USD";
            
            //订单描述
            payment.shortDescription = @"Hipster clothing";
            
            
            
            
            //生成paypal控制器，并模态出来(push也行)
            //将之前生成的订单信息和paypal配置传进来，并设置订单VC为代理
            PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment                                                                                            configuration:self.model.payPalConfig                                                                                                 delegate:self];
            
            //模态展示
            [self presentViewController:paymentViewController animated:YES completion:nil];
        

}

//订单支付完成后回调此方法
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    [_shoppingCarData removeAllObjects];
    _numLabel.text = @"0";
    _numLabel.hidden = true;
    [PaxHUD Pax_showSuccessWithStatus:[NSString stringWithFormat:@"%@,$%.2f",PaxPaySuccess,_total]];
    //回调的 PayPalPayment 的 confirmation 属性包含此次订单的状态信息包括校验码，服务器可已通过该校验码验证交易真实性。
    //返回数据 - id所对应的就是校验码。
    /*
     {
     client =     {
     environment = sandbox;
     "paypal_sdk_version" = "2.14.2";
     platform = iOS;
     "product_name" = "PayPal iOS SDK";
     };
     response =     {
     "create_time" = "2016-05-12T03:25:49Z";
     id = "PAY-6BG56850AF923584SK4Z7PNQ";
     intent = sale;
     state = approved;
     };
     "response_type" = payment;
     }
     */
    LXLWeakSelf(self);
    [paymentViewController dismissViewControllerAnimated:true completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself push];
        });
        
    }];
    
}

//用户取消支付回调此方法
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    LXLWeakSelf(self);
    [PaxHUD Pax_showErrorWithStatus:PaxPayCancel];
    [paymentViewController dismissViewControllerAnimated:true completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Weakself push];
        });
    }];
    
}

- (void)push
{
    PaxShopGoodDetailViewController *vc = [[PaxShopGoodDetailViewController alloc]init];
    vc.navText = PaxDetail;
    vc.detail_id = _responObject[@"id"];
    [self.navigationController pushViewController:vc animated:true];
}
@end
