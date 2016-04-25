//
//  ViewController.m
//  Review2
//
//  Created by 代隽杰 on 16/4/23.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UIButton *doSomethingButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sliderLabel.text = @"50";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 按下键盘的Done按键，隐藏键盘
 */
-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

/** 触摸任意地方，隐藏键盘
 @parameter
 */
-(IBAction)backgroundTap:(id)sender{
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

/** 获取滑动条的值并显示在旁边的label中
 @parameter sender指UISlider对象
 */
- (IBAction)sliderChanged:(UISlider *)sender {
    int progress = (int)lroundf(sender.value);  //获取slider的值
    self.sliderLabel.text = [NSString stringWithFormat:@"%d",progress];
}
/** 同时改变开关的值
 @parameter sender指UISwitch对象
 */
- (IBAction)switchChange:(UISwitch *)sender {
    BOOL setting = sender.isOn;   //获取开关的状态
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}
/** 控制分段控件在显示开关和按钮之间转换
 @parameter sender指UISegmentedControl对象
 */
- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
        self.doSomethingButton.hidden = YES;
    }else{
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.doSomethingButton.hidden = NO;
    }
}
/**
 @parameter senderz指UIButton对象
 */
- (IBAction)buttonPressed:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Are you sure"
                                                            delegate:self
                                                   cancelButtonTitle:@"No Way!"
                                              destructiveButtonTitle:@"Yes, I`m sure"
                                                   otherButtonTitles:nil];
    [actionSheet showInView:self.view];
    
}
#pragma mark -- ActionSheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        NSString *msg = nil;
        
        if ([self.nameField.text length] > 0) {
            msg = [NSString stringWithFormat:@"You can breath easy, %@ , everything went OK.",self.nameField.text];
        }else{
            msg = @"You can breath easy, everything is OK.";
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Something was done"
                                                       message:msg
                                                      delegate:nil
                                             cancelButtonTitle:@"Phew!"
                                             otherButtonTitles:nil];
        [alert show];
        
    }

}
@end
