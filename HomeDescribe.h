//
//  HomeDescribe.h
//  DontStarve
//
//  Created by 李建国 on 16/1/22.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDescribe : NSObject

@property (strong,nonatomic) NSString *chName;
@property (strong,nonatomic) NSString *enName;
@property (strong,nonatomic) NSString *icon;

- (instancetype)initWitchName:(NSString *)chName enName:(NSString *)enName icon:(NSString *)icon;
@end
