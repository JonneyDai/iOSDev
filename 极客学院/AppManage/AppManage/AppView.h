//
//  AppView.h
//  AppManage
//
//  Created by 代隽杰 on 16/6/23.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppInfo;

@protocol AppViewDelegate <NSObject>

@optional
-(void)downloadClickWithBtn:(UIButton *)btn;

@end

@interface AppView : UIView

@property(nonatomic, strong) AppInfo *appInfo;
@property (nonatomic,assign) id<AppViewDelegate> delegate;

+(instancetype)initWithAppView;


@end
