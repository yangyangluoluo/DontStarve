//
//  AddPictureModel.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "AddPictureModel.h"

@interface AddPictureModel ()

@property (assign,nonatomic) NSUInteger imageCount;

@end

@implementation AddPictureModel

- (instancetype )init{
    self = [super init];
    if (self) {
        [self bindWithReactive];
        self.data =nil;
        self.data1 = nil;
        self.sucNum =  0;
        self.failNum = 0;
        self.total = 0;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self, data) subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            BOOL state = [[x  objectForKey:@"state"] boolValue];
            if (state == SUC) {
                NSString *imageUrl = [x objectForKey:@"filepath"];
                [self.imageUrls addObject:imageUrl];
                self.sucNum++;
            }else{
                self.failNum++;
            }
            self.total++;
        }
    }];
}

- (void )saveImageData:(NSArray *)images{
    self.imageCount = [images count];
    self.imageUrls = [[NSMutableArray alloc]initWithCapacity:self.imageCount];
    for (UIImage *image in images) {
        NSData *imageData = UIImageJPEGRepresentation(image,1.0f);
        [self savePictureData:imageData];
    }
}

- (void )addPicture:(NSString *)describe{
    NSString *name = [self.theUser getName];
    NSMutableDictionary *information = [[NSMutableDictionary alloc]init];
    [information setObject:name forKey:@"name"];
    [information setObject:describe forKey:@"describe"];
    NSMutableDictionary *urls = [[NSMutableDictionary alloc]init];
    for (NSUInteger i=0; i<self.imageUrls.count; i++) {
        [urls setObject:self.imageUrls[i] forKey:[NSString stringWithFormat:@"%lu",i]];
    }
    [information setObject:urls  forKey:@"imageUrl"];
    NSString *urlStr = [self.webData setUrlString:SAVEPICTURE];
    [self downloadAddress1:urlStr information1:information];
}

@end
