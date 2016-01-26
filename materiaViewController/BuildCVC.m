//
//  BuildCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BuildCVC.h"
#import "Build+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
#import "BuildModel.h"
#import "BuildCell.h"

@interface BuildCVC ()

@end

@implementation BuildCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[BuildModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建筑列表";
    self.leftItem = [self leftItem];
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[BuildCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width-20, 90);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BuildCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = FlatGreenDark.CGColor;
    cell.layer.borderWidth = 1.0;
    
    Build *build = [self.viewModel getObject:indexPath.row];
    cell.name.text = build.name;
    cell.one.text = build.technology;
    cell.two.text = build.function;
    cell.three.text = build.code;
    
    NSUInteger index = 0;
    for (MixNeed *mixNeed in build.relationship) {
        ImageLabel *temp = cell.raws[index];
        temp.label.text = [NSString stringWithFormat:@"%@×%@",mixNeed.name,mixNeed.num];
        [self setImageView:temp.image urlStr:mixNeed.urlStr];
        index++;
    }
    [self setImageView:cell.image urlStr:build.urlStr];
    
    return cell;
}

@end
