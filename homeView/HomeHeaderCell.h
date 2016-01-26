//
//  HomeHeaderCell.h
//  Geological1
//
//  Created by 李建国 on 16/1/3.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderCell : UICollectionViewCell

@property (strong,nonatomic) NSMutableArray *imageViewArray;
@property (strong,nonatomic) UIScrollView *imageScroll;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (assign,nonatomic) NSUInteger num;

- (void)setImageNum:(NSUInteger )num;

@end
