//
//  RefineCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "RefineCVC.h"
#import "Refine+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
#import "RefineCell.h"
#import "RefineModel.h"
@interface RefineCVC ()

@end

@implementation RefineCVC
static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[RefineModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建筑列表";
    self.leftItem = [self leftItem];
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[RefineCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    RefineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = FlatGreenDark.CGColor;
    cell.layer.borderWidth = 1.0;
    
    Refine *refine = [self.viewModel getObject:indexPath.row];
    cell.name.text = refine.name;
    cell.one.text = refine.technology;
    cell.two.text = refine.stackNum;
    cell.three.text = refine.code;
    
    NSUInteger index = 0;
    for (MixNeed *mixNeed in refine.relationship) {
        ImageLabel *temp = cell.raws[index];
        temp.label.text = [NSString stringWithFormat:@"%@×%@",mixNeed.name,mixNeed.num];
        [self setImageView:temp.image urlStr:mixNeed.urlStr];
        index++;
    }
    for (NSUInteger index1 = 0;index1<cell.raws.count; index1++) {
        ImageLabel *temp = cell.raws[index1];
        if (index1<index) {
            temp.hidden = NO;
        }else{
            temp.hidden = YES;
        }
    }
    [self setImageView:cell.image urlStr:refine.urlStr];
    
    return cell;
}


@end
