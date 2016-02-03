//
//  CommentPictureModel.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Picture+CoreDataProperties.h"
#import "CommentPictureModel.h"

@implementation CommentPictureModel

- (instancetype)initWithPicture:(Picture *)picture{
    self = [super init];
    if (self) {
        self.picture = picture;
        self.data = nil;
    }
    return self;
}

- (void) savePictureComment:(NSString *)describe;{
    NSString *name = [self.theUser getName];
    NSMutableDictionary *comment = [[NSMutableDictionary alloc]init];
    [comment setObject:name forKey:@"name"];
    [comment setObject:describe forKey:@"describe"];
    [comment setObject:self.picture.picture_id forKey:@"theId"];
    [comment setObject:@"picture" forKey:@"tableName"];
    NSString *urlStr = [self.webData setUrlString:COMMENTPIC];
    [self downloadAddress:urlStr information:comment];
}

@end
