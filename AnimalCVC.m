//
//  AnimalCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "AnimalCVC.h"
#import "MyADTransition.h"
#import "CSStickyHeaderFlowLayout.h"
#import "AnimalCell.h"
#import "AnimalModel.h"
#import "AnimalDetailCVC.h"
#define HEIGHT 35
@interface AnimalCVC ()

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;
@property (strong,nonatomic) UISegmentedControl *segment;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UICollectionView *friendly;
@property (strong,nonatomic) UICollectionView *neutrally;
@property (strong,nonatomic) UICollectionView *hostility;
@property (strong,nonatomic) AnimalModel *viewModel;


@end

@implementation AnimalCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[AnimalModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.view.backgroundColor = FlatWhite;
    self.collectionView.backgroundColor = FlatWhite;
    self.collectionView = nil;
    self.title = @"动物列表";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FlatGreenDark};
    [self.view addSubview:[self segment]];
    [self.view addSubview:[self scrollView]];
    [self.scrollView addSubview:[self friendly]];
    [self.scrollView addSubview:[self neutrally]];
    [self.scrollView addSubview:[self hostility]];
    [self.friendly  registerClass:[AnimalCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.neutrally registerClass:[AnimalCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.hostility registerClass:[AnimalCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.viewModel downloadData];
    [self bindWithReactive];
}

- (void)bindWithReactive{
    [RACObserve(self.viewModel, allAnimal)  subscribeNext:^(NSArray *x) {
        if (x.count>0) {
            [self.viewModel saveDataToCoreData];
        }
    }];
    
    [RACObserve(self.viewModel, reload) subscribeNext:^(NSNumber *x) {
        if (x.intValue==1) {
            [self.friendly reloadData];
            [self.neutrally reloadData];
            [self.hostility reloadData];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.segment.selectedSegmentIndex == 0) {
        return [self.viewModel getFrinedlyCount];
    }else if (self.segment.selectedSegmentIndex == 1){
        return [self.viewModel getNeutrallyCount];
    }else{
        return [self.viewModel getHostilityCount];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AnimalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.chName.text = [self.viewModel getChName:self.segment.selectedSegmentIndex row:indexPath.row];
    cell.enName.text = [self.viewModel getEnName:self.segment.selectedSegmentIndex row:indexPath.row];
    
    NSString *urlStr = [self.viewModel getImageUrlStr:self.segment.selectedSegmentIndex row:indexPath.row];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (image) {
        cell.image.image = image;
    }else{
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
            cell.image.image = image;
        }];
    }
    
    if (self.segment.selectedSegmentIndex == 0) {
        cell.type.text = @"不会攻击";
        cell.type.textColor = FlatGreenDark;
//        cell.image.backgroundColor = FlatGreenDark;
    }else if (self.segment.selectedSegmentIndex == 1){
        cell.type.text = @"挑衅攻击";
        cell.type.textColor = FlatYellowDark;
//        cell.image.backgroundColor = FlatYellowDark;
    }else{
        cell.type.text = @"主动攻击";
        cell.type.textColor = FlatRedDark;
//        cell.image.backgroundColor = FlatRedDark;
    }
    return cell;
}

#pragma mark init

- (UIBarButtonItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIBarButtonItem alloc]init];
        UIImage *bgImage = [UIImage imageNamed:@"back"];
        [_leftItem setImage:bgImage];
        @weakify(self);
        _leftItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            self.navigationController.transitioningDelegate = [MyADTransition blackTransitionWithFrame:self.view.frame];
            [self dismissViewControllerAnimated:YES completion:nil];
            return [RACSignal empty];
        }];
    }
    return _leftItem;
}

- (UISegmentedControl *)segment{
    if (!_segment) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(0, height, self.view.frame.size.width, HEIGHT);
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"被动生物", @"中立生物" ,@"敌对生物"]];
        _segment.frame = frame;
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

- (void)segmentSelected:(UISegmentedControl *)send{
    if (send.selectedSegmentIndex == 0) {
        CGRect frame = self.scrollView.frame;
        frame.origin.y = 0;
        frame.origin.x = 0;
        [self.scrollView scrollRectToVisible:frame animated:YES];
        [self.friendly reloadData];
    }else if (send.selectedSegmentIndex == 1){
        CGRect frame = self.scrollView.frame;
        frame.origin.y = 0;
        frame.origin.x = frame.size.width;
        [self.scrollView scrollRectToVisible:frame animated:YES];
        [self.neutrally reloadData];
    }else{
        CGRect frame = self.scrollView.frame;
        frame.origin.y = 0;
        frame.origin.x = frame.size.width*2;
        [self.scrollView scrollRectToVisible:frame animated:YES];
        [self.hostility reloadData];
    }
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(0,HEIGHT+height, self.view.frame.size.width,self.view.frame.size.height-HEIGHT-height);
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3.0f,self.view.frame.size.height-HEIGHT-height);
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.backgroundColor = FlatWhite;
        _scrollView.tag = 1;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

- (UICollectionView *)friendly{
    if (!_friendly) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-HEIGHT-height);
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        _friendly = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _friendly.backgroundColor = FlatWhite;
        _friendly.delegate = self;
        _friendly.dataSource = self;
        _friendly.userInteractionEnabled = YES;
    }
    return _friendly;
}

- (UICollectionView *)neutrally{
    if (!_neutrally) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(self.view.frame.size.width,0,self.view.frame.size.width,self.view.frame.size.height-HEIGHT-height);
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        _neutrally = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _neutrally.backgroundColor = FlatWhite;
        _neutrally.delegate = self;
        _neutrally.dataSource = self;
        _neutrally.userInteractionEnabled = YES;
    }
    return _neutrally;
}

- (UICollectionView *)hostility{
    if (!_hostility) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(self.view.frame.size.width*2,0,self.view.frame.size.width,self.view.frame.size.height-HEIGHT-height);
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        _hostility = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _hostility.backgroundColor = FlatWhite;
        _hostility.delegate = self;
        _hostility.dataSource = self;
        _hostility.userInteractionEnabled = YES;
    }
    return _hostility;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Animal *animal = [self.viewModel getAnimal:self.segment.selectedSegmentIndex row:indexPath.row];
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    AnimalDetailCVC *detail = [[AnimalDetailCVC alloc]initWithCollectionViewLayout:layout animal:animal];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:detail];
    navi.transitioningDelegate = [MyADTransition nextTransitionWithFrame:self.view.frame];
    [self presentViewController:navi animated:YES completion:nil];
    

}
@end
