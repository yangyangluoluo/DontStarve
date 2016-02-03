//
//  AddPictureModel.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "BaseModel.h"
@interface AddPictureModel : BaseModel

@property (strong,nonatomic) NSMutableArray *imageUrls;
@property (assign,nonatomic) NSUInteger sucNum;
@property (assign,nonatomic) NSUInteger failNum;
@property (assign,nonatomic) NSUInteger total;

- (void )saveImageData:(NSArray *)images;

- (void )addPicture:(NSString *)describe;

@end
