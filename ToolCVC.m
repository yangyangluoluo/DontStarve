//
//  ToolCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "ToolCVC.h"
#import "ToolModel.h"
#import "ToolCell.h"
#import "Tools+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
@interface ToolCVC ()

@end

@implementation ToolCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[ToolModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工具列表";
    self.leftItem = [self leftItem];
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[ToolCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    ToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = FlatGreenDark.CGColor;
    cell.layer.borderWidth = 1.0;
    
    Tools *tool = [self.viewModel getObject:indexPath.row];
    cell.name.text = tool.name;
    cell.one.text = [NSString stringWithFormat:@"%@",tool.atk];
    cell.two.text = tool.technology;
    if (tool.during.intValue == 0) {
        cell.three.text = @"无耐久";
    }else{
        cell.three.text = [NSString stringWithFormat:@"%@",tool.during];
    }
    cell.four.text = tool.mixCode;
    
    NSUInteger index = 0;
    for (MixNeed *mixNeed in tool.relationship) {
        ImageLabel *temp = cell.raws[index];
        temp.label.text = [NSString stringWithFormat:@"需要%@×%@ 个",mixNeed.name,mixNeed.num];
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
    [self setImageView:cell.image urlStr:tool.urlStr];
    
    return cell;
}



@end
