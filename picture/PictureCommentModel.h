//
//  PictureCommentModel.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Picture+CoreDataProperties.h"
#import "Comment+CoreDataProperties.h"
#import "BaseModel.h"

@interface PictureCommentModel : BaseModel

@property (strong,nonatomic) Picture *picture;
- (instancetype)initWithPicture:(Picture *)picture;
@end
