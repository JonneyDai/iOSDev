//
//  ViewController.m
//  addFoodDemo
//
//  Created by 代隽杰 on 16/8/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import "FoodInfoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FoodInfoView *foodInfoView = [[FoodInfoView alloc]init];
    [self.view addSubview:foodInfoView];
    FoodInfoView *foodInfoView2 = [[FoodInfoView alloc]initWithFrame:CGRectMake(50 + 5, 0, foodInfoView.frame.size.width, foodInfoView.frame.size.height)];
    [self.view addSubview:foodInfoView2];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
