//
//  ConstructionModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/11.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Construction+CoreDataProperties.h"
#import "BaseModel.h"
#import "CellProtocol.h"
@interface ConstructionModel : BaseModel<CellProtocol>

- (Construction *)getConstruction:(NSUInteger )idnex;

@end
