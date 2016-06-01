//
//  CustomView.m
//  DelegateTest
//
//  Created by 代隽杰 on 16/5/10.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        UIButton *myButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        myButton.backgroundColor = [UIColor redColor];
        [myButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:myButton];
    }
    return self;
}
-(void) click:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(CustomView:didClickButton:)]) {
        [self.delegate CustomView:self didClickButton:sender];
    }
    NSDictionary *dic = @{@"buttonKey": @"click"};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonClick" object:self userInfo:dic];
    
}


@end
