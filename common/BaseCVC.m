//
//  BaseCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/17.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BaseCVC.h"

@interface BaseCVC ()
@end

@implementation BaseCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FlatWhite;
    self.collectionView.backgroundColor = FlatWhite;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:FlatGreenDark};
}

- (UIBarButtonItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIBarButtonItem alloc]init];
        UIImage *bgImage = [UIImage imageNamed:@"back"];
        [_leftItem setImage:bgImage];
        @weakify(self);
        _leftItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            NSUInteger count = self.navigationController.viewControllers.count-2;
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count]animated:YES];
            return [RACSignal empty];
        }];
    }
    return _leftItem;
}

- (void)bindWithReactive{
    @weakify(self);
    [RACObserve(self.viewModel, data)  subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            if ([x isKindOfClass:[NSArray class]]) {
                [self.viewModel saveDataToCoreData];
            }else{
                
            }
        }
    }];
    
    [RACObserve(self.viewModel.manager, reload) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.intValue==1) {
            [self.collectionView reloadData];
        }
    }];
}

- (void )setImageView:(UIImageView *)view urlStr:(NSString *)urlStr{
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (image) {
        view.image = image;
    }else{
        view.image = [UIImage imageNamed:@"placeholder.jpg"];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
            view.image = image;
        }];
    }
}

@end
