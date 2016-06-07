//
//  ViewController.m
//  HuoYingScrollerView
//
//  Created by 代隽杰 on 16/6/7.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#define  kScreenWidth [UIScreen mainScreen].bounds.size.width
#define  kScreenHeight [UIScreen mainScreen].bounds.size.height
CGFloat kImgCount = 10;
CGFloat scrollY = 20;
CGFloat pageCtrlWidth = 200;

@interface ViewController ()
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UIPageControl *pageCtrl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSrollView];
}

-(void) initSrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollY, kScreenWidth, kScreenHeight)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
