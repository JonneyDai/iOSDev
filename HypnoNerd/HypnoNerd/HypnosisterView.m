//
//  HypnosisterView.m
//  Hypnosister
//
//  Created by 代隽杰 on 15/9/25.
//  Copyright © 2015年 Gree. All rights reserved.
//

#import "HypnosisterView.h"

@interface HypnosisterView ()

@property (strong , nonatomic) UIColor *circleColor;

@end

@implementation HypnosisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置对象背景为透明
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    //根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
//    //根据视图宽和高中的较小值计算圆形的半径
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    //设置对角线为直径
    float maxRadius = hypotf(bounds.size.width, bounds.size.height)/2.0;
    
    //以中心点为圆心、radius为半径、定义一个0到2π弧度的路径（整圆）
    UIBezierPath *path = [[UIBezierPath alloc]init];
//绘制一个圆形的路径
//    [path addArcWithCenter:center
//                    radius:radius
//                startAngle:0.0
//                  endAngle:M_PI * 2.0
//                 clockwise:YES];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius  //半径为currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    //设置线条宽度为10点
    path.lineWidth = 10;
    
    //设置线条颜色
    [self.circleColor setStroke];
    
    //绘制路径
    [path stroke];
}

-(void) setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}
//视图被触摸时会受到该消息
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@ was touched",self);
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    self.circleColor = randomColor;
    
}


@end
