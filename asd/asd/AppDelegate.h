//
//  AppDelegate.h
//  asd
//
//  Created by WangShuChao on 2017/10/29.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

