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
        self.manager = [[Manager alloc]init];
        self.webData = [WebData sharedManager];
        self.theUser = [User sharedManager];
        self.dateFormatter = [BaseModel getdaTeFormatterSharedManager];
        self.fetchResultController = nil;
    }
    return self;
}


+ (NSDateFormatter *)getdaTeFormatterSharedManager{
    static NSDateFormatter *dataFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataFormatter = [[NSDateFormatter alloc] init];
        [dataFormatter setDateFormat:@"yy年MM月dd日 HH:mm"];
    });
    return dataFormatter;
}

- (void )savePictureData:(NSData *)data{
    NSString *urlStr = [self.webData setUrlString:SAVEPICTUREDATA];
    @weakify(self);
    [self.webData.picDataManager POST:urlStr parameters:data  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self);
        self.data = responseObject;
//        NSLog(@"%@",[self.data objectForKey:@"state"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *describe = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        [self.webData.fail setObject:describe forKey:@"descirbe"];
        self.data = self.webData.fail;
        NSLog(@"uploadPictureData Error: %@", error);
    }];
}

- (void )downloadAddress:(NSString *)address{
    self.webData.request = [NSURLRequest requestWithURL:[NSURL URLWithString:address]];
    @weakify(self);
    self.webData.dataTask = [self.webData.manager dataTaskWithRequest:self.webData.request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (!error) {
            self.data = responseObject;
        }else{
            NSString *describe = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            [self.webData.fail setObject:describe forKey:@"descirbe"];
            self.data = self.webData.fail;
            NSLog(@"ERROR: %@",error);
        }
    }];
    [self.webData.dataTask resume];
    
}

- (void )downloadAddress1:(NSString *)address1{
    self.webData.request = [NSURLRequest requestWithURL:[NSURL URLWithString:address1]];
    @weakify(self);
    self.webData.dataTask = [self.webData.manager dataTaskWithRequest:self.webData.request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @strongify(self);
        if (!error) {
            self.data1 = responseObject;
        }else{
            NSString *describe = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            [self.webData.fail setObject:describe forKey:@"descirbe"];
            self.data1 = self.webData.fail;
            NSLog(@"ERROR: %@",error);
        }
    }];
    [self.webData.dataTask resume];
}

- (void )downloadAddress:(NSString *)address information:(NSDictionary *)information{
    @weakify(self);
    [self.webData.jsonManager POST:address parameters:information success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self);
        self.data = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *describe = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        [self.webData.fail setObject:describe forKey:@"descirbe"];
        self.data = self.webData.fail;
        NSLog(@"picture comment model %@",error);
    }];
}

- (void )downloadAddress1:(NSString *)address1 information1:(NSDictionary *)information1{
    @weakify(self);
    [self.webData.jsonManager POST:address1 parameters:information1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self);
        self.data1 = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *describe = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        [self.webData.fail setObject:describe forKey:@"descirbe"];
        self.data1 = self.webData.fail;
        NSLog(@"picture comment model %@",error);
    }];
}

- (NSString *)getName{
    return [self.theUser getName];
}

- (NSNumber *)getRank{
    return [self.theUser getRank];
}

- (NSUInteger )getCount{
    return self.manager.fetchResultController.fetchedObjects.count;
}

- (id )getObject:(NSUInteger )row{
    return self.manager.fetchResultController.fetchedObjects[row];
}

- (void )saveName:(NSString *)name rank:(NSNumber *)rank{
    [self.theUser saveName:name];
    [self.theUser saveRank:rank];
    [self.theUser changState];
}
- (NSUInteger )getDate:(NSString *)entityname name:(NSString *)idName direction:(NSString *)direction;{
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityname inManagedObjectContext:self.manager.managedObjectContext];
    [req setEntity:entity];
    [req setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:idName];
    NSExpression *maxExpression = [NSExpression expressionForFunction:direction arguments:@[keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"theDate"];
    [expressionDescription setExpression:maxExpression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [req setPropertiesToFetch:@[expressionDescription]];
    
    NSError *error = nil;
    NSArray *obj = [self.manager.managedObjectContext executeFetchRequest:req error:&error];
    NSInteger maxValue = NSNotFound;
    if(obj == nil){
        maxValue = 0;
    }else if([obj count] > 0){
        maxValue = [obj[0][@"theDate"] integerValue];
    }
    return maxValue;
}



@end
