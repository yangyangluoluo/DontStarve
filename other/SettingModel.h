//
//  SettingModel.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BaseModel.h"

@interface SettingModel : BaseModel

@property (strong,nonatomic) NSNumber *state;
- (BOOL )getLoginState;
- (void )loginOut;

@end