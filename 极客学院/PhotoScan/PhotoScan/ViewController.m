//
//  ViewController.m
//  PhotoScan
//
//  Created by 代隽杰 on 16/6/22.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,assign) int index;
@property (nonatomic,strong) NSArray *imageDicts;

@end

@implementation ViewController
//懒加载图片数组，在该数组存放字典对象，使用plist文件初始化。保证该数组只创建一次
-(NSArray *)imageDicts{
    if (!_imageDicts) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"imageDate.plist" ofType:nil];
        _imageDicts = [NSArray arrayWithContentsOfFile:path];
    }
    return _imageDicts;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftBtnOnClick:(UIButton *)sender {
    self.index--;
    [self btnClickChange];
    
}

- (IBAction)rightBtnOnClick:(UIButton *)sender {
    self.index++;
    [self btnClickChange];
}

//提取出每次点击按钮都需要改变的量，放在该方法中
-(void)btnClickChange{
    self.topLabel.text = [NSString stringWithFormat:@"%d/%d",(self.index + 1),(self.imageDicts.count)];
    self.detailLabel.text = self.imageDicts[self.index][@"description"];
    self.imageView.image = [UIImage imageNamed:self.imageDicts[self.index][@"name"]];
    self.leftBtn.enabled = (self.index != 0);
    self.rightBtn.enabled = (self.index != 4);
}

@end
