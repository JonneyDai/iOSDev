//
//  ViewController.m
//  CallTest
//
//  Created by JonneyDai on 16/7/4.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)callMeBtnClick:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"tel://18575694013"];
    [[UIApplication sharedApplication]openURL:url];
    
}

- (IBAction)sendMsgBtnClick:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"sms://18575694013"];
    [[UIApplication sharedApplication]openURL:url];
    
    
}

- (IBAction)CallWorkBtnClick:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"tel://13828783943"];
    [[UIApplication sharedApplication]openURL:url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
