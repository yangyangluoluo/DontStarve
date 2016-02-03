//
//  ConstructionCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/11.
//  Copyright © 2016年 李建国. All rights reserved.


#import "ConstructionCVC.h"
#import "ConstructionCell.h"
#import "ConstructionModel.h"
#import "Construction+CoreDataProperties.h"

@interface ConstructionCVC ()

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
    self.title = @"建筑列表";
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[ConstructionCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    ConstructionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    Construction *construction = [self.viewModel getObject:indexPath.row];
    [self setImageView:cell.image urlStr:construction.urlStr];
    NSString *describe = [construction.describe stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    NSString *produce = [construction.produce stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    cell.enName.text = describe;
    cell.type.text = produce;
    cell.chName.text = construction.name;
    
    return cell;
}

- (void)dealloc{
    NSLog(@"ConstructionCVC");
}

@end
