//
//  BossDetailModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/14.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BaseModel.h"

@interface BossDetailModel : BaseModel

- (instancetype)initWitdBossId:(NSNumber *)bossId;

- (NSUInteger )getType0Count;
- (NSUInteger )getType1Count;

@end
