//
//  ViewController.m
//  Review1
//
//  Created by 代隽杰 on 16/4/22.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import <systemconfiguration/captivenetwork.h>
#import <corefoundation/corefoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getCurrentWifiName];
    // Do any additional setup after loading the view, typically from a nib.
}

//获取WiFi的SSID
- (NSString *)getCurrentWifiName{
    NSString *wifiName = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
    }
    NSLog(@"wifiName:%@", wifiName);
    return wifiName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    //获取被点击按钮的标题
    NSString *title = [sender titleForState:UIControlStateNormal];
    NSString *plainText = [NSString stringWithFormat:@"%@ button pressed.",title];
//    _statusLabel.text = plainText;
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc]initWithString:plainText];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:_statusLabel.font.pointSize]};
    NSRange nameRange = [plainText rangeOfString:title];
    [styledText setAttributes:attributes range:nameRange];
    _statusLabel.attributedText = styledText;
    
}

@end
