//
//  RegisterViewModel.m
//  Geological
//
//  Created by 李建国 on 15/12/8.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "WebData.h"

@interface RegisterViewModel()
@end

@implementation RegisterViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self bindWithReactive];
        self.registerState = nil;
    }
    return self;
}

- (void) bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, registerState) subscribeNext:^(NSDictionary *data) {
        @strongify(self);
        if (data) {
            self.registerState = data;
        }
    }];
}

- (void)registerWithName:(NSString *)name password:(NSString *)password email:(NSString *)email{
    NSMutableDictionary *userInformation = [[NSMutableDictionary alloc]init];
    [userInformation setObject:name forKey:@"name"];
    [userInformation setObject:password forKey:@"password"];
    [userInformation setObject:email forKey:@"email"];
    [self.webData userRegister:userInformation];
}



@end
