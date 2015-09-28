//
//  HypnosisterView.m
//  Hypnosister
//
//  Created by 代隽杰 on 15/9/25.
//  Copyright © 2015年 Gree. All rights reserved.
//

#import "HypnosisterView.h"

@implementation HypnosisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        //设置对象背景为透明
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = self.bounds;
    //根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    //根据视图宽和高中的较小值计算圆形的半径
    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    //以中心点为圆心、radius为半径、定义一个0到2π弧度的路径（整圆）
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    //设置线条宽度为10点
    path.lineWidth = 10;
    
    //设置线条颜色
    [[UIColor lightGrayColor]setStroke];
    
    //绘制路径
    [path stroke];
}




@end
