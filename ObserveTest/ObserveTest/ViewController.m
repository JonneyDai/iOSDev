//
//  ViewController.m
//  ObserveTest
//
//  Created by 代隽杰 on 15/11/19.
//  Copyright © 2015年 gree. All rights reserved.
//

#import "ViewController.h"
#import "ConcerteSubject.h"
#import "ConcreteObserver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ConcerteSubject* subject = [ConcerteSubject shareConcertSubject];
    [subject notifyObservers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
