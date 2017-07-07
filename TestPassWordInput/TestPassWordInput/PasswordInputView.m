//
//  PasswordInputView.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/7.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "PasswordInputView.h"

#import "PasswordFieldView.h"

#define KPaymentBounds [UIScreen mainScreen].bounds

@interface PasswordInputView ()<PasswordFieldViewDelegate>
@property(nonatomic, strong)PasswordFieldView *passwordFieldView;
@property(nonatomic, strong)UIButton *actionButton;
@end

@implementation PasswordInputView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self initUI];
    }
    return self;
}

-(instancetype)init{
    return [self initWithFrame:KPaymentBounds];
}


#pragma mark - methods
-(void)initUI{
    [self addSubview:self.passwordFieldView];
    [self addSubview:self.actionButton];
    
    [self updateUI];
}

-(void)updateUI{

    [self.passwordFieldView setFrame:CGRectMake(14, 100, 280, 60)];
    
    CGFloat buttonY = CGRectGetMaxY(self.passwordFieldView.frame) + 40;
    CGFloat buttonX = CGRectGetMinX(self.passwordFieldView.frame);
    [self.actionButton setFrame:CGRectMake(buttonX, buttonY, 280, 60)];
}


#pragma mark - PasswordFieldViewDelegate
-(void)passwordField:(PasswordFieldView *)passwordField password:(NSString *)passwordString{
    
    if (_completeHandle) {
        _completeHandle(passwordString);
    }
}

-(void)passwordField:(PasswordFieldView *)passwordField didChange:(NSString *)passwordString{


     NSLog(@"passwordSting : %@", passwordString);
}

-(void)actionButtonAddTarget:(id)target action:(SEL)action{
    [self.actionButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - setter

-(void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    [self.actionButton setTitle:buttonTitle forState:UIControlStateNormal];
}

-(void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor{
    [self.actionButton setBackgroundColor:buttonBackgroundColor];
}

-(void)setIsViewButton:(BOOL)isViewButton{

    _isViewButton = isViewButton;
    
    if (isViewButton == YES) {
        [self.actionButton setHidden:NO];
    }else{
    
        [self.actionButton setHidden:YES];
    }
}


#pragma mark - getter
-(PasswordFieldView *)passwordFieldView{
    
    if (_passwordFieldView == nil) {
        _passwordFieldView = [[PasswordFieldView alloc]initWithFrame:CGRectZero];
        [_passwordFieldView setDelegate:self];
        [_passwordFieldView becomeResponderViewKeyboard];
    }
    return _passwordFieldView;
    
}

-(UIButton *)actionButton{
    
    if (_actionButton == nil) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    return _actionButton;
}



@end
