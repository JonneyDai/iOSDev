//
//  DZDeleteButton.h
//  BtnShakeDemo
//
//  Created by 代隽杰 on 16/7/27.
//  Copyright © 2016年 gree. All rights reserved.
//


// .h文件 只有一个代理
#import <UIKit/UIKit.h>

@class DZDeleteButton;
@protocol DZDeleteButtonDelegate <NSObject>
@optional
- (void)deleteButtonRemoveSelf:(DZDeleteButton *)button;
@end

@interface DZDeleteButton : UIButton
@property (nonatomic, weak) id<DZDeleteButtonDelegate> delegate;

@end
