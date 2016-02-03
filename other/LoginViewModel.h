//
//  LoginViewModel.h
//  Geological
//
//  Created by 李建国 on 15/12/6.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "BaseModel.h"
#import "ReactiveCocoa.h"
#import <Foundation/Foundation.h>

@interface LoginViewModel : BaseModel

- ( id ) init;
- (void )loginWithName:(NSString *)name password:(NSString *)password;

@end
