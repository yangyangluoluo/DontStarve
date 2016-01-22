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
#define ALLBOSS         @"http://192.168.1.220/DontStarve/allBoss.php?bossId=%@"
#define BOSSTRAIT       @"http://192.168.1.220/DontStarve/bossTrait.php?bossId=%@"
#define ALLFOODRAW      @"http://192.168.1.220/DontStarve/allFoodRaw.php?foodRawId=%@"
#define ALLRECIPE       @"http://192.168.1.220/DontStarve/allRecipe.php?recipeId=%@"
#define RECIPERAW       @"http://192.168.1.220/DontStarve/recipeRaw.php?recipeId=%@"
#define RECIPEDETAIL    @"http://192.168.1.220/DontStarve/recipeDetail.php?recipeName=%@"

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

- (void )downloadBoss:(NSNumber *)bossId{
    NSString *urlStr = [NSString stringWithFormat:ALLBOSS,bossId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadConstruction ERROR: %@",error);
        }else{
            self.allBoss = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadBossTrait:(NSNumber *)bossId{
    NSString *urlStr = [NSString stringWithFormat:BOSSTRAIT,bossId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadConstruction ERROR: %@",error);
        }else{
            self.bossTrait = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllFoodRaw:(NSNumber *)foodId{
    NSString *urlStr = [NSString stringWithFormat:ALLFOODRAW,foodId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadConstruction ERROR: %@",error);
        }else{
            self.allFoodRaw = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllRecipe:(NSNumber *)recipeId{
    NSString *urlStr = [NSString stringWithFormat:ALLRECIPE,recipeId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadConstruction ERROR: %@",error);
        }else{
            self.allRecipe = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadRecipeRaw:(NSNumber *)recipeId{
    NSString *urlStr = [NSString stringWithFormat:RECIPERAW,recipeId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadRecipeRaw ERROR: %@",error);
        }else{
            self.recipeRaw = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadRecipeDetail:(NSString *)recipeName{
    NSString *urlStr = [NSString stringWithFormat:RECIPEDETAIL,recipeName];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadRecipeRaw ERROR: %@",error);
        }else{
            self.recipeDetail = responseObject;
        }
    }];
    [dataTask resume];
}


@end
