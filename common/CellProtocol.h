//
//  CellProtocol.h
//  Geological1
//
//  Created by 李建国 on 15/12/26.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@protocol CellProtocol <NSObject>

@required

@optional

- (void )bindWithReactive;
- (void )downloadFordown;
- (void )downloadForUp;
- (void )downloadData;
- (NSUInteger)getCount;
- (void )saveDataToCoreData;

@end
