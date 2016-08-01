//
//  ViewController.m
//  BtnShakeDemo
//
//  Created by 代隽杰 on 16/7/27.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import "DZDeleteButton.h"

@interface ViewController ()<DZDeleteButtonDelegate>

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    DZDeleteButton *button = [[DZDeleteButton alloc] init];
    [button setImage:[UIImage imageNamed:@"bj"] forState:UIControlStateNormal];
//    [button setTitle:@"百思" forState:UIControlStateNormal];
    button.delegate = self;
    button.frame = CGRectMake(20, 20, 60, 80);
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)btnClick {
    NSLog(@"点击button");
}

- (void)deleteButtonRemoveSelf:(DZDeleteButton *)button {
    NSLog(@"已经删除，要做什么事");
}

@end
