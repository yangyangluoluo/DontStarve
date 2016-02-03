//
//  SettingModel.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "User.h"
#import "SettingModel.h"

@implementation SettingModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.data =nil;
        self.data1 = nil;
    }
    return self;
}

- (void )updatePortaitUrlStr{
    NSString *name = [self.theUser getName];
    NSString *filePath = [self.data objectForKey:@"filepath"];
    NSString *urlStr = [self.webData setUrlString:PORTAITSTATE address1:name address2:filePath];
    [self downloadAddress1:urlStr];
}

- (void )savePortaitUrl{
    NSString *url = [NSString stringWithFormat:@"%@%@",PREFIX,[self.data objectForKey:@"filepath"]];
    [self.theUser savePortait:url];
    [self.theUser changPortaitState];
}

- (void )loginOut{
    [self.theUser clearUserInformation];
    [self.theUser changState];
}

- (void )savePortait:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    [self savePictureData:data];
}

@end
