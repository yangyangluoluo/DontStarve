//
//  RegisterViewModel.h
//  Geological
//
//  Created by 李建国 on 15/12/8.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface RegisterViewModel : BaseModel

@property(strong,nonatomic)NSDictionary *registerState;

- (instancetype)init;
- (void )registerWithName:(NSString *)name password:(NSString *)password email:(NSString *)email;



@end
