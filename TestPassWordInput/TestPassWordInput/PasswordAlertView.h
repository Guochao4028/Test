//
//  PasswordAlertView.h
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PasswordAlertViewDelegate <NSObject>

@optional



@end

@interface PasswordAlertView : UIView
/*  标题 */
@property (nonatomic, copy) NSString *title;
/*   */
@property (nonatomic, copy) NSString *message;
/*  钱数 */
@property (nonatomic, assign) CGFloat amount;

@property (nonatomic, weak)id<PasswordAlertViewDelegate>delegate;

- (void)show;

@end
