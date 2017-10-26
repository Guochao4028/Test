//
//  LoginView.m
//  Real
//
//  Created by WangShuChao on 2017/10/26.
//  Copyright © 2017年 真的网络科技公司. All rights reserved.
//

#import "LoginView.h"
#import "UIView+CGFrameLayout.h"

#define TITLEVIEW_HEIGHT 48
#define CONTENTVIEW_HEIGHT 300
#define LOGINVIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define LOGINVIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LoginView ()
/*  内容 */
@property(nonatomic, strong)UIView *contentView;
/*  登录页面（输入手机号，第三个登录，密码登录，验证登录） */
@property(nonatomic, strong)UIView *loginMainView;
/*  输入手机号 */
@property(nonatomic, strong)UITextField *inputPhoneNumberTextField;
/*  验证登录 */
@property(nonatomic, strong)UIButton *codeLoginButton;
/*  显示标题 */
@property(nonatomic, strong)UIView *loginTitleView;
/*  标题上的文字 */
@property(nonatomic, strong)UILabel *loginTitleLabel;
/*  标题上的按钮 */
@property(nonatomic, strong)UIButton *loginTitleButton;

@property(nonatomic, copy)NSString *titleStirng;

@property(nonatomic, copy)NSString *buttonWordString;

@property(nonatomic, assign)CGFloat viewHeight;
@property(nonatomic, assign)CGFloat viewWidth;

@property(nonatomic, assign)BOOL isClose;

@property(nonatomic, strong)UIView *loginCodeView;

@end

@implementation LoginView

-(instancetype)init{
    
    self = [super init];
    if (self != nil) {
        [self setFrame:CGRectMake(0, 0, LOGINVIEW_WIDTH, LOGINVIEW_HEIGHT)];
        [self initUI];
        [self initData];
        [self listenMethods];
    }
    return self;
}

#pragma mark -
/*  初始化布局 */
-(void)initUI{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self addSubview:self.contentView];
    /*  标题 */
    [self.contentView addSubview:self.loginTitleView];
    [self.loginTitleView addSubview:self.loginTitleLabel];
    [self.loginTitleView addSubview:self.loginTitleButton];
    self.titleStirng = @"登录/注册";
    self.buttonWordString = nil;
    /*  mainview */
    [self.contentView addSubview:self.loginMainView];
    [self.loginMainView addSubview:self.inputPhoneNumberTextField];
    [self.loginMainView addSubview:self.codeLoginButton];
    [self updataFrame];
    
    /*  验证码 */
    [self.contentView addSubview:self.loginCodeView];
}

-(void)initData{
    
    self.isClose = YES;
    
}

/*  更新所有页面的frame */
-(void)updataFrame{
    [self.contentView setFrame:CGRectMake(0, self.viewHeight, self.viewWidth, CONTENTVIEW_HEIGHT)];
    /*  titleViewFrame */
    [self updateLoginTitleFrame];
    /*  mainView */
    [self updateLoginMainViewFrame];
    /*  codeView */
    [self updateLoginCodeFrame];
}

/*  标题View的Frame */
-(void)updateLoginTitleFrame{
    
    [self.loginTitleView setFrame:CGRectMake(0, 0, self.viewWidth, TITLEVIEW_HEIGHT)];
    [self.loginTitleLabel setFrame:CGRectMake(14, 14, 70, 21)];
    [self.loginTitleButton setFrame:CGRectMake(90, 14, 50, 50)];
}

/*  MainView的Frame */
-(void)updateLoginMainViewFrame{
    
    [self.loginMainView setFrame:CGRectMake(0, TITLEVIEW_HEIGHT, self.viewWidth, CONTENTVIEW_HEIGHT - TITLEVIEW_HEIGHT)];
    
    ;
    
    [self.inputPhoneNumberTextField setFrame:CGRectMake(0, 10, 120, 50)];
    
    [self.codeLoginButton setFrame:CGRectMake(0, CGRectGetMaxY(self.inputPhoneNumberTextField.frame) + 12, 150, 50)];
}

/*  验证码View的Frame */
-(void)updateLoginCodeFrame{
    
    [self.loginCodeView setFrame:CGRectMake(0, TITLEVIEW_HEIGHT, self.viewWidth, CONTENTVIEW_HEIGHT - TITLEVIEW_HEIGHT)];
}

/*  更新UI */
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

