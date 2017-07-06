//
//  PassWordField.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "PasswordField.h"
#define kDotCount 6  //密码个数

@interface PasswordField ()<UITextFieldDelegate>

@property(nonatomic)NSMutableArray *pwdIndicatorArr;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic)CGFloat itemWidth;
@end

@implementation PasswordField

-(instancetype)init{
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    if (self != nil) {
        [self initUI];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.textField.frame = frame;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length >= kDotCount && string.length) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
        if ([self.delegate respondsToSelector:@selector(passwordField:password:)] == YES) {
            [self.delegate passwordField:self password:totalString];
        }
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    [self setDotWithCount:totalString.length];
    if (totalString.length == 6) {

        if ([self.delegate respondsToSelector:@selector(passwordField:password:)] == YES) {
            [self.delegate passwordField:self password:totalString];
        }
        
    }

    return YES;
}

- (void)setDotWithCount:(NSInteger)count {
    
    for (UILabel *dot in self.pwdIndicatorArr) {
        dot.hidden = YES;
    }
    
    for (int i = 0; i< count; i++) {
        ((UILabel*)[self.pwdIndicatorArr objectAtIndex:i]).hidden = NO;
    }
}

#pragma mark - methods

-(void)initUI{
    [self addSubview:self.textField];
    [self.layer setBorderWidth:1];
    [self.layer setMasksToBounds:YES];
    [self updateUI];
}

-(void)updateUI{
    //每个密码输入框的宽度
    CGFloat width = self.frame.size.width / kDotCount, height = self.frame.size.height;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(  (i + 1) * width, 0, 1, height)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    
    self.pwdIndicatorArr = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake((width - kDotCount) / 2 + i * width, (height - 10) / 2, 10, 10)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = 10/ 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.pwdIndicatorArr addObject:dotView];
        
    }
}

-(void)becomeResponderViewKeyboard{

    [self.textField becomeFirstResponder];
}

-(void)resignResponderViewKeyboard{
    
    [self.textField resignFirstResponder];
}

#pragma mark - getter

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        _textField.hidden = YES;
    }
    return _textField;
}



@end
