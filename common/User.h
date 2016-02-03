//
//  User.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong,nonatomic) NSNumber *state;
@property (strong,nonatomic) NSNumber *portaitState;

- (instancetype)init;
+ (User *)sharedManager;

- (void )saveName:(NSString *)name;
- (void )saveRank:(NSNumber *)rank;
- (void )savePortait:(NSString *)portait;

- (NSString *)getName;
- (NSNumber *)getRank;
- (NSString *)getPortait;
- (void )clearUserInformation;
- (void )changState;
- (void )changPortaitState;

@end
