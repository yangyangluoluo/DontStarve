//
//  LoginViewModel.m
//  Geological
//
//  Created by 李建国 on 15/12/6.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel()
@end

@implementation LoginViewModel
- (id)init{
    self = [super init];
    if (self) {
        [self bindWithReactive];
        self.loginSate = nil;
    }
    return self;
}

- (void) bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, loginState) subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            self.loginSate = x;
        }
    }];
}

- (void) loginWithName:(NSString *)name password:(NSString *)password{
    NSMutableDictionary *userInformation = [[NSMutableDictionary alloc]init];
    [userInformation setObject:name forKey:@"name"];
    [userInformation setObject:password forKey:@"password"];
    [self.webData userLogin:userInformation];
  
}

- (void)savenickname:(NSString *)nickname password:(NSString *)password{

}

- (void)userLogin{
 
}

@end
