//
//  AgreementVC.m
//  Geological1
//
//  Created by 李建国 on 16/1/3.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "AgreementVC.h"
#import "MyADTransition.h"
#import "DefineState.h"

@interface AgreementVC ()

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) UILabel *one;
@property (assign,nonatomic) CGFloat height;
@end

@implementation AgreementVC

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.title = @"用户协议";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:FlatGreenDark}];
    
    if (UI_IS_IPHONE4) {
        self.height = 2.1;
    }else if(UI_IS_IPHONE5){
        self.height = 1.8;
    }else if (UI_IS_IPHONE6){
        self.height = 1.4;
    }else{
        self.height = 1.2;
        
    }
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*self.height);
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:[self scrollView]];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*self.height)];
    [self.scrollView addSubview:[self bgView]];
    
    self.one = [[UILabel alloc]init];
    self.one.text = @"用户注册协议";
    self.one.textAlignment = NSTextAlignmentCenter;
    self.one.font = [UIFont systemFontOfSize:20];
    self.one.textColor = FlatGreenDark;
    [self.bgView addSubview:[self one]];
    [self.one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView);
        make.centerX.mas_equalTo(self.bgView);
    }];
    
    UILabel *label1 = [self productTitle];
    label1.text = @"一.地质人服务条款确认";
    [self.bgView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(self.one.mas_bottom).offset(5);
    }];
    
    UILabel *lable2 = [self productDescribe];
    lable2.text = @"    地质人提供的服务将严格按照本软件操作规则执行。用户必须确认所有服务条款并完成注册程序，才能成为地质人的正式用户。";
    [self.bgView addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(label1.mas_bottom).offset(5);
    }];
    
    UILabel *label3 = [self productTitle];
    label3.text = @"二.注册用户隐私保护";
    [self.bgView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(lable2.mas_bottom).offset(10);
    }];
    
    UILabel *lable4 = [self productDescribe];
    lable4.text = @"    用户一旦注册成功，成为地质人的合法用户，将得到一个密码和用户名。 由用户对用户名和密码安全负全部责任。用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告地质人。 地质人尊重用户个人隐私，未经合法用户授权，本软件不会在公开、编辑或透露其注册资料及保存在本网的非公开内容。";
    [self.bgView addSubview:lable4];
    [lable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(label3.mas_bottom).offset(5);
    }];
    
    UILabel *label5 = [self productTitle];
    label5.text = @"三.风险承担";
    [self.bgView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(lable4.mas_bottom).offset(10);
    }];
    
    UILabel *lable6 = [self productDescribe];
    lable6.text = @"    用户个人对网络服务的使用自行承担风险。地质人所提供的所有资料权限于对用户参考，不对用户的商业运作做任何具体性指导，用户应自行承担使用或提供本网信息的商业活动及其风险。地质人不保证服务一定能满足用户的要求，也不保证服务不会受中断。本软件将尽力保证服务的及时性、准确性、安全性，但对及时性、准确性、安全性等都不作任何具体承诺。对用户在运用地质人得到的任何商品购物服务或交易进程，均不作任何担保。";
    [self.bgView addSubview:lable6];
    [lable6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(label5.mas_bottom).offset(5);
    }];
    
    UILabel *label7 = [self productTitle];
    label7.text = @"四.免责事由";
    [self.bgView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(lable6.mas_bottom).offset(10);
    }];

    UILabel *lable8 = [self productDescribe];
    lable8.text = @"    地质人对用户在接受服务过程中所受的任何直接、间接的损害不负责任，这些损害可能来自：不正当使用网络服务，在网上购买商品或进行同类型服务，在网上进行交易，非法使用网络服务或用户传送的信息有所变动等。 地质人不对用户所发布信息的删除或储存失败负责。地质人有判定用户的行为是否符合本网服务条款的要求和精神的保留权利，如果用户违背了服务条款的规定，地质人有中断对其提供网络服务的权利。 对用户自行提供的信息，由用户依法自行承担全部责任。地质人对此等信息的准确性、完整性、合法性或真实性均不承担任何责任。 用户在本软件所发表的任何意见均属于个人意见，并不代表地质人也持同样的观点。";
    [self.bgView addSubview:lable8];
    [lable8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(label7.mas_bottom).offset(5);
    }];

    UILabel *label9 = [self productTitle];
    label9.text = @"五.用户承诺";
    [self.bgView addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(lable8.mas_bottom).offset(10);
    }];
    
    UILabel *lable10 = [self productDescribe];
    lable10.text = @"    用户自行承担发布内容的责任。用户对服务的使用是根据所有适用于中华人民共和国国家法律、地方法律和国际法律准则的规定的。";
    [self.bgView addSubview:lable10];
    [lable10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(label9.mas_bottom).offset(5);
    }];
    
    UILabel *label11 = [self productTitle];
    label11.text = @"六.通告形式";
    [self.bgView addSubview:label11];
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(lable10.mas_bottom).offset(10);
    }];
    
    UILabel *lable12 = [self productDescribe];
    lable12.text = @"    地质人服务条款的修改、服务变更、或其它重要事件发生变动而需要通告时，可根据实际情况选择通过重要页面公告、电子邮件、常规信件等形式进行。";
    [self.bgView addSubview:lable12];
    [lable12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(label11.mas_bottom).offset(5);
    }];
    
    UILabel *label13 = [self productTitle];
    label13.text = @"七.法律适用";
    [self.bgView addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(lable12.mas_bottom).offset(10);
    }];
    
    UILabel *lable14 = [self productDescribe];
    lable14.text = @"    本网网络服务条款与中华人民共和国的法律解释相一致，用户和地质人一致同意服从中华人民共和国法律的管辖。如发生地质人服务条款与中华人民共和国法律相抵触时，则这些条款将完全按法律规定重新解释，而其它条款则依旧保持对用户产生法律效力和影响。";
    [self.bgView addSubview:lable14];
    [lable14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.top.mas_equalTo(label13.mas_bottom).offset(5);
    }];
}


- (UILabel *)productTitle{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.preferredMaxLayoutWidth = self.view.frame.size.width-10;
    label.textColor = FlatGreenDark;
    return label;
}

- (UILabel *)productDescribe{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.preferredMaxLayoutWidth = self.view.frame.size.width-10;
    label.textColor = FlatBlackDark;
    return label;
}


- (UIBarButtonItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIBarButtonItem alloc]init];
        UIImage *bgImage = [UIImage imageNamed:@"back"];
        [_leftItem setImage:bgImage];
        @weakify(self);
        _leftItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            NSUInteger count = self.navigationController.viewControllers.count-2;
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count]animated:YES];
            return [RACSignal empty];
        }];
    }
    return _leftItem;
}

@end
