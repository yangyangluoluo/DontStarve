//
//  HomeCVC.h
//  Geological1
//
//  Created by 李建国 on 15/12/28.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCVC : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;

@end
