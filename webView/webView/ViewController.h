//
//  ViewController.h
//  webView
//
//  Created by 代隽杰 on 15/11/30.
//  Copyright © 2015年 gree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,weak) IBOutlet UIWebView * webView;

-(IBAction)testLoadHTMLString:(id)sender;

-(IBAction)testLoadData:(id)sender;

-(IBAction)testLoadRequest:(id)sender;

@end

