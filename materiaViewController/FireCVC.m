//
//  FireCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/24.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "FireCVC.h"
#import "Fire+CoreDataProperties.h"
#import "FireModel.h"
#import "FireCell.h"
#import "MixNeed+CoreDataProperties.h"
@interface FireCVC ()

@end

@implementation FireCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[FireModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"光源列表";
    self.leftItem = [self leftItem];
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[FireCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    FireCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = FlatGreenDark.CGColor;
    cell.layer.borderWidth = 1.0;
    
    Fire *fire = [self.viewModel getObject:indexPath.row];
    cell.name.text = fire.name;
    cell.one.text = fire.technology;
    cell.two.text = fire.time;
    cell.three.text = fire.maxTime;
    cell.four.text = fire.code;
    
    NSUInteger index = 0;
    for (MixNeed *mixNeed in fire.relationship) {
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
    [self setImageView:cell.image urlStr:fire.urlStr];
    
    return cell;
}

@end
