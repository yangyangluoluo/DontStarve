//
//  PictureCVC.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "PictureCVC.h"
#import "AddPictureVC.h"
#import "Picture+CoreDataProperties.h"
#import "PictureUrl+CoreDataProperties.h"
#import "PictureCell.h"
#import "PictureModel.h"
#import "LoginViewVC.h"
#import "PictureCommentCVC.h"
@interface PictureCVC ()

@property (strong,nonatomic) NSIndexPath *reloadCell;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UITapGestureRecognizer *showScrollViewGusture;
@property (strong,nonatomic) UITapGestureRecognizer *hiddenScrollViewGusture;
@property (strong,nonatomic) CAKeyframeAnimation *showAnimation;
@property (strong,nonatomic) CAKeyframeAnimation *hiddenAnimation;

@end

@implementation PictureCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[PictureModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"饥荒图片展示";
    self.navigationItem.rightBarButtonItem = [self getRightItem];
    [self initRefresh];
    [self bindWithReactive];
    if ([self.viewModel getCount]==0) {
        [self.collectionView.footer beginRefreshing];
    }
    [self.view addSubview:[self scrollView]];
    [self.scrollView addGestureRecognizer:[self hiddenScrollViewGusture]];
    self.scrollView.userInteractionEnabled  = YES;
    [self.view bringSubviewToFront:self.collectionView];
    [self.collectionView registerClass:[PictureCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _scrollView.backgroundColor = [UIColor blackColor];
    }
    return _scrollView;
}

- (void)bindWithReactive{
    @weakify(self);
    [RACObserve(self.viewModel, data) subscribeNext:^(id x) {
        @strongify(self)
        if (x) {
            if ([x isKindOfClass:[NSArray class]]) {
                NSArray *temp  = x;
                if (temp.count>0) {
                    [self.viewModel saveDataToCoreData];
                    [self.collectionView.header endRefreshing];
                    MJRefreshNormalHeader *header =(MJRefreshNormalHeader*)self.collectionView.header;
                    [header setTitle:@"上拉刷新...."forState:MJRefreshStateIdle];
        
                    [self.collectionView.footer endRefreshing];
                    MJRefreshAutoNormalFooter *footer =(MJRefreshAutoNormalFooter*)self.collectionView.footer;
                    [footer setTitle:@"下拉加载数据...."forState:MJRefreshStateIdle];
                }else{
                    [self.collectionView.header endRefreshing];
                    MJRefreshNormalHeader *header =(MJRefreshNormalHeader*)self.collectionView.header;
                    [header setTitle:@"没有数据<.>"forState:MJRefreshStateIdle];
        
                    [self.collectionView.footer endRefreshing];
                    MJRefreshAutoNormalFooter *footer =(MJRefreshAutoNormalFooter*)self.collectionView.footer;
                    [footer setTitle:@"没有数据<.>"forState:MJRefreshStateIdle];
                }
            }else{
                [self.collectionView.header endRefreshing];
                MJRefreshNormalHeader *header =(MJRefreshNormalHeader*)self.collectionView.header;
                [header setTitle:@"错误<.>"forState:MJRefreshStateIdle];
                
                [self.collectionView.footer endRefreshing];
                MJRefreshAutoNormalFooter *footer =(MJRefreshAutoNormalFooter*)self.collectionView.footer;
                [footer setTitle:@"错误<.>"forState:MJRefreshStateIdle];
            }
        }
    }];
    
    [RACObserve(self.viewModel.manager, reload) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            [self.collectionView reloadData];
        }
    }];
    
    [RACObserve(self.viewModel.manager, update) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            NSArray *reloadCellPath = @[self.reloadCell];
            [self.collectionView reloadItemsAtIndexPaths:reloadCellPath];
        }
    }];
}


- (void)initRefresh{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (self.collectionView.header.isRefreshing) {
                [self.viewModel downloadFordown];
            };
        });
        
    }];
    self.collectionView.header.hidden = YES;
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (self.collectionView.footer.isRefreshing) {
                [self.viewModel downloadForUp];
            };
        });
    }];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [UIFont systemFontOfSize:18];
    CGFloat describeWidth = self.view.frame.size.width - 40;
    Picture *picture = [self.viewModel getObject:indexPath.row];
    CGFloat describeHeight = [self findHeightForText:picture.theDescribe havingMaximumWidth:describeWidth andFont:font];
    CGFloat width = (self.view.frame.size.width - 40)/3;
    if (picture.pictureNum.intValue>3) {
        width =width*2.0f;
    }
    return CGSizeMake(self.view.frame.size.width,100+width+describeHeight);
}

