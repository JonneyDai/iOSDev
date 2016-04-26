//
//  DatePickerViewController.m
//  Review6
//
//  Created by 代隽杰 on 16/4/26.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *now = [NSDate date];  //获取当前日期
    [self.datePicker setDate:now animated:NO];  //设置日期选择器为当前日期
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSDate *selected = [self.datePicker date];
    NSString *message = [[NSString alloc]initWithFormat:@"The date and time you seleted is %@ ",selected];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Date and Time Selected" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
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
