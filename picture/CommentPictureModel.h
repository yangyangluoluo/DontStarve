//
//  CommentPictureModel.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Picture;
#import "BaseModel.h"

@interface CommentPictureModel : BaseModel

@property (strong,nonatomic) Picture *picture;

- (instancetype)initWithPicture:(Picture *)picture;
- (void) savePictureComment:(NSString *)describe;


@end
