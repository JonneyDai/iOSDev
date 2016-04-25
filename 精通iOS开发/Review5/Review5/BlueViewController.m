//
//  BlueViewController.m
//  Review5
//
//  Created by 代隽杰 on 16/4/24.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)blueButtonPressed:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Blue view button pressed"
                                                   message:@"You pressed the button on the blue view"
                                                  delegate:nil
                                         cancelButtonTitle:@"Yep, I did." otherButtonTitles:nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
