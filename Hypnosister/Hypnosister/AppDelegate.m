//
//  AppDelegate.m
//  Hypnosister
//
//  Created by 代隽杰 on 15/9/25.
//  Copyright © 2015年 Gree. All rights reserved.
//

#import "AppDelegate.h"
#import "HypnosisterView.h"
#import "ViewController.h"   //主界面视图控制器

@interface AppDelegate () <UIScrollViewDelegate>

//@property (nonatomic) HypnosisterView *hypnosisView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建UIwindow
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
//    bigRect.size.height *= 2.0;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:screenRect];
    [scrollView setPagingEnabled:YES];
    scrollView.delegate = self;
    
    [self.window addSubview:scrollView];
    
    HypnosisterView *hypnosisView = [[HypnosisterView alloc]initWithFrame:screenRect];
    [scrollView addSubview:hypnosisView];
    
    screenRect.origin.x += screenRect.size.width;
    HypnosisterView *anotherView = [[HypnosisterView alloc]initWithFrame:screenRect];
    [scrollView addSubview:anotherView];
    
    scrollView.contentSize = bigRect.size;
    
    //添加根视图控制器，否则提示异常，不可正常显示。
    ViewController *hvc = [[ViewController alloc]init];
    self.window.rootViewController = hvc;
    
    //添加第一个子视图
//    CGRect firstFrame = self.window.bounds;//充满整个屏幕
//    HypnosisterView *firstView = [[HypnosisterView alloc]initWithFrame:firstFrame];
    
//    [self.window addSubview: firstView];
    
//    //第二个子视图
//    CGRect secondFrame = CGRectMake(20, 30, 50, 50);
//    HypnosisterView *secondView = [[HypnosisterView alloc]initWithFrame:secondFrame];
//    secondView.backgroundColor = [UIColor blueColor];
//    //[self.window addSubview:secondView];//将视图添加到UIWindow
//    [firstView addSubview: secondView];//将视图添加到firstView；
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

//-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return ;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
