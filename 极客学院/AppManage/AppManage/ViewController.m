//
//  ViewController.m
//  AppManage
//
//  Created by 代隽杰 on 16/6/8.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppView.h"

@interface ViewController () <AppViewDelegate>

@property (nonatomic ,strong) NSArray *appViews;


@end

@implementation ViewController

//懒加载
-(NSArray *)appViews{
    if (!_appViews) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"app" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            AppInfo *appInfo = [AppInfo appInfoWithDict:dict];
            
            AppView *appView = [AppView initWithAppView];
            [appView setAppInfo:appInfo];
            appView.delegate = self;
            
            [arrayM addObject:appView];
        }
        _appViews = [arrayM copy];
        
    }
    return _appViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
