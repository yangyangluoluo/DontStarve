//
//  CommentPictureVC.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Picture;
#import <UIKit/UIKit.h>

@interface CommentPictureVC : UIViewController
@property (strong,nonatomic) NSNumber *state;
- (instancetype )initWithPicture:(Picture *)picture;

@end
