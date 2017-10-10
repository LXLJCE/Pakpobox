//
//  PaxActivateSamplesViewController.m
//  Pakpobox
//
//  Created by 博兴 on 2017/3/29.
//  Copyright © 2017年 bx. All rights reserved.
//

#import "PaxActivateSamplesViewController.h"
#import "PaxRLButton.h"
#import "PaxTipModel.h"
#import "PaxTipCollectionViewCell.h"
#import "PaxSamplesViewController.h"
@interface PaxActivateSamplesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, THDatePickerDelegate>

/**
 顶部文字
 */
@property (weak, nonatomic) UILabel *topLabel;

/**
 感兴趣label
 */
@property (weak, nonatomic) UILabel *insteredLabel;

/**
 感兴趣的 view
 */
@property (weak, nonatomic) UIView *insteredView;

/**
 各种选项的collect
 */
@property (weak, nonatomic) UIView *collectContentView;

/**
 同意按钮
 */
@property (weak, nonatomic) PaxRLButton *agreeBtn;

/**
 确定按钮
 */
@property (weak, nonatomic) UIButton *sureBtn;


/**
 生日选择框
 */
@property (weak, nonatomic) UIView *birthday;

/**
 日期控件
 */
@property (strong , nonatomic) THDatePickerViewController *datePicker;

/**
 collect 文字选项
 */
@property (strong, nonatomic) NSArray *collectTitles;


/**
 兴趣列表框
 */
@property (weak, nonatomic) UICollectionView *collectionView;

/**
 性别
 */
@property (weak, nonatomic) UILabel *sexLabel;

/**
 生日
 */
@property (weak, nonatomic) UILabel *birthdayLabel;


/**
 选中的兴趣爱好
 */
@property (strong, nonatomic) NSMutableArray *selectTags;
@end


static NSString *cellID = @"PaxTipCollectionViewCell";

@implementation PaxActivateSamplesViewController

- (NSMutableArray *)selectTags
{
    if(_selectTags == nil){
        NSMutableArray *model = [[NSMutableArray alloc]init];
        _selectTags = model;
    }
    return _selectTags;
}

- (NSArray *)collectTitles
{
    if (_collectTitles == nil) {
        _collectTitles = [NSMutableArray array];
    }
    return _collectTitles;
}

/**
 生命周期方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navText = PaxSetYouLike;
    [self setupUI];
    [self setupFont];
    [self setupText];
    [self setupColor];
    [self rac_event];
    [self setupImage];
    [self networkRequest];
    
    
}


/**
 UI设置
 */
- (void)setupUI
{
    LXLWeakSelf(self);
    //TODO: 头部内容
    UIView *topView = [[UIView alloc]init];
    [topView backColor:Pax_White cornerRadius:0 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.view).offset(64 + 40);
        make.left.equalTo(Weakself.view).offset(16);
        make.right.equalTo(Weakself.view).offset(-16);
        make.height.mas_equalTo(60);
    }];
    UILabel *topLabel = [[UILabel alloc]init];
    _topLabel = topLabel;
    topLabel.numberOfLines = 0;
    [topView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(3);
        make.left.equalTo(topView).offset(10);
        make.right.equalTo(topView).offset(-10);
    }];
    
    //TODO: 中间资源
    UIView *centerTop = [[UIView alloc]init];
    [self.view addSubview:centerTop];
    [centerTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.centerX.equalTo(Weakself.view);
        make.left.equalTo(Weakself.view).offset(16);
        make.height.mas_equalTo(90);
    }];
    //TODO: SEX
    UIView *select1 = [self setupUnit:PaxGender];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSex:)];
    [select1 addGestureRecognizer:tap1];
    [centerTop addSubview:select1];
    [select1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerTop);
        make.height.mas_equalTo(40);
    }];
    //TODO: Birthday
    UIView *select2 = [self setupUnit:PaxBirthdayDDMMYYYY];
    _birthday = select2;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBirthday:)];
    [select2 addGestureRecognizer:tap2];
    
    [centerTop addSubview:select2];
    [select2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(select1.mas_bottom).offset(10);
        make.left.right.equalTo(centerTop);
        make.height.mas_equalTo(40);
    }];
    
    
    //TODO: InterestedIn
    UIView *interestedView = [[UIView alloc]init];
    _insteredView = interestedView;
    [self.view addSubview: interestedView];
    [interestedView backColor:Pax_White cornerRadius:0 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    [interestedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerTop.mas_bottom).offset(20);
        make.left.equalTo(Weakself.view).offset(16);
        make.right.equalTo(Weakself.view).offset(-16);
        make.height.mas_equalTo(110);
    }];
    UILabel *In_titleLabel = [[UILabel alloc]init];
    _insteredLabel = In_titleLabel;
    [interestedView addSubview:_insteredLabel];
    [In_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(interestedView).offset(3);
        make.left.equalTo(interestedView).offset(10);
        make.height.mas_equalTo(20);
    }];
    UIView *collectContentView = [[UIView alloc]init];
    _collectContentView = collectContentView;
    [interestedView addSubview:collectContentView];
    [collectContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(In_titleLabel.mas_bottom);
        make.left.right.equalTo(interestedView);
        make.bottom.equalTo(interestedView);
    }];
    
    //TODO: agree
    PaxRLButton *agreeBtn = [[PaxRLButton alloc]init];
    [self.view addSubview:agreeBtn];
    _agreeBtn = agreeBtn;
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(interestedView.mas_bottom);
        make.left.equalTo(Weakself.view).offset(16);
        make.right.equalTo(Weakself.view).offset(-16);
        make.height.mas_equalTo(45);
    }];
    
    
    //TODO: 底部按钮
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow: false];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(agreeBtn.mas_bottom);
        make.height.mas_equalTo(40);
        make.left.equalTo(Weakself.view).offset(16);
        make.right.equalTo(Weakself.view).offset(-16);
