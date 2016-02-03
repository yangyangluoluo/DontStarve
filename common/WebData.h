//
//  WebData.h
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"
#import <Foundation/Foundation.h>
#import "DefineState.h"
#import "DefineUrl.h"
@interface WebData : NSObject

@property (strong,nonatomic) AFURLSessionManager *manager;
@property (strong,nonatomic) AFHTTPRequestOperationManager *jsonManager;
@property (strong,nonatomic) AFHTTPRequestOperationManager *picDataManager;
@property (strong,nonatomic) NSURLSessionConfiguration *configuration;
@property (strong,nonatomic) NSURLRequest *request;
@property (strong,nonatomic) NSURLSessionDataTask *dataTask;
@property (strong,nonatomic) NSMutableDictionary *fail;

- (instancetype)init;
+ (WebData *)sharedManager;
- (NSString *)setUrlString:(NSString *)address;
- (NSString *)setUrlString:(NSString *)address address1:(id)address1 address2:(id)address2;
- (NSString *)setUrlString:(NSString *)address address1:(id)address1;

@end
