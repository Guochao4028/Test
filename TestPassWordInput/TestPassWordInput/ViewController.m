//
//  ViewController.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "ViewController.h"

#import "PasswordInputView.h"

#import "PasswordAlertView.h"

@interface ViewController ()<PasswordAlertViewDelegate>

//@property(nonatomic, strong)PasswordInputView *passwordField;

@property(nonatomic, strong)PasswordAlertView *passwordAlertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.passwordField= [[PasswordInputView alloc]init];
//    [self.view addSubview:self.passwordField];
//    [self.passwordField setButtonBackgroundColor:[UIColor brownColor]];
//    [self.passwordField actionButtonAddTarget:self action:@selector(a)];
    
    
    self.passwordAlertView = [[PasswordAlertView alloc]init];
    self.passwordAlertView.title = @"请输入支付密码";
    self.passwordAlertView.message = @"提现";
    self.passwordAlertView.amount= 10000;
    [self.passwordAlertView setDelegate:self];
    [self.view addSubview:self.passwordAlertView];
    [self.passwordAlertView show];
    
}


-(void)alertView:(PasswordAlertView *)passwordAlertView getPassword:(NSString *)passwordString{

    NSLog(@"passwordString : %@",passwordString);
}

//-(void)a{
//    
//    NSString *s = [self.passwordField getPassword];
//    
//    NSLog(@"s >> %@",s);
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
