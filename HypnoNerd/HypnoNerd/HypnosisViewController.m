//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by 代隽杰 on 16/1/4.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisterView.h"

@interface HypnosisViewController () <UITextFieldDelegate>

@end

@implementation HypnosisViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        
        UIImage *i = [UIImage imageNamed:@"Hypno"];
        self.tabBarItem.image = i;
        
    }
    return  self;

}

-(void) drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc]init];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = message;
        
        [messageLabel sizeToFit];
        
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview: messageLabel];
        
        //添加运动效果
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x"
                                                                      type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y"
                                                                      type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"HypnosisViewController loaded its view.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadView
{
    HypnosisterView *backgroundView = [[HypnosisterView alloc]init];
    
    //在Hypno视图中添加textField
    CGRect textFieldRect = CGRectMake(40, 70, 240, 40);
    UITextField *textField = [[UITextField alloc]initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    
    [backgroundView addSubview:textField];
    
    self.view = backgroundView;

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
//    NSLog(@"%@",textField.text);
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
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
