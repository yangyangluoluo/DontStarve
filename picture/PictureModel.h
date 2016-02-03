//
//  PictureModel.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Picture+CoreDataProperties.h"
#import "BaseModel.h"

@interface PictureModel : BaseModel

- (void )downloadForUp;
- (void )downloadFordown;
- (void )getReplyNum:(NSUInteger )row;


@end
