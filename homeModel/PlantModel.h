//
//  PlantModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/10.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "CellProtocol.h"
#import "BaseModel.h"
#import "Plant+CoreDataProperties.h"
@interface PlantModel : BaseModel<CellProtocol>

- (Plant *)getPlant:(NSUInteger)row;




@end
