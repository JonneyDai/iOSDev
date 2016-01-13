//
//  ViewController.m
//  TextFieidTest
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

-(void) viewWillAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyBoardDidShow:(NSNotification *)notification{
    NSLog(@"打开键盘");
}

-(void) keyBoardDidHide:(NSNotification *)notification{
    NSLog(@"关闭键盘");
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
//        return NO;
    }
    return YES;
}


@end
