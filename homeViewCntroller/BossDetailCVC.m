//
//  BossDetailCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/13.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "CSStickyHeaderFlowLayout.h"
#import "BossDetailCVC.h"
#import "Boss+CoreDataProperties.h"
#import "MyADTransition.h"
#import "BossDetailHeadCell.h"
#import "BossDetailCell.h"
#import "BossDetailModel.h"
#import "BossDetailSectionHeaderCell.h"
@interface BossDetailCVC ()

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) Boss *theBoss;
@property (strong,nonatomic) BossDetailHeadCell *headerCell;
@property (strong,nonatomic) NSArray *titles;
@property (strong,nonatomic) NSArray *describe;
@property (strong,nonatomic) BossDetailModel *viewModel;
@property (strong,nonatomic) NSArray *titleNum;

@end

@implementation BossDetailCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout boss:(Boss *)theBoss{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[BossDetailModel alloc]initWitdBossId:theBoss.boss_Id];
        self.theBoss = theBoss;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.view.backgroundColor = FlatWhite;
    self.collectionView.backgroundColor = FlatWhite;
    self.title = self.theBoss.chName;
    [self setDataForArray];
    [self bindWithReactive];
    [self.viewModel downloadData];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FlatGreenDark};
    [self.collectionView registerClass:[BossDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[BossDetailSectionHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    [self.collectionView registerClass:[BossDetailHeadCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                   withReuseIdentifier:@"header"];
    [self reloadLayout];
}

- (void)bindWithReactive{
    @weakify(self);
    [RACObserve(self.viewModel, allData)  subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x.count>0) {
            [self.viewModel saveDataToCoreData];
        }
    }];
    
    [RACObserve(self.viewModel, reload) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.intValue==1) {
            [self.collectionView reloadData];
        }
    }];
}

- (void)reloadLayout {
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width-20, 40.0f);
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width/2);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width/2);
        layout.parallaxHeaderAlwaysOnTop = NO;
        layout.disableStickyHeaders = YES;
    }
}

- (void)setDataForArray{
    self.titles = @[@"攻击力",@"攻击间隔和范围",@"移动速度",@"散值影响",@"特殊能力",@"掉落物品",@"出生区域"];
    self.titleNum = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六"];
    NSString *add = [NSString stringWithFormat:@"攻击距离%@|攻击范围 %@",self.theBoss.atkPeriod,self.theBoss.atkRange];
    self.describe = @[self.theBoss.atk,add,self.theBoss.moveSpeed,self.theBoss.sanityEffect,self.theBoss.specialAbility,self.theBoss.loot,self.theBoss.bornRegion];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1+[self.viewModel getSectionCount];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return self.titles.count;
    }else if (section==1){
        return [self.viewModel getType0Count];
    }else{
        return [self.viewModel getType1Count];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIFont *font = [UIFont systemFontOfSize:13];
    CGFloat width = self.view.frame.size.width - 60;
    if (indexPath.section == 0) {
        NSArray *num = [self.describe[indexPath.row] componentsSeparatedByString:@"|"];
        CGFloat height1 = (num.count-1) * 16.513672;
        CGFloat height = [self findHeightForText:self.describe[indexPath.row] havingMaximumWidth:width andFont:font];
        return CGSizeMake(self.view.frame.size.width-20, 30+height+height1);
    }else{
        NSString *temp = [self.viewModel getDescribe:indexPath.section andRow:indexPath.row];
        CGFloat height = [self findHeightForText:temp havingMaximumWidth:width andFont:font];
        return CGSizeMake(self.view.frame.size.width-20, 30+height);
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)findHeightForText:(NSString *)text havingMaximumWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size.height;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BossDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section==0) {
        cell.title.text = self.titles[indexPath.row];
        cell.describe.text = [self.describe[indexPath.row] stringByReplacingOccurrencesOfString:@"|" withString:@"\n"];
    }else if(indexPath.section==1){
        cell.title.text = [NSString stringWithFormat:@"方 案(%@)",self.titleNum[indexPath.row]];
        cell.describe.text = [self.viewModel getDescribe:indexPath.section andRow:indexPath.row];
    }
    else{
        cell.title.text = [NSString stringWithFormat:@"小 结(%@)",self.titleNum[indexPath.row]];
        cell.describe.text = [self.viewModel getDescribe:indexPath.section andRow:indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]){
        _headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"
                                                                forIndexPath:indexPath];
        _headerCell.backgroundColor = FlatWhite;
        _headerCell.chName.text = self.theBoss.chName;
        _headerCell.enName.text = self.theBoss.enName;
        _headerCell.bossType.text = self.theBoss.bossType;
        _headerCell.life.text = [NSString stringWithFormat:@"生命值: %@",self.theBoss.life];
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.theBoss.urlStr];
        if (image) {
            _headerCell.image.image = image;
        }else{
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.theBoss.urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
                _headerCell.image.image = image;
            }];
        }
        return _headerCell;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BossDetailSectionHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionHeader"
                                                                          forIndexPath:indexPath];
        cell.backgroundColor = FlatWhite;
        if (indexPath.section==0) {
            cell.title.text = @"基本特征";
        }else if (indexPath.section==1){
            cell.title.text = @"击杀方案";
        }else{
            cell.title.text = @"个人小结";
        }
        return cell;
    }
    return nil;
}

- (UIBarButtonItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIBarButtonItem alloc]init];
        UIImage *bgImage = [UIImage imageNamed:@"back"];
        [_leftItem setImage:bgImage];
        @weakify(self);
        _leftItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]animated:YES];
            return [RACSignal empty];
        }];
    }
    return _leftItem;
}

@end
