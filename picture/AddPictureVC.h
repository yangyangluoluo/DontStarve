//
//  AddPictureVC.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class  ELCImagePickerController;
#import "ELCImagePickerController.h"
#import <UIKit/UIKit.h>

@interface AddPictureVC : UIViewController<ELCImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (strong ,nonatomic) UIScrollView *scrollView;
@property (nonatomic, copy) NSArray *chosenImages;


@end
