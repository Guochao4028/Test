//
//  ViewController.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "ViewController.h"

#import "PasswordInputView.h"

@interface ViewController ()

@property(nonatomic, strong)PasswordInputView *passwordField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.passwordField= [[PasswordInputView alloc]init];
    [self.view addSubview:self.passwordField];
    [self.passwordField setButtonBackgroundColor:[UIColor brownColor]];
    [self.passwordField actionButtonAddTarget:self action:@selector(a)];
    
}


-(void)a{
    
    NSString *s = [self.passwordField getPassword];
    
    NSLog(@"s >> %@",s);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
