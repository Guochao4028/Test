//
//  CategoryListViewController.m
//  Test
//
//  Created by WangShuChao on 2017/5/22.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import "CategoryListViewController.h"
@interface CategoryListViewController ()<UITableViewDelegate, UITableViewDataSource, UIPageViewControllerDelegate, UIPageViewControllerDataSource>{

BOOL _isRelate;
}

@property(nonatomic, strong)UITableView *leftTableView;

@property(nonatomic, strong)UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *pageContentArray;
@end

@implementation CategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.pageViewController.view];
    
    UIViewController *initialViewController = [self viewControllerAtIndex:0];// 得到第一页
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO
                                     completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UIPageViewControllerDataSource

#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    
//    return [self viewControllerAtIndex:viewController.view.tag];
    NSUInteger index = viewController.view.tag;// [self indexOfViewController:viewController];
        if ((index == 0) || (index == NSNotFound)) {
            return nil;
        }
        index--;
        // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
        // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
        // 不用我们去操心每个ViewController的顺序问题
        return [self viewControllerAtIndex:index];
    
    
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    
//    return [self viewControllerAtIndex:viewController.view.tag];
    
    NSUInteger index = viewController.view.tag;// [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index++;
    if (index == [self.pageContentArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}


- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    UIViewController *c = [[UIViewController alloc]init];
    
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    
    [c.view setBackgroundColor:[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1]];
    
    [c.view setTag:index];
    
    return c;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 100;//[_contentImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark -  UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1000;
}


- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        _isRelate = NO;
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}


#pragma mark - getter

-(UITableView *)leftTableView{
    
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(self.view.bounds))];
        [_leftTableView setDelegate:self];
        [_leftTableView setDataSource:self];
    }
    
    return _leftTableView;
}

-(UIPageViewController *)pageViewController{
    
    if (_pageViewController == nil) {
        
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
        [self addChildViewController:_pageViewController];
        _pageViewController.dataSource = self;
        [_pageViewController.view setFrame:CGRectMake(80, 0, CGRectGetWidth(self.view.bounds) - 80, CGRectGetHeight(self.view.bounds))];
    }
    
    return _pageViewController;
}



- (NSArray *)pageContentArray {
    if (!_pageContentArray) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        for (int i = 1; i < 10; i++) {
            [arrayM addObject:[NSNumber numberWithInteger:i]];
        }
        _pageContentArray = [[NSArray alloc] initWithArray:arrayM];
        
    }
    return _pageContentArray;
}


@end