/*  整体点击 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self gone];
}
/*  监听通知 */
-(void)listenMethods{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)slideDirection:(BOOL)isLeft withCurrentView:(UIView *)currentView withLastView:(UIView *)lastView {
    CGFloat offset = self.frame.size.width;
    CGAffineTransform leftTransform = CGAffineTransformMakeTranslation(-offset, 0);
    CGAffineTransform rightTransform = CGAffineTransformMakeTranslation(offset, 0);
    CGAffineTransform currentTransform,lastTransform;
    if (isLeft) {
        currentTransform = leftTransform;
        lastTransform = rightTransform;
    } else {
        lastTransform = leftTransform;
        currentTransform = rightTransform;
    }
    
    lastView.transform = lastTransform;
    lastView.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        currentView.transform = currentTransform;
        lastView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 监听事件
/*  键盘出现 */
-(void)keyboardWillShow:(NSNotification *)sender{
    CGRect keyboardFrame = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHieght = CGRectGetHeight(keyboardFrame);
    if ([self.inputPhoneNumberTextField isFirstResponder] == YES) {
        self.contentView.y -= keyboardHieght;
    }
}

/*  键盘消失 */
-(void)keyboardWillHide:(NSNotification *)sender{
    
    CGRect keyboardFrame = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHieght = CGRectGetHeight(keyboardFrame);
    self.contentView.y += keyboardHieght;
}

#pragma mark - action
/*  验证登录 */
-(void)codeButtonAtion:(UIButton *)sender{
    
    [self slideDirection:YES withCurrentView:self.loginMainView withLastView:self.loginCodeView];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:.5];
}

/*  标题上的按钮 */
-(void)loginTitleButtonAtion:(UIButton *)sender{
    
    if (self.isClose == YES) {
        [self gone];
    }else{
        [self slideDirection:NO withCurrentView:self.loginCodeView withLastView:self.loginMainView];
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:.5];
    }
}

-(void)delayMethod{
    
    [self.inputPhoneNumberTextField resignFirstResponder];
    
    self.isClose = !self.isClose;
    
    if (self.isClose == NO) {
        self.titleStirng = @"输入验证码";
        self.buttonWordString = @"返回";
    }else{
        
        self.titleStirng = @"登录/注册";
        self.buttonWordString = nil;
    }
}

#pragma mark - setter
-(void)setTitleStirng:(NSString *)titleStirng{
    _titleStirng = titleStirng;
    
    [self.loginTitleLabel setText:titleStirng];
    
}

-(void)setButtonWordString:(NSString *)buttonWordString{
    
    _buttonWordString = buttonWordString;
    [self.loginTitleButton setTitle:buttonWordString forState:UIControlStateNormal];

    if (buttonWordString == nil) {
        [self.loginTitleButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [self.loginTitleButton setTitle:buttonWordString forState:UIControlStateNormal];
    }
}

#pragma mark - getter
/*  整体的宽度 self */
-(CGFloat )viewWidth{
    _viewWidth = CGRectGetWidth(self.bounds);
    return _viewWidth;
}
/*  整体的高度 self */
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

-(UIButton  *)codeLoginButton{
    
    if (_codeLoginButton == nil) {
        _codeLoginButton = [UIButton  buttonWithType:UIButtonTypeCustom];
        [_codeLoginButton setTitle:@"验证登录" forState:UIControlStateNormal];
        [_codeLoginButton addTarget:self action:@selector(codeButtonAtion:) forControlEvents:UIControlEventTouchUpInside];
        [_codeLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _codeLoginButton;
}


-(UIView *)loginTitleView{
    
    if (_loginTitleView == nil) {
        _loginTitleView = [[UIView  alloc]initWithFrame:CGRectZero];
    }
    
    return _loginTitleView;
}

-(UILabel *)loginTitleLabel{
    
    if (_loginTitleLabel == nil) {
        _loginTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    
    return _loginTitleLabel;
}

-(UIButton *)loginTitleButton{
    
    if (_loginTitleButton == nil) {
        _loginTitleButton = [UIButton  buttonWithType:UIButtonTypeCustom];
        [_loginTitleButton addTarget:self action:@selector(loginTitleButtonAtion:) forControlEvents:UIControlEventTouchUpInside];
        [_loginTitleButton setBackgroundColor:[UIColor redColor]];
    }
    
    return _loginTitleButton;
}

-(UIView *)loginCodeView{
    
    if (_loginCodeView == nil) {
        _loginCodeView = [[UIView alloc]initWithFrame:CGRectZero];
        [_loginCodeView setHidden:YES];
        [_loginCodeView setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return _loginCodeView;
}

@end




























