//
//  CharacterDetailVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "CharacterDetailVC.h"
#import "CharacterDetailModel.h"
#import "MyADTransition.h"
#import "CharacterDetailView.h"
#import "UIImageView+WebCache.h"

@interface CharacterDetailVC ()

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;
@property (strong,nonatomic) CharacterDetailModel *viewModel;
@property (strong,nonatomic) UIScrollView *scroll;
@property (strong,nonatomic) CharacterDetailView *bgView;

@end

@implementation CharacterDetailVC

- (instancetype)initWithId:(NSNumber *)characterId{
    self = [super init];
    if (self) {
        self.viewModel = [[CharacterDetailModel alloc]initWithId:characterId];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FlatWhite;
    self.title = @"人物详情";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FlatGreenDark};
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
       self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.1);
    [self.view addSubview:[self scroll]];
    [self.scroll addSubview:[self bgView]];
    [self GetData];
}

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

- (CharacterDetailView *)bgView{
    if (!_bgView) {
        CGRect frame = self.view.frame;
        frame.size.width -=40;
        frame.origin.x = 20;
        frame.size.height = 140;
        _bgView = [[CharacterDetailView alloc]initWithFrame:frame];
        _bgView.backgroundColor = FlatWhiteDark;
    }
    return _bgView;
}

- (void )GetData{
    self.bgView.header.name.text = [self.viewModel getName:0];
    self.bgView.header.nickname.text = [self.viewModel getNickname:0];
    self.bgView.header.life.label.text = [self.viewModel getLife:0];
    self.bgView.header.hungry.label.text = [self.viewModel getHungry:0];
    self.bgView.header.sanity.label.text = [self.viewModel getSanity:0];
    self.bgView.header.atk.label.text = [self.viewModel getAtk:0];
    self.bgView.header.motto.text = [self.viewModel getMotto:0];
    
    self.bgView.unlock.describe.text = [self.viewModel getUnlock:0];
    self.bgView.ability.describe.text = [self.viewModel getAbility:0];
    self.bgView.introduce.describe.text = [self.viewModel getIntroduce:0];
    
    NSString *urlStr = [self.viewModel getUrlSt:0];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (image) {
        self.bgView.header.image.image = image;
    }else{
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
            self.bgView.header.image.image = image;
        }];
    }
}

- (void)dealloc{
    NSLog(@"CharacterDetailVC");
}











@end
