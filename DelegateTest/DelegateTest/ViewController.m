//
//  ViewController.m
//  DelegateTest
//
//  Created by 代隽杰 on 16/5/10.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CustomViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomView *myCustomView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    myCustomView.delegate = self;
    [self.view addSubview:myCustomView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(click:) name:@"buttonClick" object:nil];
}
-(void) click:(NSNotification *) notification{
    NSLog(@"Key%@",notification.userInfo[@"buttonKey"]);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"buttonClick" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CustomView:(CustomView *)customView didClickButton:(UIButton *)button{
    NSLog( @"hello delegate button");
}

@end
