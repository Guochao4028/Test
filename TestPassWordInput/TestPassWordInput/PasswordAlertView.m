//
//  PasswordAlertView.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "PasswordAlertView.h"
#import "PasswordFieldView.h"
/* 弹窗的高度 */
#define ALERT_HEIGHT 200
/*  键盘高度 */
#define KEYBOARD_HEIGHT 216
/*  标题的高度 */
#define TITLE_HEIGHT 46

#define KEY_VIEW_DISTANCE 100

#define PAYMENT_WIDTH [UIScreen mainScreen].bounds.size.width-80


@interface PasswordAlertView()<PasswordFieldViewDelegate>
@property (nonatomic, strong) UIView *paymentAlert;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) PasswordFieldView *pwdField;

@end

@implementation PasswordAlertView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        
        
        
        [self initUI];
    }
    return self;
}

#pragma mark - methods

-(void)initUI{

    if (!_paymentAlert) {
        _paymentAlert = [[UIView alloc]initWithFrame:CGRectMake(40, [UIScreen mainScreen].bounds.size.height-KEYBOARD_HEIGHT-KEY_VIEW_DISTANCE-ALERT_HEIGHT, [UIScreen mainScreen].bounds.size.width-80, ALERT_HEIGHT)];
        _paymentAlert.layer.cornerRadius = 5.f;
        _paymentAlert.layer.masksToBounds = YES;
        _paymentAlert.backgroundColor = [UIColor colorWithWhite:1. alpha:.95];
        [self addSubview:_paymentAlert];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, PAYMENT_WIDTH, TITLE_HEIGHT)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [_paymentAlert addSubview:_titleLabel];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setFrame:CGRectMake(0, 0, TITLE_HEIGHT, TITLE_HEIGHT)];
        [_closeButton setTitle:@"╳" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_paymentAlert addSubview:_closeButton];
        
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, TITLE_HEIGHT, PAYMENT_WIDTH, .5f)];
        _line.backgroundColor = [UIColor lightGrayColor];
        [_paymentAlert addSubview:_line];
        
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, TITLE_HEIGHT+15, PAYMENT_WIDTH-30, 20)];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor darkGrayColor];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        [_paymentAlert addSubview:_detailLabel];
        
        _amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, TITLE_HEIGHT*2, PAYMENT_WIDTH-30, 25)];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.textColor = [UIColor darkGrayColor];
        _amountLabel.font = [UIFont systemFontOfSize:33];
        [_paymentAlert addSubview:_amountLabel];
        
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(15, _paymentAlert.frame.size.height-(PAYMENT_WIDTH-30)/6-15, PAYMENT_WIDTH-30, (PAYMENT_WIDTH-30)/6)];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.layer.borderWidth = 1.f;
        _inputView.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.].CGColor;
        [_paymentAlert addSubview:_inputView];
        
        _pwdField = [[PasswordFieldView alloc]initWithFrame:_inputView.bounds];
        [_pwdField setDelegate:self];
        [_inputView addSubview:_pwdField];
        
        
    }
}


- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    _paymentAlert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    _paymentAlert.alpha = 0;
    
    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.pwdField becomeResponderViewKeyboard];
        _paymentAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _paymentAlert.alpha = 1.0;
    } completion:nil];
}

- (void)dismiss {
    [self.pwdField resignResponderViewKeyboard];
    [UIView animateWithDuration:0.3f animations:^{
        _paymentAlert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        _paymentAlert.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - PasswordFieldViewDelegate

-(void)passwordField:(PasswordFieldView *)passwordField password:(NSString *)passwordString{
    
    if ([self.delegate respondsToSelector:@selector(alertView:getPassword:)] == YES) {
        [self.delegate alertView:self getPassword:passwordString];
    }

    [self dismiss];
    NSLog(@"passwordString : %@",passwordString);
}

#pragma mark - setter
- (void)setTitle:(NSString *)title {
    
        _title = title;
        _titleLabel.text = _title;
}

- (void)setMessage:(NSString *)message{
    _message = message;
    _detailLabel.text = _message;
    
}

- (void)setAmount:(int)amount {
        _amount = amount;
        _amountLabel.text = [NSString stringWithFormat:@"￥%d  ",amount];
}


@end
