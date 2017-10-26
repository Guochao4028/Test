//
//  LoginView.m
//  Real
//
//  Created by WangShuChao on 2017/10/26.
//  Copyright © 2017年 真的网络科技公司. All rights reserved.
//

#import "LoginView.h"
#import "UIView+CGFrameLayout.h"

#define TITLEVIEW_HEIGHT 46
#define CONTENTVIEW_HEIGHT 300
#define LOGINVIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define LOGINVIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LoginView ()
/*  内容 */
@property(nonatomic, strong)UIView *contentView;
/*  登录页面（输入手机号，第三个登录，密码登录，验证登录） */
@property(nonatomic, strong)UIView *loginMainView;
@property(nonatomic, strong)UITextField *inputPhoneNumberTextField;
/*  显示标题 */
@property(nonatomic, strong)UIView *loginTitleView;

@property(nonatomic, assign)CGFloat viewHeight;
@property(nonatomic, assign)CGFloat viewWidth;


@end

@implementation LoginView

-(instancetype)init{
    
    self = [super init];
    if (self != nil) {
        [self setFrame:CGRectMake(0, 0, LOGINVIEW_WIDTH, LOGINVIEW_HEIGHT)];
        [self initUI];
        [self listenMethods];
    }
    return self;
}

#pragma mark -

-(void)initUI{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self addSubview:self.contentView];
    [self.contentView setFrame:CGRectMake(0, self.viewHeight, self.viewWidth, CONTENTVIEW_HEIGHT)];
    
    [self.contentView addSubview:self.loginTitleView];
    [self.loginTitleView setFrame:CGRectMake(0, 0, self.viewWidth, TITLEVIEW_HEIGHT)];
    
    [self.contentView addSubview:self.loginMainView];
    [self.loginMainView setFrame:CGRectMake(0, TITLEVIEW_HEIGHT, self.viewWidth, CONTENTVIEW_HEIGHT - TITLEVIEW_HEIGHT)];
    
    [self.loginMainView addSubview:self.inputPhoneNumberTextField];
    [self.inputPhoneNumberTextField setFrame:CGRectMake(0, 10, 120, 50)];
    
}



-(void)updateUI{
    [self.contentView setFrame:CGRectMake(0, (self.viewHeight - CONTENTVIEW_HEIGHT), self.viewWidth, CONTENTVIEW_HEIGHT)];
}

#pragma mark - methods

/*  显示 */
-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];

    
    [UIView animateWithDuration: 0.5 animations: ^{
        [self updateUI];
    } completion: nil];
}

/*  消失 */
-(void)gone{
   
    self.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration: 0.5 animations: ^{
        [self.contentView setFrame:CGRectMake(0, self.viewHeight, self.viewWidth, CONTENTVIEW_HEIGHT)];
    } completion: nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self gone];
}

-(void)listenMethods{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

#pragma mark - 监听事件
-(void)keyboardWillShow:(NSNotification *)sender{
    CGRect keyboardFrame = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHieght = CGRectGetHeight(keyboardFrame);
    self.contentView.y -= keyboardHieght;
    
}


#pragma mark - getter

-(CGFloat )viewWidth{
    _viewWidth = CGRectGetWidth(self.bounds);
    return _viewWidth;
}

-(CGFloat )viewHeight{
    _viewHeight = CGRectGetHeight(self.bounds);
    return _viewHeight;
}


-(UIView *)contentView{
    
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    
    return _contentView;
}

-(UIView *)loginMainView{
    
    if (_loginMainView == nil) {
        _loginMainView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
    return _loginMainView;
}


-(UITextField *)inputPhoneNumberTextField{
    
    if (_inputPhoneNumberTextField == nil) {
        _inputPhoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        [_inputPhoneNumberTextField setPlaceholder:@"请输入手机号"];
    }
    
    return _inputPhoneNumberTextField;
}


-(UIView *)loginTitleView{
    
    if (_loginTitleView == nil) {
        _loginTitleView = [[UIView  alloc]initWithFrame:CGRectZero];
    }
    
    return _loginTitleView;
}

@end




























