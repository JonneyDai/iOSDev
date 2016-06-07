//
//  ViewController.m
//  UserDefaultTest
//
//  Created by 代隽杰 on 16/6/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import "studentInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //在NSUserDefault中存储可实现对象
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = @"admin";
    NSString *password = @"12345678";
    
    [myDefault setObject:name forKey:@"name"];
    [myDefault setObject:password forKey:@"password"];
    
    NSLog(@"myDefault name is %@ password is %@",[myDefault objectForKey:@"name"],[myDefault objectForKey:@"password"]);
    
    //在NSUserDefault中存储自定义对象
    studentInfo *student = [[studentInfo alloc]init];
    student.name = @"小明";
    student.studentNumber = @"001";
    student.sex = @"nan";
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:student];
    [myDefault setObject:data forKey:@"oneStuent"];
    
    
    
    studentInfo *student2 = [[studentInfo alloc]init];
    student2 = [NSKeyedUnarchiver unarchiveObjectWithData:[myDefault objectForKey:@"oneStuent"]];
    NSLog(@"oneStuent is %@",student2.name);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
