//
//  ViewController.m
//  SwitchTest
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)valueChanged:(id)sender{
    UISwitch *witchSwitch = (UISwitch *) sender;
    BOOL setting = witchSwitch.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}



-(IBAction)sliderValueChanged:(id)sender{
    UISlider *slider = (UISlider *) sender;
    int step = (int) slider.value ;
    NSString *value = [NSString stringWithFormat: @"%d",step];
    self.SliderValue.text = value;
}

-(IBAction)touchDown:(id)sender{
    if (_leftSwitch.hidden == YES) {
        self.rightSwitch.hidden = NO;
        self.leftSwitch.hidden = NO;
    }else{
        self.rightSwitch.hidden = YES;
        self.leftSwitch.hidden = YES;
    }
}

@end
