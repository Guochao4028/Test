//
//  ViewController.m
//  TestLoginView
//
//  Created by WangShuChao on 2017/10/26.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "ViewController.h"
#import "LoginView.h"

@interface ViewController ()
- (IBAction)showLoginView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showLoginView:(id)sender {
    
    LoginView *login = [[LoginView alloc]init];
    [login show];
}
@end
