//
//  CharactersCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Characters+CoreDataProperties.h"
#import "CharactersCVC.h"
#import "CharactersModel.h"
#import "CharactersCell.h"
#import "CharacterDetailVC.h"

@interface CharactersCVC()

@end

@implementation CharactersCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype )initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[CharactersModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"饥荒人物";
    [self.viewModel downloadData];
    [self bindWithReactive];
    [self.collectionView registerClass:[CharactersCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.frame.size.width-20;
    return CGSizeMake(width, 140);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CharactersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    Characters *character = [self.viewModel getObject:indexPath.row];
    [self setImageView:cell.image urlStr:character.urlstr];
    cell.name.text = character.name;
    cell.nickname.text = character.nickname;
    cell.life.text = character.life;
    cell.hungry.text = character.hungry;
    cell.intellect.text = character.intellect;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Characters *character = [self.viewModel getObject:indexPath.row];
    CharacterDetailVC *detail = [[CharacterDetailVC alloc]initWithId:character];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
