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
@property (nonatomic ,strong) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSrollView];
    [self initPageCtrl];
//    [self addTimer];
    
}
//创建ScrollView
-(void) initSrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollY, kScreenWidth, kScreenHeight - scrollY)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * kImgCount, kScreenHeight - scrollY);
    for (int i = 0; i <= kImgCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i *kScreenWidth, scrollY, kScreenWidth, kScreenHeight - scrollY)];
        UIImage *myImage = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d.jpg",i + 1] ];
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
////添加定时器
//-(void) addTimer{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
//}
//
////跳动到下一页
//-(void)nextPage{
//    NSInteger page = self.pageCtrl.currentPage;
//    page++;
//    if (page == kImgCount) {
//        page = 0;
//    }
//    CGPoint point = CGPointMake(kScreenWidth * page, 0);
//    [self.scrollView setContentOffset:point animated:YES]; //设置偏移量
//}
//
////停止定时器
//-(void) removeTimer{
//    [self.timer invalidate];
//    self.timer = nil;
//}

#pragma mark ScrollViewDelegate
//页面滑动的时候更新当前页码
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / kScreenWidth + 0.5;
    self.pageCtrl.currentPage = page;
    
}

////当视图将要拖动的时候
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self removeTimer];
//}
////当视图停止拖拽的时候
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self addTimer];
//    });
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
