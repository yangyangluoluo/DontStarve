//
//  QuestionCVC.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "QuestionCVC.h"
#import "QuestionModel.h"
#import "QuestionCell.h"
#import "AddQuestionVC.h"
#import "Question+CoreDataProperties.h"
#import "QuestionCommentCVC.h"
#import "LoginViewVC.h"

@interface QuestionCVC ()

@property (strong,nonatomic) QuestionModel *viewModel;
@property (strong,nonatomic) NSIndexPath *reloadCell;

@end

@implementation QuestionCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[QuestionModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"饥荒问问";
    self.navigationItem.rightBarButtonItem = [self getRightItem];
    [self initRefresh];
    [self bindWithReactive];
    if ([self.viewModel getCount]==0) {
        [self.collectionView.footer beginRefreshing];
    }

    [self.collectionView registerClass:[QuestionCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)bindWithReactive{
    @weakify(self);
    [RACObserve(self.viewModel, allData) subscribeNext:^(NSArray *x) {
        @strongify(self)
        if (x.count>0) {
            [self.viewModel saveDataToCoreData];
            [self.collectionView.header endRefreshing];
            MJRefreshNormalHeader *header =(MJRefreshNormalHeader*)self.collectionView.header;
            [header setTitle:@"上拉刷新...."forState:MJRefreshStateIdle];
            
            [self.collectionView.footer endRefreshing];
            MJRefreshAutoNormalFooter *footer =(MJRefreshAutoNormalFooter*)self.collectionView.footer;
            [footer setTitle:@"下拉加载数据...."forState:MJRefreshStateIdle];
        }else{
            [self.collectionView.header endRefreshing];
            MJRefreshNormalHeader *header =(MJRefreshNormalHeader*)self.collectionView.header;
            [header setTitle:@"没有数据<.>"forState:MJRefreshStateIdle];
            
            [self.collectionView.footer endRefreshing];
            MJRefreshAutoNormalFooter *footer =(MJRefreshAutoNormalFooter*)self.collectionView.footer;
            [footer setTitle:@"没有数据<.>"forState:MJRefreshStateIdle];
        }
    }];
    
    [RACObserve(self.viewModel, reload) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            [self.collectionView reloadData];
        }
    }];
    
    [RACObserve(self.viewModel, update) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            NSArray *reloadCellPath = @[self.reloadCell];
            [self.collectionView reloadItemsAtIndexPaths:reloadCellPath];
        }
    }];
}


- (void)initRefresh{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (self.collectionView.header.isRefreshing) {
                [self.viewModel downloadFordown];
            };
        });
        
    }];
    self.collectionView.header.hidden = YES;
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (self.collectionView.footer.isRefreshing) {
                [self.viewModel downloadForUp];
            };
        });
    }];
}

- (UIBarButtonItem *)getRightItem{
    self.rightItem = [[UIBarButtonItem alloc]init];
    UIImage *image = [UIImage imageNamed:@"add"];
    [self.rightItem setImage:image];
    @weakify(self);
    self.rightItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if ([self.viewModel getLoginState]) {
            AddQuestionVC *add = [[AddQuestionVC alloc]init];
            [self.navigationController pushViewController:add animated:YES];
        }else{
            [self sgtUserLogin];
        }
        return [RACSignal empty];
    }];
    return self.rightItem;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.viewModel getCount]!=0) {
        self.collectionView.header.hidden = NO;
    }
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [UIFont systemFontOfSize:14];
    CGFloat width = self.view.frame.size.width - 20;
    Question *question = [self.viewModel getQuestion:indexPath.row];
    CGFloat height = [self findHeightForText:question.theDescribe havingMaximumWidth:width andFont:font];
    CGFloat height1 = height/5;
    return CGSizeMake(self.view.frame.size.width, height+height1+140);
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
    QuestionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Question *question = [self.viewModel getQuestion:indexPath.row];
    cell.nickname.text = question.user_name;
    cell.title.text = question.title;
    cell.date.text = question.dateStr;
    cell.replyNum.text = [NSString stringWithFormat:@"回答个数:%@",question.replys];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:question.theDescribe];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 5;
    style.tailIndent = -5;
    style.firstLineHeadIndent = 20;
    style.lineSpacing = 5;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    cell.describe.attributedText = text;
    
    cell.showComments.tag = indexPath.row;
    [cell.showComments addTarget:self action:@selector(showQuestionComments:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)showQuestionComments:(UIButton *)send{
    NSUInteger row = send.tag;
    Question *question = [self.viewModel getQuestion:row];
    [self.viewModel getReplyNum:row];
    self.reloadCell = [NSIndexPath indexPathForRow:row inSection:0];
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    QuestionCommentCVC *comment =[[QuestionCommentCVC alloc]initWithCollectionViewLayout:layout question:question];
    [self.navigationController pushViewController:comment animated:YES];

}

- (void )sgtUserLogin{
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:@"你没有登录,不能提问<^.^>" message:@"" preferredStyle:UIAlertControllerStyleAlert];
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
