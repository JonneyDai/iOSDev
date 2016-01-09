//
//  ViewController.m
//  Unit4
//
//  Created by 代隽杰 on 15/11/20.
//  Copyright © 2015年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)onClick:(id)sender{
    self.Label1.text = @"Hello World";
}
@end