//        make.bottom.equalTo(Weakself.view).offset(-20);
    }];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    _sureBtn = sureBtn;
    [bottomView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(bottomView);
    }];

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // TODO: 由于采用outLayout 布局.  Collection需要frame 无法满足,只能在这个方法中添加
    self.collectionView = [self setupCollectionView:_collectContentView.frame];
    [_insteredView addSubview:self.collectionView];
}
/**
 设置Collection
 */
- (UICollectionView *)setupCollectionView:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor clearColor];
    CGFloat width = (ScreenWidth - 2 * 40)/3;
    CGFloat height = 30;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(width, height);
    collectionView.collectionViewLayout = flowLayout;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    return collectionView;
}


/**
 网络请求 - 用于请求标签文字
 */
- (void)networkRequest
{
    LXLWeakSelf(self);
    [[LXLNetWorkTool shareTools] Pax_GetInsterestTagWithTipMessage:PaxPleasewaitamomentLoad Finish:^(NSArray *responseObject, NSError *error) {
        Weakself.collectTitles = [PaxTipModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        
        [Weakself.collectionView reloadData];
    }];
}

/**
 网络请求 用于提交信息完善
 */
- (void)networkRequestWithSubmit
{
    if (![self jianyanParameters]) {
        return;
    }
    
    NSString *gender;
    
    if ([_sexLabel.text isEqualToString:PaxFemale]) {
        gender = @"FEMALE";
    }else{
        gender = @"MALE";
    }
    
    NSDateFormatter *formatter = [NSDateFormatter SignleDateFormatter];
    NSTimeInterval birthdayTimeStac = [formatter dateFromString:_birthdayLabel.text].timeIntervalSince1970 * 1000;
    
    
    
    
    LXLWeakSelf(self);
    NSDictionary *user = [PaxDataSave getUserMessage];
    [[LXLNetWorkTool shareTools] Pax_CompleteProfileWithTipMessage:PaxPleasewaitamomentLoad ID:user[@"id"] gender:gender birthday:birthdayTimeStac interestTags:self.selectTags Finish:^(id responseObject, NSError *error) {
        [PaxDataSave saveUserMessage:responseObject];
//        [Weakself.navigationController popViewControllerAnimated:true];
        PaxSamplesViewController *sm = [[PaxSamplesViewController alloc]init];
        sm.hidesBottomBarWhenPushed = true;
        [Weakself.navigationController pushViewController:sm animated:true];
    }];
}
- (BOOL)jianyanParameters
{
    if ([_sexLabel.text isEqualToString:PaxGender]) {
        [PaxHUD Pax_showErrorWithStatus:PaxPleaseSelectSex];
        return false;
    }else if([_birthdayLabel.text isEqualToString:PaxBirthdayDDMMYYYY]){
        [PaxHUD Pax_showErrorWithStatus:PaxPleaseinputbirthday];
        return false;
    }else if(self.selectTags.count == 0){
        [PaxHUD Pax_showErrorWithStatus:PaxPleaseleaseselectntag];
        return false;
    }else if(!_agreeBtn.selected){
        [PaxHUD Pax_showErrorWithStatus:PaxPleaseagrerelevantclause];
        return false;
    }else{
        return true;
    }
}

#pragma mark - Dategate/DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectTitles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PaxTipCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.collectTitles[indexPath.row];
    
    return cell;
}
/**
 单元组件
 
 @param title 占位符
 @return 返回组件
 */
