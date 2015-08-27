//
//  ViewController.m
//  AutoLayoutDemo4
//
//  Created by 代隽杰 on 15/8/27.
//  Copyright (c) 2015年 代隽杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.translatesAutoresizingMaskIntoConstraints =NO;
    
    UIView *newView = [UIView new];
    newView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:newView];
    
    newView.translatesAutoresizingMaskIntoConstraints =NO;
    
    NSLayoutConstraint *constraint = nil;
    
    constraint = [NSLayoutConstraint constraintWithItem:newView
                                              attribute:NSLayoutAttributeLeading
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeLeading
                                             multiplier:1.0f
                                               constant:20];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:newView
                                              attribute:NSLayoutAttributeTrailing
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeTrailing
                                             multiplier:1.0f
                                               constant:-20];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:newView
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeTop
                                             multiplier:1.0f
                                               constant:20];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:newView
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1.0f
                                               constant:-20];
    [self.view addConstraint:constraint];
    
}

@end
