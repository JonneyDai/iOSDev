//
//  DrawView.m
//  TouchTracker
//
//  Created by 代隽杰 on 16/1/8.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "DrawView.h"
#import "Line.h"

@interface DrawView() <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, weak) Line *selectedLine;

@end

@implementation DrawView

////静态分析器测试代码
//-(int)numberOfLines
//{
//    int count = 0;
//    if (self.linesInProgress && self.finishedLines) {
//        count = [self.linesInProgress count] + [self.finishedLines count];
//    }
//    return count;
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc]init];
        self.finishedLines = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        //双击手势
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.delaysTouchesBegan = YES;
        doubleTapRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTapRecognizer];
        //单击手势
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        //长按手势
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        //拖动手势
        self.moveRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
        
    }
    return self;
}

//处理双击事件
-(void) doubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Recognized double tap.");
    
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

//处理单击事件
-(void) tap:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Recogenized tap.");
    CGPoint point = [gestureRecognizer locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        //使视图成为UIMenuItem动作消息的目标
        [self becomeFirstResponder];
        //获取UIMenucontroller对象
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        //创建一个新的标题为Delete的UIMenuItem对象
        UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];

    }else{
        [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
    
}

//处理长按事件
-(void) longPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gestureRecognizer locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

//处理拖动事件
-(void) moveLine:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (!self.selectedLine) {
        return;
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:self];
        
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        [self setNeedsDisplay];
        [gestureRecognizer setTranslation:CGPointZero inView:self];
    }
}

//画线
-(void) strokeLine:(Line *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
    
}

- (void)drawRect:(CGRect)rect
{
    //用黑色绘制已经完成的线条
    [[UIColor blackColor] set];
    for (Line *line in self.finishedLines) {
        [self strokeLine:line];
    }
    [[UIColor redColor]set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    if (self.selectedLine) {
        [[UIColor greenColor]set];
        [self strokeLine:self.selectedLine];
    }
    
//    //性能测试中提高CPU占用量代码
//    float f = 0.0;
//    for (int i = 0; i < 1000000; i++) {
//        f = f + sin(sin(sin(time(NULL) + i)));
//    }
//    NSLog(@"f = %f",f);
    
}
//
-(Line *)lineAtPoint:(CGPoint)p
{
    for (Line *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        //检查线条的若干点
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            //如果线条的某个点和p的距离在20点以内，就返回相应的Line对象
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    //如果没找到符合条件的线条，就返回nil
    return nil;
}

-(void) deleteLine:(id)sender
{
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

#pragma mark - UIResponder方法

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //向控制台输出日志，查看触摸事件发生顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        Line *line = [[Line alloc]init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //向控制台输出日志，查看触摸事件发生顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
  
    [self setNeedsDisplay];
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //向控制台输出日志，查看触摸事件发生顺序
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

@end
