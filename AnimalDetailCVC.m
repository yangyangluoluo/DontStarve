//
//  AnimalDetailCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "CSStickyHeaderFlowLayout.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "AnimalDetailCVC.h"
#import "Animal+CoreDataProperties.h"
#import "MyADTransition.h"
#import "AnimalCell.h"
#import "UIImageView+WebCache.h"
#import "AnimalDetailCell.h"
#define PREFIX  @"http://192.168.1.220/"
@interface AnimalDetailCVC ()
@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;
@property (strong,nonatomic) Animal *animal;
@property (strong,nonatomic) AnimalCell *headerCell;
@property (strong,nonatomic) NSArray *titles;
@property (strong,nonatomic) NSArray *describe;

@end

@implementation AnimalDetailCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout animal:(Animal *)animal{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.animal = animal;
        self.titles = @[@"生命值",@"攻击力",@"步行速度",@"奔跑速度",@"生物类型",@"群体攻击",@"攻击周期",
                        @"近身智力",@"掉落物品",@"吸引食物",@"出生区域",@"备注"];
        NSString *type = NULL;
        if (animal.type.intValue==0) {
            type = @"被动生物";
        }else if (animal.type.integerValue == 1){
            type = @"中立生物";
        }else{
            type = @"敌对生物";
        }
        self.describe =@[animal.life,animal.atk,animal.walkingSpeed,animal.runSpeed,type,animal.atktype,animal.atkPeriod,animal.wit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.view.backgroundColor = FlatWhite;
    self.collectionView.backgroundColor = FlatWhite;

    [self.collectionView registerClass:[AnimalDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[AnimalCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                   withReuseIdentifier:@"header"];

    [self reloadLayout];
}

- (void)reloadLayout {
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
        layout.parallaxHeaderAlwaysOnTop = NO;
        layout.disableStickyHeaders = YES;
    }
}

- (UIBarButtonItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIBarButtonItem alloc]init];
        UIImage *bgImage = [UIImage imageNamed:@"back"];
        [_leftItem setImage:bgImage];
        @weakify(self);
        _leftItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            self.navigationController.transitioningDelegate = [MyADTransition blackTransitionWithFrame:self.view.frame];
            [self dismissViewControllerAnimated:YES completion:nil];
            return [RACSignal empty];
        }];
    }
    return _leftItem;
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.frame.size.width/2;
    CGFloat height = 30;
    NSArray *loot = [self.animal.loot componentsSeparatedByString:@"|"];
    NSArray *attractFood = [self.animal.attractFood componentsSeparatedByString:@"|"];
    NSUInteger num = loot.count>attractFood.count?loot.count:attractFood.count;
    if (indexPath.row == 8) {
        height += 20 * num ;
    }
    else if(indexPath.row == 9) {
        height += 20 * num;
    }
    else if(indexPath.row == 10) {
        width = self.view.frame.size.width;
        UIFont  *bornRegionFont = [UIFont systemFontOfSize:14];
        CGFloat bornRegionWidth = self.view.frame.size.width - 10;
        CGFloat bornRegionHeight = [self findHeightForText:self.animal.bornRegion havingMaximumWidth:bornRegionWidth andFont:bornRegionFont];
        height += bornRegionHeight + 10;
    }
    else if(indexPath.row == 11) {
        width = self.view.frame.size.width;
        UIFont  *remarkFont = [UIFont systemFontOfSize:14];
        CGFloat remarkWidth = self.view.frame.size.width - 10;
        CGFloat remarkHeight = [self findHeightForText:self.animal.bornRegion havingMaximumWidth:remarkWidth andFont:remarkFont];
        height += remarkHeight + 20;
    }else{
        height += 30;
    }
    return CGSizeMake(width, height);
}

- (CGFloat)findHeightForText:(NSString *)text havingMaximumWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size.height;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AnimalDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.title.text = self.titles[indexPath.row];
    if (indexPath.row<[self.describe count]) {
        cell.describe.text = self.describe[indexPath.row];
    }
    
    if (indexPath.row == 8) {
        cell.describe.text = [self.animal.loot stringByReplacingOccurrencesOfString:@"|" withString:@"\n"];
    }
    else if(indexPath.row == 9) {
        cell.describe.text = [self.animal.attractFood stringByReplacingOccurrencesOfString:@"|" withString:@"\n"];
    }
    
    if (indexPath.row == 10) {
        cell.describe.text = self.animal.bornRegion;
    }
    
    if (indexPath.row == 11) {
        cell.describe.text = self.animal.remark;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]){
        _headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"
                                                                    forIndexPath:indexPath];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",PREFIX,self.animal.urlStr];
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
        if (image) {
            _headerCell.image.image = image;
        }else{
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
                _headerCell.image.image = image;
            }];
        }
        
        _headerCell.chName.text = self.animal.chName;
        _headerCell.enName.text = self.animal.enName;
        if (self.animal.type.intValue == 0) {
            _headerCell.type.text = @"不会攻击";
            _headerCell.type.textColor = FlatGreenDark;
            _headerCell.image.backgroundColor = FlatGreenDark;
        }else if (self.animal.type.intValue == 1){
            _headerCell.type.text = @"挑衅攻击";
            _headerCell.type.textColor = FlatYellowDark;
            _headerCell.image.backgroundColor = FlatYellowDark;
        }else{
            _headerCell.type.text = @"主动攻击";
            _headerCell.type.textColor = FlatRedDark;
            _headerCell.image.backgroundColor = FlatRedDark;
        }
        return _headerCell;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
