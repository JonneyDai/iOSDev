//
//  ViewController.m
//  Persistence
//
//  Created by 代隽杰 on 16/4/8.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic , strong) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        for (int i = 0; i < 4; i++) {
            UITextField *theField = self.lineFields[i];
            theField.text = array[i];
        }
    }
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(applicationWillResignActive:)
                                                name:UIApplicationWillResignActiveNotification
                                              object:app];
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    NSString *filePath = [self dataFilePath];
    NSArray *array = [self.lineFields valueForKey:@"text"];
    [array writeToFile:filePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
