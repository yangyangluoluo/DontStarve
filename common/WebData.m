//
//  WebData.m
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "WebData.h"

@implementation WebData

+ (WebData *)sharedManager{
    static WebData *webData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webData = [[self alloc]init];
    });
    return webData;
}

- (instancetype )init{
    self = [super init];
    if (self) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _configuration.timeoutIntervalForRequest = 10;
        _configuration.timeoutIntervalForResource = 10;
        _manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:_configuration];
 
        
        _jsonManager = [AFHTTPRequestOperationManager manager];
        _jsonManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _jsonManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _jsonManager.requestSerializer.timeoutInterval = 10;
        
        _picDataManager = [AFHTTPRequestOperationManager manager];
        _picDataManager.requestSerializer  =  [AFHTTPRequestSerializer serializer];
        _picDataManager.responseSerializer =  [AFJSONResponseSerializer serializer];
        _picDataManager.requestSerializer.timeoutInterval = 30;
        
        self.fail = [[NSMutableDictionary alloc]initWithCapacity:3];
        [self.fail setObject:@0 forKey:@"state"];
        [self.fail setObject:@"失败" forKey:@"descirbe"];
        
        self.request = [[NSURLRequest alloc]init];
    }
    return self;
}

- (NSString *)setUrlString:(NSString *)address{
     NSString *urlStr = [NSString stringWithFormat:address,PREFIX];
     return [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

- (NSString *)setUrlString:(NSString *)address address1:(NSString *)address1 address2:(NSString *)address2{
    NSString *urlStr = [NSString stringWithFormat:address,PREFIX,address1,address2];
    return [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

- (NSString *)setUrlString:(NSString *)address address1:(id)address1{
    NSString *urlStr = [NSString stringWithFormat:address,PREFIX,address1];
    return [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

@end
