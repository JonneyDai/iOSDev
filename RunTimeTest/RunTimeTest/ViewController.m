//
//  ViewController.m
//  RunTimeTest
//
//  Created by 代隽杰 on 16/5/9.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(doSomething:)];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(doSomething:)) {
        NSLog(@"add class here");
        return YES;
    }
    return  [super resolveInstanceMethod:sel];
    
}
@end
