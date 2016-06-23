//
//  ViewController.m
//  APPManage
//
//  Created by JonneyDai on 16/6/14.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppView.h"

#define  kScreenH  [UIScreen mainScreen].bounds.size.height
#define  kScreenW  [UIScreen mainScreen].bounds.size.width
#define  kAppViewH [AppView appView].bounds.size.height
#define  kAppViewW [AppView appView].bounds.size.width
#define  kTotalCol 3

@interface ViewController () <AppViewDelegate>
@property (nonatomic, strong) NSArray *appViews;


@end

@implementation ViewController

//懒加载
-(NSArray *)appViews{
    if (!_appViews) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"app" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayM = [[NSMutableArray alloc]initWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            AppInfo *appInfo = [AppInfo appInfoWithDict:dict];
            AppView *appView = [AppView appView];
            appView.appInfo = appInfo;
            appView.delegate = self;
            
            [arrayM addObject:appView];
        }
        _appViews = [arrayM copy];
    
    }
    return  _appViews;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat margin = (kScreenW - kTotalCol * kAppViewW)/(kTotalCol + 1);
    for (int i = 0; i < self.appViews.count; i++) {
        AppView *appView = self.appViews[i];
        int col = i % kTotalCol;
        int row = i / kTotalCol;
        
        CGFloat centerX = (margin + kAppViewW * 0.5) + (margin + kAppViewW) * col;
        CGFloat centerY = (margin + kAppViewH * 0.5) + (margin + kAppViewH) * row;
        
        appView.center = CGPointMake(centerX, centerY);
        [self.view addSubview:appView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
