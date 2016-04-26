//
//  ViewController.m
//  Review5
//
//  Created by 代隽杰 on 16/4/24.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

@interface ViewController ()

@property (nonatomic, strong) YellowViewController *yellowViewController;
@property (nonatomic, strong) BlueViewController *blueViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载完视图后，执行其他的额外设置
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    [self.view insertSubview:self.blueViewController.view atIndex:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //释放没有用到的缓存的数据和图片等
    if (!self.blueViewController.view.superview) {
        self.blueViewController = nil;
    }else{
        self.yellowViewController = nil;
    }
}

-(IBAction)switchViews:(id)sender{
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //如果该视图没有父视图，则释放它
    if (!self.yellowViewController.view.superview) {
        if (!self.yellowViewController) {
            self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Yellow"];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.blueViewController.view removeFromSuperview];
        [self.view insertSubview:self.yellowViewController.view atIndex:0];
    }else{
        if (!self.blueViewController) {
            self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.yellowViewController.view removeFromSuperview];
        [self.view insertSubview:self.blueViewController.view atIndex:0];
    }
    [UIView commitAnimations];
}

@end
