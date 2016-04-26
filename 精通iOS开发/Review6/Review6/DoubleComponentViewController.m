//
//  DoubleComponentViewController.m
//  Review6
//
//  Created by 代隽杰 on 16/4/26.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "DoubleComponentViewController.h"

#define kFillingComponent 0
#define kBreadComponent 1


@interface DoubleComponentViewController ()

@property (weak, nonatomic  ) IBOutlet UIPickerView *doublePicker;
@property (strong, nonatomic) NSArray      *fillingTypes;
@property (strong, nonatomic) NSArray      *breadTypes;
@end

@implementation DoubleComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fillingTypes = @[@"Ham",@"Turkey",@"Peanut",@"Tuna Salad",@"Chicken Salad"];
    self.breadTypes   = @[@"White",@"Whole Wheat",@"Rye",@"Sourdough"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSInteger fillingRow = [self.doublePicker selectedRowInComponent:kFillingComponent];
    NSInteger breadRow   = [self.doublePicker selectedRowInComponent:kBreadComponent];

    NSString *filling    = self.fillingTypes[fillingRow];
    NSString *bread      = self.breadTypes[breadRow];
    NSString *message    = [[NSString alloc]initWithFormat:@"You %@ on %@ bread will be right up.",filling,bread];
    UIAlertView *alert   = [[UIAlertView alloc]initWithTitle:@"Thank you for your order"
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"cancel"
                                         otherButtonTitles: nil];
    [alert show];
    
}

#pragma mark - Picker Data Source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == kBreadComponent) {
        return  [self.breadTypes count];
    }else {
        return [self.fillingTypes count];
    }
}

#pragma mark - Picker Delegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == kBreadComponent) {
        return  self.breadTypes[row];
    }else {
        return self.fillingTypes[row];
    }
}

@end
