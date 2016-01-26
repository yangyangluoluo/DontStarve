//
//  baseModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BaseModel.h"
@interface BaseModel ()
@end

@implementation BaseModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.manager = [Manager sharedManager];
        self.webData = [WebData sharedManager];
        self.fetchResultController = nil;
    }
    return self;
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:{
            self.reload = @1;
            break;
        }
        case NSFetchedResultsChangeDelete:{
            
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            
            break;
        }
        case NSFetchedResultsChangeMove:{
            break;
        }
        default:{
            break;
        }
    }
}

@end
