//
//  CustomView.h
//  DelegateTest
//
//  Created by 代隽杰 on 16/5/10.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomView;
@protocol CustomViewDelegate <NSObject>
@optional
-(void) CustomView:(CustomView *) customView didClickButton:(UIButton *) button;

@end

@interface CustomView : UIView

@property (nonatomic, assign) id <CustomViewDelegate> delegate;

@end
