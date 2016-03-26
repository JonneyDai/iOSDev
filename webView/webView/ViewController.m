//
//  ViewController.m
//  webView
//
//  Created by 代隽杰 on 15/11/30.
//  Copyright © 2015年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

-(IBAction)testLoadData:(id)sender
{

}
-(IBAction)testLoadHTMLString:(id)sender{

}

-(IBAction)testLoadRequest:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *resquest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:resquest];
    self.webView.delegate = self;
}

#pragma UIWebviewdelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicator stopAnimating];
    self.indicator.hidesWhenStopped = YES;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{

}





@end
