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
        self.data = nil;
    }
    return self;
}

- (void) loginWithName:(NSString *)name password:(NSString *)password{
    NSMutableDictionary *userInformation = [[NSMutableDictionary alloc]init];
    [userInformation setObject:name forKey:@"name"];
    [userInformation setObject:password forKey:@"password"];
    NSString *urlStr = [self.webData setUrlString:LOGIN];
    [self downloadAddress:urlStr information:userInformation];
}

@end
