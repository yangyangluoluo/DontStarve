//
//  ConstructionCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/11.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "MyADTransition.h"
#import "ConstructionCVC.h"
#import "ConstructionCell.h"
#import "ConstructionModel.h"
#import "Construction+CoreDataProperties.h"

@interface ConstructionCVC ()

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) ConstructionModel *viewModel;

@end

@implementation ConstructionCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[ConstructionModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.view.backgroundColor = FlatWhite;
    self.collectionView.backgroundColor = FlatWhite;
    self.title = @"建筑列表";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FlatGreenDark};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.viewModel downloadData];
    });
    [self bindWithReactive];
    [self.collectionView registerClass:[ConstructionCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width, 120);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ConstructionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    Construction *construction = [self.viewModel getConstruction:indexPath.row];
    NSString *urlStr =construction.urlStr;
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (image) {
        cell.image.image = image;
    }else{
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
            cell.image.image = image;
        }];
    }
    NSString *describe = [construction.describe stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    NSString *produce = [construction.produce stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    cell.enName.text = describe;
    cell.type.text = produce;
    cell.chName.text = construction.name;
    
    return cell;
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
