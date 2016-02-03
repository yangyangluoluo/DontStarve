//
//  BaseMateriaModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "Manager.h"
#import "WebData.h"
#import <Foundation/Foundation.h>
#import "CellProtocol.h"
#import "DefineState.h"
@interface BaseMateriaModel : NSObject<NSFetchedResultsControllerDelegate,CellProtocol>

@property (strong,nonatomic) NSArray *allData;
@property (strong,nonatomic) NSNumber *reload;
@property (strong,nonatomic) NSFetchedResultsController *fetchResultController;
@property (strong,nonatomic) Manager *manager;
@property (strong,nonatomic) WebData *webData;

- (instancetype)init;

- (void )setFectch:(NSString *)entityname sort:(NSString *)sortName;
- (NSUInteger )getMaxId:(NSString *)entityname name:(NSString *)idName;
- (id )getObject:(NSUInteger )index;

@end
