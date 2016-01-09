//
//  ViewController.h
//  SwitchTest
//
//  Created by 代隽杰 on 15/11/20.
//  Copyright © 2015年 gree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;

@property (weak, nonatomic) IBOutlet UILabel *SliderValue;


-(IBAction)valueChanged:(id)sender;

-(IBAction)sliderValueChanged:(id)sender;

-(IBAction)touchDown:(id)sender;

@end

