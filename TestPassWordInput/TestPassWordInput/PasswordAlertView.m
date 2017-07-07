//
//  PasswordAlertView.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "PasswordAlertView.h"

#import "PasswordFieldView.h"

@interface PasswordAlertView()<PasswordFieldViewDelegate>

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

-(void)initUI{

    
}



-(void)show{

}

@end
