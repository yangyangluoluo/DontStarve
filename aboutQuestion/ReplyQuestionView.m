//
//  ReplyQuestionView.m
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "ReplyQuestionView.h"

@implementation ReplyQuestionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self title]];
    [self addSubview:[self image3]];
    [self addSubview:[self image2]];
    [self addSubview:[self image1]];
    [self addSubview:[self image4]];
    [self addSubview:[self image5]];
    [self addSubview:[self line]];
    [self addSubview:[self sgtWriteComment]];
    [self addSubview:[self countWords]];
    [self addSubview:[self comments]];
}

- (void)defineLayout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self).offset(10);
    }];
    
    [self.image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.title);
        make.top.mas_equalTo(self.title.mas_bottom).offset(2);
    }];
    
    [self.image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.image3);
        make.right.mas_equalTo(self.image3.mas_left).offset(-3);
    }];
    
    [self.image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.image2);
        make.right.mas_equalTo(self.image2.mas_left).offset(-3);
    }];
    
    [self.image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.image3);
        make.left.mas_equalTo(self.image3.mas_right).offset(3);
    }];
    
    [self.image5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.image3);
        make.left.mas_equalTo(self.image4.mas_right).offset(3);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.image1.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.sgtWriteComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self.line.mas_bottom).offset(5);
    }];
    
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.sgtWriteComment.mas_bottom).offset(5);
        make.height.mas_equalTo(150);
    }];
    
    [self.countWords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.comments.mas_bottom).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"标题";
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = FlatGreenDark;
    }
    return _title;
}

- (UIImageView *)image3{
    if (!_image3) {
        _image3 = [[UIImageView alloc]init];
        _image3.image = [UIImage imageNamed:@"start"];
    }
    return _image3;
}

- (UIImageView *)image2{
    if (!_image2) {
        _image2 = [[UIImageView alloc]init];
        _image2.image = [UIImage imageNamed:@"start"];
    }
    return _image2;
}

- (UIImageView *)image1{
    if (!_image1) {
        _image1 = [[UIImageView alloc]init];
        _image1.image = [UIImage imageNamed:@"start"];
    }
    return _image1;
}

- (UIImageView *)image4{
    if (!_image4) {
        _image4 = [[UIImageView alloc]init];
        _image4.image = [UIImage imageNamed:@"start"];
    }
    return _image4;
}

- (UIImageView *)image5{
    if (!_image5) {
        _image5 = [[UIImageView alloc]init];
        _image5.image = [UIImage imageNamed:@"start"];
    }
    return _image5;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = FlatGreenDark;
    }
    return _line;
}

- (UILabel *)sgtWriteComment{
    if (!_sgtWriteComment) {
        _sgtWriteComment = [[UILabel alloc]init];
        _sgtWriteComment.text = @"请输入你的回答(2到500子):";
        _sgtWriteComment.textAlignment = NSTextAlignmentLeft;
        _sgtWriteComment.font = [UIFont systemFontOfSize:12];
        _sgtWriteComment.alpha = 0.5;
    }
    return _sgtWriteComment;
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

- (UITextView *)comments{
    if (!_comments) {
        _comments = [[UITextView alloc]init];
        _comments.backgroundColor = [UIColor randomFlatColor];
        _comments.font = [UIFont systemFontOfSize:18];
        _comments.layer.cornerRadius = 10;
        _comments.layer.masksToBounds = YES;
    }
    return _comments;
}


@end
