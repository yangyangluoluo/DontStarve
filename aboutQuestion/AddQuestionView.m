//
//  AddQuestionView.m
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "AddQuestionView.h"

@implementation AddQuestionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self titleLabel]];
    [self addSubview:[self title]];
    [self addSubview:[self describeLabel]];
    [self addSubview:[self describe]];
}

- (void)defineLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self).offset(10);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self.title.mas_bottom).offset(5);
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.describeLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(150);
    }];
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"输入问题的标题(3到20字):";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.alpha = 0.5;
    }
    return _titleLabel;
}

- (UITextField *)title{
    if (!_title) {
        _title = [[UITextField alloc]init];
        _title.backgroundColor = [UIColor whiteColor];
        _title.layer.borderColor = FlatGreenDark.CGColor;
        _title.layer.cornerRadius = 4;
        _title.layer.borderWidth = 0.5;
        _title.layer.masksToBounds = YES;
    }
    return _title;
}

- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.text = @"输入问题的描述(3到500字):";
        _describeLabel.font = [UIFont systemFontOfSize:14];
        _describeLabel.alpha = 0.5;
    }
    return _describeLabel;
}

- (UITextView *)describe{
    if (!_describe) {
        _describe = [[UITextView alloc]init];
        _describe.font = [UIFont systemFontOfSize:20];
        _describe.layer.borderColor = FlatGreenDark.CGColor;
        _describe.layer.cornerRadius = 4;
        _describe.layer.borderWidth = 0.5;
        _describe.layer.masksToBounds = YES;
    }
    return _describe;
}















@end
