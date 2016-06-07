//
//  ViewController.m
//  AnimationLine
//
//  Created by JonneyDai on 16/6/6.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"

@interface ViewController ()
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) LineView *lineViewNew;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 100, 3)];
    self.lineView.backgroundColor = [UIColor blackColor];
    self.lineView.alpha = 0.f;
    [self.view addSubview:self.lineView];
    
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.lineView.alpha = 1.f;
        self.lineView.frame = CGRectMake(10 + 50, 100, 100, 3);
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:1 delay:6 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.lineView.alpha = 0.f;
        self.lineView.frame = CGRectMake(10 + 50 * 2, 100, 100, 3);
    } completion:^(BOOL finished) {
        
    }];
    
    self.lineViewNew = [[LineView alloc]initWithFrame:CGRectMake(10, 200, 100, 3)];
    self.lineViewNew.offsetX = 50.f;
    self.lineViewNew.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.lineViewNew];
    [self.lineViewNew show];
    [self performSelector:@selector(executeAfterDelay) withObject:nil afterDelay:6];
    
}

-(void) executeAfterDelay{
    [self.lineViewNew hide];
}

@end
