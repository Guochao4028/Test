//
//  PasswordInputView.h
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/7.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface PasswordInputView : UIView
/*  按钮的标题 */
@property(nonatomic, copy)NSString *buttonTitle;
/*  按钮的背景颜色 */
@property(nonatomic, strong)UIColor *buttonBackgroundColor;
/*  是否显示按钮 */
@property(nonatomic, assign)BOOL isViewButton;
/*  回调 */
@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);
/*  按钮的点击方法 */
-(void)actionButtonAddTarget:(nullable id)target action:(SEL)action;

@end
NS_ASSUME_NONNULL_END
