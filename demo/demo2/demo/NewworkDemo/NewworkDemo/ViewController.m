//
//  ViewController.m
//  NewworkDemo
//
//  Created by gree's apple on 24/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "ViewController.h"
#import "VirtualDeviceForBroadcastBL.h"

@interface ViewController ()
{
    VirtualDeviceForBroadcastBL *bl;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
/***************************/
/*  1、HEX近程广播开始       */
/*  自动建立TCP并完成数据请求  */
/***************************/
    //UDP广播BL
    bl = [[VirtualDeviceForBroadcastBL alloc] init];
    [bl creatUdpWithIpAndPortContext:nil];
    [bl broadcast:^{
        NSLog(@"Client broadcast Success");
    } fail:^{
        NSLog(@"Client broadcast Fail");
    }];
    
/******************************以上为0X7E7E流程模式********************/
/******************************以下为JSON流程模式**********************/
    
/*********************/
/* 1、Json近程广播开始 */
/*********************/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ReceiverNotification:(NSNotification *)NSNotification
{
    
}

@end
