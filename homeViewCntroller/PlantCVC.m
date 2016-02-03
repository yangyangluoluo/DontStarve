//
//  PlantCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/10.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "PlantCVC.h"
#import "PlantModel.h"
#import "Plant+CoreDataProperties.h"
#import "PlantCell.h"
@interface PlantCVC ()

@end

@implementation PlantCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[PlantModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"植物列表";
    [self.viewModel downloadData];
    [self bindWithReactive];
    [self.collectionView registerClass:[PlantCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)bindWithReactive{
    @weakify(self)
    [RACObserve(self.viewModel, data)  subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x.count>0) {
            NSLog(@"aaaa");
            [self.viewModel saveDataToCoreData];
        }
    }];
    
    [RACObserve(self.viewModel.manager, reload) subscribeNext:^(NSNumber *x) {
        @strongify(self);
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
    return CGSizeMake(self.view.frame.size.width-20, 120);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlantCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    Plant *plant = [self.viewModel getObject:indexPath.row];
    [self setImageView:cell.image urlStr:plant.urlStr];
    NSString *describe = [plant.describe stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    NSString *produce = [plant.produce stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    cell.enName.text = describe;
    cell.type.text = produce;
    cell.chName.text = plant.name;
    
    return cell;
}

- (void )dealloc{
    NSLog(@"PlantCVC");
}

@end
