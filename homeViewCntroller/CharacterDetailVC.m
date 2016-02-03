//
//  CharacterDetailVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "CharacterDetailVC.h"
#import "CharacterDetailView.h"
#import "UIImageView+WebCache.h"
@interface CharacterDetailVC ()

@property (strong,nonatomic) Characters *character;
@property (strong,nonatomic) UIScrollView *scroll;
@property (strong,nonatomic) CharacterDetailView *bgView;

@end

@implementation CharacterDetailVC

- (instancetype)initWithId:(Characters *)character{
    self = [super init];
    if (self) {
        self.character = character;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FlatWhite;
    self.title = @"人物详情";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FlatGreenDark};
    self.scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
       self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.1);
    [self.view addSubview:[self scroll]];
    [self.scroll addSubview:[self bgView]];
    [self GetData];
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
    self.bgView.header.name.text = self.character.name;
    self.bgView.header.nickname.text = self.character.nickname;
    self.bgView.header.life.label.text = self.character.life;
    self.bgView.header.hungry.label.text = self.character.hungry;
    self.bgView.header.sanity.label.text = self.character.intellect;
    self.bgView.header.atk.label.text = self.character.atk;
    self.bgView.header.motto.text = self.character.motto;
    
    self.bgView.unlock.describe.text = self.character.unlock;
    self.bgView.ability.describe.text = self.character.ability;
    self.bgView.introduce.describe.text = self.character.introduction;
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.character.urlstr];
    if (image) {
        self.bgView.header.image.image = image;
    }else{
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.character.urlstr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
            self.bgView.header.image.image = image;
        }];
    }
}

- (void)dealloc{
    NSLog(@"CharacterDetailVC");
}
@end
