//
//  ViewController.m
//  Test
//
//  Created by WangShuChao on 2017/5/22.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "ViewController.h"

#import "CategoryListViewController.h"

#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height

@interface ViewController ()

@property(nonatomic, strong)CategoryListViewController *categoryListViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.view addSubview:self.categoryListViewController.view];
    
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CategoryListViewController

-(CategoryListViewController *)categoryListViewController{
    
    if (_categoryListViewController == nil) {
        _categoryListViewController = [[CategoryListViewController alloc]init];
        [self addChildViewController:_categoryListViewController];

        [self.categoryListViewController.view setFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight - (64 + 40))];
    }
    
    return _categoryListViewController;
}

@end
