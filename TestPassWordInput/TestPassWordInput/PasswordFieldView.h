//
//  PassWordField.h
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PasswordFieldView;

@protocol PasswordFieldViewDelegate <NSObject>

@optional

-(void)passwordField:(PasswordFieldView *)passwordField password:(NSString *)passwordString;

-(void)passwordField:(PasswordFieldView *)passwordField didChange:(NSString *)passwordString;

@end


@interface PasswordFieldView : UIView

@property(nonatomic, weak)id<PasswordFieldViewDelegate>delegate;

-(void)becomeResponderViewKeyboard;
-(void)resignResponderViewKeyboard;
@end
