//
//  WebViewController.m
//  MNerdfeed
//
//  Created by 代隽杰 on 16/1/4.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(void) loadView
{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

-(void)setURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    barButtonItem.title = @"Courses";
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    if (barButtonItem == self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = nil;
    }
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
