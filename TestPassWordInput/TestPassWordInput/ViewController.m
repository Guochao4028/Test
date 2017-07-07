//
//  ViewController.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "ViewController.h"

#import "PasswordFieldView.h"

@interface ViewController ()<PasswordFieldViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PasswordFieldView *passwordField = [[PasswordFieldView alloc]initWithFrame:CGRectMake(14, 100, 280, 60)];
    [self.view addSubview:passwordField];
    
    
    [passwordField setDelegate:self];
    [passwordField becomeResponderViewKeyboard];
    
}


-(void)passwordField:(PasswordFieldView *)passwordField password:(NSString *)passwordString{

    NSLog(@"passwordSting : %@", passwordString);
//    [passwordField resignResponderViewKeyboard];
}

-(void)passwordField:(PasswordFieldView *)passwordField didChange:(NSString *)passwordString{


     NSLog(@"passwordSting : %@", passwordString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
