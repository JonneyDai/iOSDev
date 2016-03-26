//
//  AppDelegate.m
//  adTest
//
//  Created by 代隽杰 on 16/3/25.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIViewController *vc = [[UIViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    if ([[UIDevice currentDevice].systemVersion doubleValue] == 7.0) {
        [navi.navigationBar setBarTintColor:[UIColor clearColor]];
    }else{
        [navi.navigationBar setTintColor:[UIColor clearColor]];
    }
//    self.rootNavi = navi;
    self.window.rootViewController = navi;
    
    self.adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.adImageView setImage: [UIImage imageNamed:@"adTest.png"]];
    [self.window addSubview: self.adImageView];
    [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:3];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void) removeAdImageView{
        [UIView animateWithDuration:0.3f animations:^{
        self.adImageView.transform = CGAffineTransformMakeScale(0.5f,0.5f);
        self.adImageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.adImageView removeFromSuperview];
        self.window.rootViewController = self.rootNavi;
    }];
}


- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}
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
