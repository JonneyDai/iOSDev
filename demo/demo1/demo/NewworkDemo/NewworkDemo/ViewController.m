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

    //UDP广播BL
    bl = [[VirtualDeviceForBroadcastBL alloc] init];
    [bl creatUdpWithIpAndPortContext:nil];
    [bl broadcast];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
