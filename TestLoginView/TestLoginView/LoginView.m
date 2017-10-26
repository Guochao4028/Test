//
//  LoginView.m
//  Real
//
//  Created by WangShuChao on 2017/10/26.
//  Copyright © 2017年 真的网络科技公司. All rights reserved.
//

#import "LoginView.h"

#define TITLEVIEW_HEIGHT 46
#define CONTENTVIEW_HEIGHT 300

@interface LoginView ()
/*  内容 */
@property(nonatomic, strong)UIView *contentView;
/*  登录页面（输入手机号，第三个登录，密码登录，验证登录） */
@property(nonatomic, strong)UIView *loginMainView;
/*  显示标题 */
@property(nonatomic, strong)UIView *loginTitleView;

@end

@implementation LoginView

-(instancetype)init{
    
    self = [super init];
    if (self != nil) {
        [self initUI];
    }
    return self;
}

#pragma mark -

-(void)initUI{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    [self addSubview:self.contentView];
    
//    [self updateUI];
}

-(void)updateUI{
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    [self.contentView setFrame:CGRectMake(0, (viewHeight - ContentHeight), viewWidth, ContentHeight)];
    
    
}

#pragma mark - methods
-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [UIView animateWithDuration: 0.5 animations: ^{
        [self updateUI];
    } completion: nil];
    
}

#pragma mark - getter

-(UIView *)contentView{
    
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
    return _contentView;
}

-(UIView *)loginMainView{
    
    if (_loginMainView == nil) {
        _loginMainView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
    return _loginMainView;
}

-(UIView *)loginTitleView{
    
    if (_loginTitleView == nil) {
        _loginTitleView = [[UIView  alloc]initWithFrame:CGRectZero];
    }
    
    return _loginTitleView;
}

@end




























