//
//  PassWordField.h
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PasswordField;

@protocol PasswordFieldDelegate <NSObject>

@optional
-(void)passwordField:(PasswordField *)passwordField password:(NSString *)passwordString;


@end


@interface PasswordField : UIView

@property(nonatomic, weak)id<PasswordFieldDelegate>delegate;

-(void)becomeResponderViewKeyboard;
-(void)resignResponderViewKeyboard;
@end
