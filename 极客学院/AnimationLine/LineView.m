//
//  LineView.m
//  AnimationLine
//
//  Created by JonneyDai on 16/6/6.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import "LineView.h"

@interface LineView ()
@property (nonatomic) CGRect rect;

@end

@implementation LineView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rect = frame;
    }
    return self;
}

-(void) show{
    
    CGRect newRect = CGRectMake(self.rect.origin.x + self.offsetX,
                                self.rect.origin.y,
                                self.rect.size.width,
                                self.rect.size.height);
    
    [UIView animateWithDuration:1 animations:^{
        self.frame = newRect;
    }];

}
-(void) hide{
    CGRect newRect = CGRectMake(self.rect.origin.x + self.offsetX + self.offsetX,
                                self.rect.origin.y,
                                self.rect.size.width,
                                self.rect.size.height);
    
    [UIView animateWithDuration:1 animations:^{
        self.frame = newRect;
        self.alpha = 0.f;
    }];

}

@end
