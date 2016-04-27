//
//  CustomPickerViewController.m
//  Review6
//
//  Created by 代隽杰 on 16/4/26.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "CustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) NSArray *images;
@end

@implementation CustomPickerViewController
{
    SystemSoundID winSoundID;
    SystemSoundID crunchSoundID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = @[[UIImage imageNamed:@"apple"],
                    [UIImage imageNamed:@"bar"],
                    [UIImage imageNamed:@"cherry"],
                    [UIImage imageNamed:@"crown"],
                    [UIImage imageNamed:@"lemon"],
                    [UIImage imageNamed:@"seven"]];
    srandom(time(NULL));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSLog(@"buttonPressed");
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for (int i = 0; i < 5; i++) {
        int newValue = random() % [self.images count];
        
        if (newValue == lastVal) {
            numInRow++;
        } else {
            numInRow = 1;
        }
        lastVal = newValue;
        
        [self.customPicker selectRow:newValue inComponent:i animated:YES];
        [self.customPicker reloadComponent:i];
        if (numInRow >= 3) {
            win = YES;
        }
    }
//    if (win) {
//        self.winLabel.text = @"Winning!";
//        NSLog(@"%@",self.winLabel.text);
//    }else{
//        self.winLabel.text = @"";
//    }
    
    if (crunchSoundID == 0) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"crunch" ofType:@"wav"];
        NSURL *soundURL = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &crunchSoundID);
    }
    AudioServicesPlaySystemSound(crunchSoundID);
    
    if (win) {
        [self performSelector:@selector(playWinSound) withObject:nil afterDelay:.5];
    }else {
        [self performSelector:@selector(showButton) withObject:nil afterDelay:0.5];
    }
    self.button.hidden = YES;
    self.winLabel.text = @"";
}

-(void) showButton{
    self.button.hidden = NO;
}

-(void) playWinSound{
    if (winSoundID == 0) {
        NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"win" withExtension:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &winSoundID);
    }
    AudioServicesPlaySystemSound(winSoundID);
    self.winLabel.text = @"Winning";
    [self performSelector:@selector(showButton) withObject:nil afterDelay:1.5];
}


#pragma mark - UIPickerView DataShource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.images count];
}

#pragma mark - UIPickerView Delegate
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIImage *image = self.images[row];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    return imageView;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

@end
