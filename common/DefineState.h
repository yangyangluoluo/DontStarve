//
//  DefineState.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#ifndef DefineState_h
#define DefineState_h

#define ZERO 0

#define LOGINSUC  1
#define LOGINFAIL 0

#define REGISTERSUC 1
#define REGISTERFAIL 0

#define SUC 1
#define FAIL 0

#define DAY  86400
#define HOUR 3600
#define MINMUTE  60

#define UP  1
#define DOWN 0

#define PICTURECOMMENT 1

//#define PREFIX  @"http://192.168.1.220/"
//#define PREFIX  @"http://139.129.48.69/"
//#define PREFIX  @"http://169.254.213.117/"



#define UI_IS_IPAD              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE4           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define UI_IS_IPHONE5           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE6PLUS       (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations

#endif /* DefineState_h */
