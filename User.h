//
//  User.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (assign,nonatomic) NSNumber *state;

- (instancetype)init;
+ (User *)sharedManager;

- (void )saveName:(NSString *)name;
- (void )saveRank:(NSNumber *)rank;

- (NSString *)getName;
- (NSNumber *)getRank;
- (void )clearUserInformation;
- (void )changState;

@end