- (CGFloat)findHeightForText:(NSString *)text havingMaximumWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size.height;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.viewModel getCount]!=0) {
        self.collectionView.header.hidden = NO;
    }
    return [self.viewModel getCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Picture *picture = [self.viewModel getObject:indexPath.row];
    cell.nickname.text = picture.user_name;
    cell.date.text = picture.dateStr;
    cell.describe.text = picture.theDescribe;
    [self setImageView:cell.portrait urlStr:picture.urlStr];
    
    CGFloat width = (self.view.frame.size.width - 40)/3;
    NSInteger imageNum = picture.relationship.count;
    for (NSUInteger i=0 ; i<cell.images.count ; i++) {
        UIImageView *forhidden = cell.images[i];
        if (i<imageNum) {
            forhidden.hidden = NO;
            CGRect frame = forhidden.frame;
            frame.size = CGSizeMake(width, width);
            forhidden.frame = frame;
            forhidden.tag = indexPath.row*10 + i;
            [forhidden addGestureRecognizer:[self showScrollViewGusture]];
        }else{
            forhidden.hidden = YES;
            CGRect frame = forhidden.frame;
            frame.size = CGSizeZero;
            forhidden.frame = frame;
        }
    }
    
    for (NSUInteger i=0; i<picture.relationship.count; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PictureUrl *pictureUrl = picture.relationship[i];
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:pictureUrl.urlStr];
            UIImageView *imageView = cell.images[i];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (image) {
                    imageView.image = image;
                }else{
                    [imageView setImage:[UIImage imageNamed:@"placeholder"]];
                    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:pictureUrl.urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
                        imageView.image = image;
                    }];
                }
            });
        });
    }
    [self setImageView:cell.portrait urlStr:picture.urlStr];
    cell.commnetNum.text = [NSString stringWithFormat:@"评论数目为: %@",picture.commentNum];
    cell.comment.tag = indexPath.row;
    [cell.comment addTarget:self action:@selector(gotoPictureComment:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)gotoPictureComment:(UIButton *)sender{
    Picture *picture = [self.viewModel getObject:sender.tag];
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    PictureCommentCVC *pictureComment = [[PictureCommentCVC alloc]initWithCollectionViewLayout:layout picture:picture];
    [self.navigationController pushViewController:pictureComment animated:YES];
}

- (UIBarButtonItem *)getRightItem{
    self.rightItem = [[UIBarButtonItem alloc]init];
    UIImage *image = [UIImage imageNamed:@"add"];
    [self.rightItem setImage:image];
    @weakify(self);
    self.rightItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        NSString *name = [self.viewModel.theUser getName];
        if (name) {
            AddPictureVC *add = [[AddPictureVC alloc]init];
            [self.navigationController pushViewController:add animated:YES];
        }else{
            [self sgtUserLogin];
        }
        return [RACSignal empty];
    }];
    return self.rightItem;
}

- (UITapGestureRecognizer *)showScrollViewGusture{
    _showScrollViewGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage:)];
    [_showScrollViewGusture setNumberOfTapsRequired:1];
    return _showScrollViewGusture;
}

- (void)showImage:(UITapGestureRecognizer *)sender{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    NSUInteger tag = sender.view.tag;
    [self scrollShowImage:tag];
    [self.scrollView.layer addAnimation:[self showAnimation] forKey:nil];
}

- (void )scrollShowImage:(NSUInteger)index{
    NSUInteger row = index/10;
    NSUInteger imageNum = index%10;
    Picture *picture = [self.viewModel getObject:row];
    for (UIView *v in [_scrollView subviews]) {
            [v removeFromSuperview];
    }
    CGRect frame = self.scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    
    for (PictureUrl *pictureUrl in picture.relationship) {
        NSString *url = pictureUrl.urlStr;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self setImageView:imageView urlStr:url];
        [self.scrollView addSubview:imageView];
        frame.origin.x = frame.origin.x+frame.size.width;
    }
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(frame.origin.x, frame.size.height)];
    self.scrollView.contentOffset = CGPointMake(imageNum*frame.size.width,0);
}

- (UITapGestureRecognizer *)hiddenScrollViewGusture{
    _hiddenScrollViewGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenImage:)];
    [_hiddenScrollViewGusture setNumberOfTapsRequired:2];
    return _hiddenScrollViewGusture;
}

- (void)hiddenImage:(UITapGestureRecognizer *)sender{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
    UIImageView *temp =(UIImageView *)sender.view;
    [temp.layer addAnimation:[self hiddenAnimation] forKey:nil];
}

#pragma mark  动画相关
- (CAKeyframeAnimation *)showAnimation{
    if (!_showAnimation) {
        _showAnimation = [CAKeyframeAnimation animation];
        _showAnimation.keyPath = @"position.x";
        _showAnimation.duration = .4;
        CGFloat end = self.view.frame.size.width/2;
        _showAnimation.keyTimes =  @[@0,@0.8,@0.9,@1.0];
        _showAnimation.values = @[@(-100),@(end),@(end-5),@(end)];
        _showAnimation.removedOnCompletion = NO;
        _showAnimation.delegate = self;
        _showAnimation.fillMode = kCAFillModeForwards;
        [_showAnimation setValue:@"showAnimation" forKey:@"tag"];
    }
    return _showAnimation;
}

- (CAKeyframeAnimation *)hiddenAnimation{
    if (!_hiddenAnimation) {
        _hiddenAnimation = [CAKeyframeAnimation animation];
        _hiddenAnimation.keyPath = @"position.x";
        _hiddenAnimation.duration = .2;
        CGFloat start = self.view.frame.size.width/2;
        _hiddenAnimation.keyTimes =  @[@0,@1];
        _hiddenAnimation.values = @[@(start),@(start*3)];
        _hiddenAnimation.removedOnCompletion = NO;
        _hiddenAnimation.delegate = self;
        _hiddenAnimation.fillMode = kCAFillModeForwards;
        [_hiddenAnimation setValue:@"hiddenAnimation" forKey:@"tag"];
    }
    return _hiddenAnimation;
}

- (void)animationDidStart:(CAKeyframeAnimation *)anim{
    if ([[anim valueForKey:@"tag"]  isEqual: @"showAnimation"]){
        [self.view bringSubviewToFront:self.scrollView];
    }
}

- (void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag{
    if ([[anim valueForKey:@"tag"]  isEqual: @"hiddenAnimation"]){
        [self.view bringSubviewToFront:self.collectionView];
        [self.scrollView.layer removeAllAnimations];
    }
}

- (void )sgtUserLogin{
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:@"你没有登录<^.^>" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        LoginViewVC *login = [[LoginViewVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [alertCtr addAction:firstAction];
    [alertCtr addAction:secondAction];
    [self presentViewController:alertCtr animated:YES completion:^{
    }];
}

@end
