//
//  ViewController.m
//  TestPassWordInput
//
//  Created by WangShuChao on 2017/7/6.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "ViewController.h"

#import "PassWordField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PassWordField *a = [[PassWordField alloc]initWithFrame:CGRectMake(14, 100, 280, 60)];
    [self.view addSubview:a];
    
//    [a setBackgroundColor:[UIColor redColor]];
    
    [a becomeResponderViewKeyboard];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
