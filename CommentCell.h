//
//  CommentCell.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/28.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *portrait;
@property (strong,nonatomic) UILabel  *date;
@property (strong,nonatomic) UILabel  *nickname;
@property (strong,nonatomic) UILabel  *describe;

@end
