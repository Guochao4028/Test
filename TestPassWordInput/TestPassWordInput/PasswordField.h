//
//  PassWordField.h
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PasswordField;

@protocol PassWordFieldDelegate <NSObject>

@optional
-(void)passWordField:(PasswordField *)passWordField passWord:(NSString *)passWordString;

@end


@interface PasswordField : UIView

-(void)becomeResponderViewKeyboard;
-(void)resignResponderViewKeyboard;
@end
