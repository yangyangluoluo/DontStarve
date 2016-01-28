//
//  User.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "User.h"

@interface User ()

@property (strong,nonatomic) NSUserDefaults *accountDefaults;

@end

@implementation User

+ (User *)sharedManager{
    static User *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc]init];
    });
    return user;
}

- (instancetype )init{
    self = [super init];
    if (self) {
        _accountDefaults = [NSUserDefaults standardUserDefaults];
        self.state = nil;
    }
    return self;
}

- (void )saveName:(NSString *)name{
    [self.accountDefaults setObject:name forKey:@"name"];
}

- (void )saveRank:(NSNumber *)rank{
    [self.accountDefaults setObject:rank forKey:@"rank"];
}

- (NSString *)getName{
    return [self.accountDefaults objectForKey:@"name"];
}

- (NSNumber *)getRank{
    return [self.accountDefaults objectForKey:@"rank"];
}

- (void )changState{
    self.state = @1;
}

- (void )clearUserInformation{
    [self.accountDefaults setObject:nil forKey:@"name"];
    [self.accountDefaults setObject:nil forKey:@"rank"];
}

@end
