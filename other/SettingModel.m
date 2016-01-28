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
        [self bindWithReactive];
        self.state =nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.theUser, state) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            self.state = x;
        }
    }];
}

- (BOOL )getLoginState{
    NSString *name = [self.theUser getName];
    if (name==nil) {
        return NO;
    }else{
        return YES;
    }
}

- (NSString *)getName{
    return [self.theUser getName];
}

- (void )loginOut{
    [self.theUser clearUserInformation];
    [self.theUser changState];
}

@end
