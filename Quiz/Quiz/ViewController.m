//
//  ViewController.m
//  Quiz
//
//  Created by 代隽杰 on 15/9/10.
//  Copyright (c) 2015年 代隽杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic ,weak) IBOutlet UILabel *questionLabel;
@property (nonatomic ,weak) IBOutlet UILabel *answerLabel;

@property (nonatomic ) int currentQuestionIndex;
@property (nonatomic ,copy) NSArray *questions;
@property (nonatomic ,copy) NSArray *answers;

@end

@implementation ViewController

-(IBAction)showQuestion:(id)sender{
    //进入下一个问题
    self.currentQuestionIndex++;
    //是否回答完所有问题？
    if (self.currentQuestionIndex == [self.questions count]) {
    //回到第一个问题
        self.currentQuestionIndex = 0;
    }
    //根据正在回答的问题序号从数组中取出问题字符串
    NSString *question = self.questions[self.currentQuestionIndex];
    
    //将问题字符串显示在标签上
    self.questionLabel.text = question;
    
    //重置答案字符串
    self.answerLabel.text =@"???";
    
}

-(IBAction)showAnswer:(id)sender{
    //当前问题的答案是什么
    NSString *answer = self.answers[self.currentQuestionIndex];
    //在答案标签上显示相应的答案
    self.answerLabel.text = answer;
    
}

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    //调用父类实现的初始化方法
    self = [super initWithNibName:@"ViewController"bundle:nil];
    
    //创建question和answer数组
    if (self) {
        self.questions = @[@"From what is cognac made?",
                           @"What is 7 + 7?",
                           @"What is the capital of Vermont?"];
        
        self.answers = @[@"Grapes",
                         @"14",
                         @"Monpelier"];
    }
    //返回新对象的地址
    return  self;
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
