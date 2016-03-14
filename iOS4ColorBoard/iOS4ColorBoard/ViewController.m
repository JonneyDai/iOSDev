//
//  ViewController.m
//  iOS4ColorBoard
//
//  Created by 代隽杰 on 16/3/14.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;

@property (weak, nonatomic) IBOutlet UISlider *greenSlider;

@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation ViewController

- (IBAction)dissmiss:(id)sender {
   
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)changeColor:(id)sender {
    float red = self.redSlider.value;
    float green = self.greenSlider.value;
    float blue = self.blueSlider.value;
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.view.backgroundColor = newColor;
    
}



@end
