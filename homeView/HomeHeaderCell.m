//
//  HomeHeaderCell.m
//  Geological1
//
//  Created by 李建国 on 16/1/3.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "HomeHeaderCell.h"

@implementation HomeHeaderCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void )setImageNum:(NSUInteger )imageNum{
    self.num = imageNum;
    [self addViews];
    [self defineLayout];
}

- (void)addViews{
    [self addSubview:[self imageScroll]];
    [self addSubview:[self pageControl]];
    CGRect frame = self.frame;
    for (NSUInteger i= 0 ;i<self.num ;i++) {
        frame.origin.x = i * self.frame.size.width;
        UIImageView *image = [[UIImageView alloc]initWithFrame:frame];
        NSString *name = [NSString  stringWithFormat:@"%lu.jpg",(unsigned long)i+1];
        image.image = [UIImage imageNamed:name];
        [self.imageViewArray addObject:image];
        [self.imageScroll addSubview:image];
    }
}

- (void)defineLayout{
    [self.imageScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.width*0.5;
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(height);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self);
    }];
}


- (UIScrollView *)imageScroll{
    if (!_imageScroll) {
        _imageScroll = [[UIScrollView alloc]init];
        _imageScroll.contentSize = CGSizeMake(self.frame.size.width*self.num, self.frame.size.height);
        _imageScroll.pagingEnabled = YES;
        _imageScroll.showsVerticalScrollIndicator = NO;
        _imageScroll.showsHorizontalScrollIndicator = NO;
    }
    return _imageScroll;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = self.num;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = FlatWhiteDark;
        _pageControl.currentPageIndicatorTintColor = FlatRedDark;
        _imageScroll.tag = 1;
    }
    return _pageControl;
}



@end
