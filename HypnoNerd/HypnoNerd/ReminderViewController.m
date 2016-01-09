//
//  ReminderViewController.m
//  HypnoNerd
//
//  Created by 代隽杰 on 16/1/4.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation ReminderViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Reminder";
        
        UIImage *i = [UIImage imageNamed:@"Time"];
        tbi.image = i;
        
    }
    return  self;
    
}

-(IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm +0800"];//修改时区为东8区
    
    NSString *selectedDate = [dateFormatter stringFromDate:date];
    
    NSLog(@"Setting a remingder for %@",selectedDate);
    
    UILocalNotification *note = [[UILocalNotification alloc]init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:note];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ReminderViewController loaded its view.");
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