- (UIView *)setupUnit:(NSString *)title
{
    UIView *contentView = [[UIView alloc]init];
    [contentView backColor:Pax_White cornerRadius:5 borderColor:Pax_Border_Grey borderWidth:1 isShadow:false];
    UILabel *textLabel = [[UILabel alloc]init];
    [contentView addSubview:textLabel];
    textLabel.font = Pax_Font_Text;
    textLabel.textColor = Pax_Text_Grey;
    textLabel.text = title;
    
    if (title == PaxGender) {
        _sexLabel = textLabel;
    }else if(title == PaxBirthdayDDMMYYYY){
        _birthdayLabel = textLabel;
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
    return contentView;
}

/**
 设置字体
 */
- (void)setupFont
{
    _topLabel.font = Pax_Font_Text;
    _insteredLabel.font = Pax_Font_Text;
    _agreeBtn.titleLabel.font = Pax_Font_Text;
    _sureBtn.titleLabel.font = Pax_Font_Button;
}


/**
 设置内容
 */
- (void)setupText
{
    _topLabel.text = PaxDoyoumindsharingafewthingswithus;
    _insteredLabel.text = PaxIminterestedin;
    [_agreeBtn setTitle:PaxAgreetoPakpoboxTermsConditions forState:UIControlStateNormal];
    [_sureBtn setTitle:PaxYesIwantfreesamples forState:UIControlStateNormal];
}


/**
 设置颜色
 */
- (void)setupColor
{
    self.view.backgroundColor = Pax_Bg_Grey;
    _topLabel.textColor = Pax_Black;
    _insteredLabel.textColor = Pax_Black;
    [_agreeBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
    [_sureBtn setTitleColor:Pax_Black forState:UIControlStateNormal];
}

/**
 设置图片
 */
- (void)setupImage
{
    [_agreeBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [_agreeBtn setImage:[UIImage imageNamed:@"check_on"] forState:UIControlStateSelected];
}
/**
 事件绑定
 */
- (void)rac_event
{
    LXLWeakSelf(self);
    [[_agreeBtn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(PaxRLButton *sender) {
        sender.selected = !sender.selected;
    }];
    
    [[_sureBtn rac_signalForControlEvents:UIControlEventTouchDown]subscribeNext:^(id x) {
//        [Weakself.navigationController popViewControllerAnimated:true];
        
        [Weakself.collectTitles enumerateObjectsUsingBlock:^(PaxTipModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelect) {
                NSDictionary *dict = @{@"id": obj.tip_id};
                [Weakself.selectTags addObject:dict];
            }
        }];
        [Weakself networkRequestWithSubmit];
    }];
}

/**
 点击性别

 @param sender 手势
 */
- (void)clickSex:(UITapGestureRecognizer *)sender{
    [self selectSex:sender];
}

/**
 点击生日

 @param sender 手势
 */
- (void)clickBirthday:(UITapGestureRecognizer *)sender{
    [self selectDate:sender];
}

- (void)selectSex:(UITapGestureRecognizer *)sender{
    UIView *selectView = sender.view;
    UILabel *titel;
    for (id sub in selectView.subviews) {
        if ([sub class] == [UILabel class]) {
            titel = (UILabel *)sub;
            titel.textColor = Pax_Black;
        }
    }
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(PaxMale, ^{ /*work here*/
        titel.text = PaxMale;
    }).addButtonWithActionBlock(PaxFemale,^{/**/
        titel.text = PaxFemale;
    });
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleSuccess)
    .title(PaxPleaseSelectSex)
    ;
    [showBuilder showAlertView:builder.alertView onViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    // or even
    showBuilder.show(builder.alertView, [UIApplication sharedApplication].keyWindow.rootViewController);
}


- (void)selectDate:(UITapGestureRecognizer *)sender
{
    if(!self.datePicker){
        self.datePicker = [THDatePickerViewController datePicker];
    }
    self.datePicker.dateTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    self.datePicker.date = [[NSDateFormatter SignleDateFormatter] dateFromString:@"1980-01-01"];
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
//    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:YES];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(0.25),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.25),
                                                                  }];
    
    }


- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    
    for (id sub in _birthday.subviews) {
    if ([sub class] == [UILabel class]) {
        UILabel *subView = (UILabel *)sub;
        subView.textColor = Pax_Black;
        NSDateFormatter *formate = [NSDateFormatter SignleDateFormatter];
        subView.text = [formate stringFromDate:datePicker.date];
    }
}
    PaxLog(@"%@",@"done");
    [datePicker dismissSemiModalView];
   
   }
- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate
{
    for (id sub in _birthday.subviews) {
        if ([sub class] == [UILabel class]) {
            UILabel *subView = (UILabel *)sub;
            subView.textColor = Pax_Black;
            NSDateFormatter *formate = [NSDateFormatter SignleDateFormatter];
            subView.text = [formate stringFromDate:selectedDate];
        }
    }
    

}



- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    PaxLog(@"%@",@"cancel");
    
    [datePicker dismissSemiModalView];
}

@end


