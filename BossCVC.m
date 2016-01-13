//
//  BossCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/12.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "CSStickyHeaderFlowLayout.h"
#import "UIImageView+WebCache.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "BossCVC.h"
#import "MyADTransition.h"
#import "BossModel.h"
#import "BossCell.h"
#import "Boss+CoreDataProperties.h"
#import "BossDetailCVC.h"
@interface BossCVC ()

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) BossModel *viewModel;

@end

@implementation BossCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[BossModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.view.backgroundColor = FlatWhite;
    self.collectionView.backgroundColor = FlatWhite;
    self.title = @"BOSS列表";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FlatGreenDark};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.viewModel downloadData];
    });
    [self bindWithReactive];
    [self.collectionView registerClass:[BossCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)bindWithReactive{
    [RACObserve(self.viewModel, allData)  subscribeNext:^(NSArray *x) {
        if (x.count>0) {
            [self.viewModel saveDataToCoreData];
        }
    }];
    
    [RACObserve(self.viewModel, reload) subscribeNext:^(NSNumber *x) {
        if (x.intValue==1) {
            [self.collectionView reloadData];
        }
    }];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.viewModel getCount]==0) {
        return 0;
    }else{
        return [self.viewModel getCount];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/2, self.view.frame.size.width/2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BossCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    Boss *boss = [self.viewModel getBoss:indexPath.row];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:boss.urlStr];
    if (image) {
        cell.image.image = image;
    }else{
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:boss.urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
            cell.image.image = image;
        }];
    }
    cell.name.text = boss.chName;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Boss *theBoss = [self.viewModel getBoss:indexPath.row];
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    BossDetailCVC *bossDetail = [[BossDetailCVC alloc]initWithCollectionViewLayout:layout boss:theBoss];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:bossDetail];
    navi.transitioningDelegate = [MyADTransition nextTransitionWithFrame:self.view.frame];
    [self presentViewController:navi animated:YES completion:nil];
    
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
