//
//  WebData.m
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "WebData.h"
#define PREFIX          @"http://192.168.1.220/"
#define ALLCHARACTERS   @"%@DontStarve/allCharacters.php?characterId=%@"
#define ALLANIMAL       @"%@DontStarve/allAnimal.php?animalId=%@"
#define ALLPLANT        @"%@DontStarve/allPlant.php?plantId=%@"
#define ALLCONSTRUCT    @"%@DontStarve/allConstruction.php?constructionId=%@"
#define ALLBOSS         @"%@DontStarve/allBoss.php?bossId=%@"
#define BOSSTRAIT       @"%@DontStarve/bossTrait.php?bossId=%@"
#define ALLFOODRAW      @"%@DontStarve/allFoodRaw.php?foodRawId=%@"
#define ALLRECIPE       @"%@DontStarve/allRecipe.php?recipeId=%@"
#define RECIPERAW       @"%@DontStarve/recipeRaw.php?recipeId=%@"
#define RECIPEDETAIL    @"%@DontStarve/recipeDetail.php?recipeName=%@"
#define ALLTOOL         @"%@DontStarve/allTool.php?toolId=%@"
#define ALLFIRE         @"%@DontStarve/allFire.php?fireId=%@"
#define ALLPRODUCE      @"%@DontStarve/allProduce.php?produceId=%@"
#define ALLSCIENCE      @"%@DontStarve/allScience.php?scienceId=%@"
#define ALLBUILD        @"%@DontStarve/allBuild.php?buildId=%@"
#define ALLREFINE       @"%@DontStarve/allRefine.php?refineId=%@"
#define ALLMAGIC        @"%@DontStarve/allMagic.php?magicId=%@"
#define ALLANCIENT      @"%@DontStarve/allAncient.php?ancientId=%@"
#define ALLBOOK         @"%@DontStarve/allBook.php?bookId=%@"


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
    NSString *urlStr = [NSString stringWithFormat:ALLCHARACTERS,PREFIX,CharactersId];
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
    NSString *urlStr = [NSString stringWithFormat:ALLANIMAL,PREFIX,animalId];
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
    NSString *urlStr = [NSString stringWithFormat:ALLPLANT,PREFIX,plantId];
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
    NSString *urlStr = [NSString stringWithFormat:ALLCONSTRUCT,PREFIX,constructionId];
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
    NSString *urlStr = [NSString stringWithFormat:ALLBOSS,PREFIX,bossId];
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
    NSString *urlStr = [NSString stringWithFormat:BOSSTRAIT,PREFIX,bossId];
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
    NSString *urlStr = [NSString stringWithFormat:ALLFOODRAW,PREFIX,foodId];
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
    NSString *urlStr = [NSString stringWithFormat:ALLRECIPE,PREFIX,recipeId];
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
    NSString *urlStr = [NSString stringWithFormat:RECIPERAW,PREFIX,recipeId];
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
    NSString *urlStr = [NSString stringWithFormat:RECIPEDETAIL,PREFIX,recipeName];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadRecipeDetail ERROR: %@",error);
        }else{
            self.recipeDetail = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllTool:(NSNumber *)toolId{
    NSString *urlStr = [NSString stringWithFormat:ALLTOOL,PREFIX,toolId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllTool ERROR: %@",error);
        }else{
            self.allTool = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllFire:(NSNumber *)fireId{
    NSString *urlStr = [NSString stringWithFormat:ALLFIRE,PREFIX,fireId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllFire ERROR: %@",error);
        }else{
            self.allFire = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllProduce:(NSNumber *)produceId{
    NSString *urlStr = [NSString stringWithFormat:ALLPRODUCE,PREFIX,produceId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllProduce ERROR: %@",error);
        }else{
            self.allProduce = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllScience:(NSNumber *)sicenceId{
    NSString *urlStr = [NSString stringWithFormat:ALLSCIENCE,PREFIX,sicenceId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllScience ERROR: %@",error);
        }else{
            self.allProduce = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllBuild:(NSNumber *)BuildId{
    NSString *urlStr = [NSString stringWithFormat:ALLBUILD,PREFIX,BuildId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllBuild ERROR: %@",error);
        }else{
            self.allBuild = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllRefine:(NSNumber *)refineId{
    NSString *urlStr = [NSString stringWithFormat:ALLREFINE,PREFIX,refineId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllRefine ERROR: %@",error);
        }else{
            self.allRefine = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllMagic:(NSNumber *)magicId{
    NSString *urlStr = [NSString stringWithFormat:ALLMAGIC,PREFIX,magicId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllMagic ERROR: %@",error);
        }else{
            self.allMagic = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllAncient:(NSNumber *)ancientId{
    NSString *urlStr = [NSString stringWithFormat:ALLANCIENT,PREFIX,ancientId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllAncient ERROR: %@",error);
        }else{
            self.allAncient = responseObject;
        }
    }];
    [dataTask resume];
}

- (void )downloadAllBook:(NSNumber *)bookId{
    NSString *urlStr = [NSString stringWithFormat:ALLBOOK,PREFIX,bookId];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (error) {
            NSLog(@"downloadAllAncient ERROR: %@",error);
        }else{
            self.allBook = responseObject;
        }
    }];
    [dataTask resume];
}

@end
