//
//  LineView.h
//  AnimationLine
//
//  Created by JonneyDai on 16/6/6.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView

@property (nonatomic) CGFloat offsetX;

//显示动画
-(void) show;

//隐藏动画
-(void) hide;

@end
