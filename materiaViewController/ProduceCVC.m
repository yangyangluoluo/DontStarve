//
//  ProduceCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/24.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "ProduceCVC.h"
#import "ProduceModel.h"
#import "Produce+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
#import "ProduceCell.h"
@interface ProduceCVC ()

@end

@implementation ProduceCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[ProduceModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生产列表";
    self.leftItem = [self leftItem];
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[ProduceCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    ProduceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = FlatGreenDark.CGColor;
    cell.layer.borderWidth = 1.0;
    
    Produce *produce = [self.viewModel getObject:indexPath.row];
    cell.name.text = produce.name;
    cell.one.text = produce.technology;
    cell.two.text = produce.function;
    cell.three.text = produce.code;
    
    NSUInteger index = 0;
    for (MixNeed *mixNeed in produce.relationship) {
        ImageLabel *temp = cell.raws[index];
        temp.label.text = [NSString stringWithFormat:@"%@×%@",mixNeed.name,mixNeed.num];
        [self setImageView:temp.image urlStr:mixNeed.urlStr];
        index++;
    }
    [self setImageView:cell.image urlStr:produce.urlStr];
    
    return cell;
}


@end
