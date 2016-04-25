//
//  ViewController.m
//  Review4
//
//  Created by 代隽杰 on 16/4/24.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton1;
@property (weak, nonatomic) IBOutlet UIButton *actionButton2;
@property (weak, nonatomic) IBOutlet UIButton *actionButton3;
@property (weak, nonatomic) IBOutlet UIButton *actionButton4;

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


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self doLayoutForOrientation:toInterfaceOrientation];
}

-(void)doLayoutForOrientation:(UIInterfaceOrientation) orientation{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self layoutPortrait];
    }else{
        [self layoutLandscape];
    }
}

-(void)layoutPortrait{

}

-(void)layoutLandscape{

}

@end
