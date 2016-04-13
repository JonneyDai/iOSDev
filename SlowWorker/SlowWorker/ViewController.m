//
//  ViewController.m
//  SlowWorker
//
//  Created by 代隽杰 on 16/4/9.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ViewController

-(NSString *) fetchSomethingFromServer
{
    [NSThread sleepForTimeInterval:1];
    return @"Hi there";
}

-(NSString *) processData:(NSString *) data
{
    [NSThread sleepForTimeInterval:2];
    return [data uppercaseString];
}

-(NSString *) calculateFirstResult:(NSString *) data
{
    [NSThread sleepForTimeInterval:3];
    return [NSString stringWithFormat:@"Number of chars: %d",[data length]];
}

-(NSString *) calculateSecondResult:(NSString *) data
{
    [NSThread sleepForTimeInterval:4];
    return  [data stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
}

-(IBAction)doWork:(id)sender
{
    NSDate *starTime = [NSDate date];
    self.startButton.enabled = NO;
    self.startButton.alpha = 0.5f;
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
    NSString *fetchedData = [self fetchSomethingFromServer];
    NSString *processedData = [self processData:fetchedData];
    __block NSString *firstResult;
    __block NSString *secondResult;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        firstResult = [self calculateFirstResult:processedData];
            });
    dispatch_group_async(group, queue, ^{
        secondResult = [self calculateSecondResult:processedData];
            });
    dispatch_group_notify(group, queue, ^{
    NSString *resultsSummary = [NSString stringWithFormat:@"First: [%@]\nSecond: [%@]",firstResult,secondResult];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.resultsTextView.text = resultsSummary;
        self.startButton.enabled = YES;
        [self.spinner stopAnimating];
            });
    NSDate *endTime = [NSDate date];
        NSLog(@"Completed in %f seconds",[endTime timeIntervalSinceDate:starTime]);
        });
    });

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
