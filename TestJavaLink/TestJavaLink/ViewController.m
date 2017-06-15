//
//  ViewController.m
//  TestJavaLink
//
//  Created by WangShuChao on 2017/6/14.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getTong];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getTong{
    // 1 创建URL对象
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888"];
    
    // 2 创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 2.1 创建请求方式 (默认是get这一步可以不写)
    [request setHTTPMethod:@"get"];
    
    // 3 创建响应对象(有时会出错)
    NSURLResponse *response= nil;
    
    // 4 创建连接对象(同步)
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"data : %@",data);
    if(data != nil && data.length > 0){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dict : %@",dict);

    }
}
@end
