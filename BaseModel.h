//
//  baseModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Manager.h"
#import "WebData.h"
#import <Foundation/Foundation.h>

@interface BaseModel : NSObject<NSFetchedResultsControllerDelegate>

#define PREFIX  @"http://192.168.1.220/"

@property (strong,nonatomic) Manager *manager;
@property (strong,nonatomic) WebData *webData;

- (instancetype)init;

@end
