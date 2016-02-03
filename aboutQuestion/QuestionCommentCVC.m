//
//  QuestionCommentCVC.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/28.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Question+CoreDataProperties.h"
#import "QuestionComment+CoreDataProperties.h"
#import "QuestionCommentCVC.h"
#import "ReplyQuestionVC.h"
#import "QuestionCommentModel.h"
#import "CommentCell.h"
#import "LoginViewVC.h"
@interface QuestionCommentCVC ()

@property (strong,nonatomic) Question *question;

@end

@implementation QuestionCommentCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype )initWithCollectionViewLayout:(UICollectionViewLayout *)layout question:(Question *)question{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.question = question;
        self.viewModel = [[QuestionCommentModel alloc]initWithQuestion:question];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题回答";
    self.navigationItem.rightBarButtonItem = [self getRightItem];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[CommentCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [UIFont systemFontOfSize:14];
    CGFloat width = self.view.frame.size.width - 30;
    QuestionComment *comment = [self.viewModel getObject:indexPath.row];
    CGFloat height = [self findHeightForText:comment.theDescribe havingMaximumWidth:width andFont:font];
    CGFloat height1 = height/5;
    return CGSizeMake(self.view.frame.size.width-20, height+height1+80);
}

- (CGFloat)findHeightForText:(NSString *)text havingMaximumWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size.height;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = FlatGreenDark.CGColor;
    cell.layer.borderWidth = 0.5;
    
    QuestionComment *comment = [self.viewModel getObject:indexPath.row];
    cell.nickname.text = comment.user_name;
    cell.date.text = comment.dateStr;
    [self setImageView:cell.portrait urlStr:comment.urlStr];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:comment.theDescribe];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 5;
    style.tailIndent = -5;
    style.firstLineHeadIndent = 20;
    style.lineSpacing = 5;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    cell.describe.attributedText = text;
    
    return cell;
}


- (UIBarButtonItem *)getRightItem{
    self.rightItem = [[UIBarButtonItem alloc]init];
    UIImage *image = [UIImage imageNamed:@"edit"];
    [self.rightItem setImage:image];
    @weakify(self);
    self.rightItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        NSString *name = [self.viewModel getName];
        if (name==NULL) {
            [self sgtUserLogin];
        }else{
            ReplyQuestionVC *replay = [[ReplyQuestionVC alloc]initWithQuestion:self.question];
            [RACObserve(replay, state) subscribeNext:^(NSNumber *x) {
                if (x.intValue == 1) {
                    [self.viewModel downloadData];
                }
            }];
            [self.navigationController pushViewController:replay animated:YES];
        }
        return [RACSignal empty];
    }];
    return self.rightItem;
}

- (void )sgtUserLogin{
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:@"你没有登录,不能评论<^.^>" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        LoginViewVC *login = [[LoginViewVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [alertCtr addAction:firstAction];
    [alertCtr addAction:secondAction];
    [self presentViewController:alertCtr animated:YES completion:^{
    }];
}

@end
