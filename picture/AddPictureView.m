//
//  AddPictureView.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "AddPictureView.h"
#import "Chameleon.h"
#import "Masonry.h"

@implementation AddPictureView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:[self bgView]];
    
    [self addSubview:[self title]];
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = FlatGreenDark;
    [self addSubview:[self line]];
    [self addSubview:[self sgtDescribe]];
    [self addSubview:[self countWords]];
    [self addSubview:[self describe]];

}

- (void)defineLayout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self).offset(20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-200);
    }];
    
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self).offset(30);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.title.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.sgtDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self.line.mas_bottom).offset(5);
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.sgtDescribe.mas_bottom).offset(5);
        make.height.mas_equalTo(150);
    }];
    
    [self.countWords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.describe.mas_bottom).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"请描述你的图片";
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = FlatGreenDark;
    }
    return _title;
}

- (UILabel *)sgtDescribe{
    if (!_sgtDescribe) {
        _sgtDescribe = [[UILabel alloc]init];
        _sgtDescribe.text = @"请输入图片的描述(2到100字):";
        _sgtDescribe.textAlignment = NSTextAlignmentLeft;
        _sgtDescribe.font = [UIFont systemFontOfSize:12];
        _sgtDescribe.alpha = 0.5;
    }
    return _sgtDescribe;
}

- (UILabel *)countWords{
    if (!_countWords) {
        _countWords = [[UILabel alloc]init];
        _countWords.textColor = FlatRedDark;
        _countWords.textAlignment = NSTextAlignmentLeft;
        _countWords.font = [UIFont systemFontOfSize:12];
    }
    return _countWords;
}

- (UITextView *)describe{
    if (!_describe) {
        _describe = [[UITextView alloc]init];
        _describe.backgroundColor = FlatGreenDark;
        _describe.font = [UIFont systemFontOfSize:18];
        _describe.layer.cornerRadius = 10;
        _describe.layer.masksToBounds = YES;
        _describe.alpha = 1.0f;
    }
    return _describe;
}

@end
