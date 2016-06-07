//
//  ViewController.m
//  GetLocalIPAddress
//
//  Created by 代隽杰 on 16/5/25.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import "IPAddress.h"

@interface ViewController ()

@end

@implementation ViewController
{
    IPAddress *myIp;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    myIp = [[IPAddress alloc]init];
    NSLog(@"IPAddress1 = %@",[myIp MyIPAddress]);

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"IPAddress2 = %@",myIp.MyIPAddress);

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
