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

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UIPageControl *pageCtrl;
@property (nonatomic ,strong) 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSrollView];
    [self initPageCtrl];
    
}
//创建ScrollView
-(void) initSrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollY, kScreenWidth, kScreenHeight - scrollY)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * kImgCount, kScreenHeight - scrollY);
    for (int i = 0; i <= kImgCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i *kScreenWidth, scrollY, kScreenWidth, kScreenHeight - scrollY)];
        UIImage *myImage = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d",i + 1] ];
        imageView.image = myImage;
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview: self.scrollView];
    
}
//创建UIPageCtrl
-(void) initPageCtrl{
    self.pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth - pageCtrlWidth)/2, kScreenHeight - scrollY,  pageCtrlWidth, scrollY)];
    self.pageCtrl.numberOfPages = kImgCount;
    self.pageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageCtrl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view insertSubview:self.pageCtrl aboveSubview:self.scrollView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
