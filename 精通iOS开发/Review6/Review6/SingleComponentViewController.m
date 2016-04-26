//
//  SingleComponentViewController.m
//  Review6
//
//  Created by 代隽杰 on 16/4/26.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "SingleComponentViewController.h"

@interface SingleComponentViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *singlePicker;
@property (strong, nonatomic) NSArray *characterNames;

@end

@implementation SingleComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.characterNames = @[@"one",@"two",@"three",@"four",@"five"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    NSInteger row = [self.singlePicker selectedRowInComponent:0];
    NSString *selected = self.characterNames[row];
    NSString *title = [[NSString alloc]initWithFormat:@"You selected %@",selected];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:@"Thank you" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.characterNames[row];
}


#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.characterNames count];
}

@end
