//
//  WebData.m
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "WebData.h"

#define ALLCHARACTERS   @"http://192.168.1.220/DontStarve/allCharacters.php?characterId=%@"
#define ALLANIMAL       @"http://192.168.1.220/DontStarve/allAnimal.php?animalId=%@"
#define ALLPLANT        @"http://192.168.1.220/DontStarve/allPlant.php?plantId=%@"
#define ALLCONSTRUCT    @"http://192.168.1.220/DontStarve/allConstruction.php?constructionId=%@"

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
        _manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:_configuration];
    }
    return self;
}

- (void)downLoadCharactersbyId:(NSNumber *)CharactersId{
    NSString *urlStr = [NSString stringWithFormat:ALLCHARACTERS,CharactersId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downLoadCharactersbyId ERROR: %@",error);
        }else{
            self.allCharacters = responseObject;
        }
    }];
    [dataTask resume];
}

- (void)downloadAnimal:(NSNumber *)animalId{
    NSString *urlStr = [NSString stringWithFormat:ALLANIMAL,animalId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAnimal ERROR: %@",error);
        }else{
            self.allAnimal = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllPlant:(NSNumber *)plantId{
    NSString *urlStr = [NSString stringWithFormat:ALLPLANT,plantId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllPlant ERROR: %@",error);
        }else{
            self.allPlant = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadConstruction:(NSNumber *)constructionId{
    NSString *urlStr = [NSString stringWithFormat:ALLCONSTRUCT,constructionId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadConstruction ERROR: %@",error);
        }else{
            self.allConstruction = responseObject;
        }
    }];
    [dataTask resume];
}

@end
