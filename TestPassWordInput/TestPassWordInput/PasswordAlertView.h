//
//  PasswordAlertView.h
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PasswordAlertView;

@protocol PasswordAlertViewDelegate <NSObject>

@optional
-(void)alertView:(PasswordAlertView *)passwordAlertView getPassword:(NSString *)passwordString;
@end

@interface PasswordAlertView : UIView
/*  标题 */
@property (nonatomic, copy) NSString *title;
/*  附加信息 */
@property (nonatomic, copy) NSString *message;
/*  钱数 */
@property (nonatomic, assign) int amount;

@property (nonatomic, weak)id<PasswordAlertViewDelegate>delegate;

- (void)show;

@end
