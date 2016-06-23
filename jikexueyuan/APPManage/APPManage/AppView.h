//
//  AppView.h
//  APPManage
//
//  Created by JonneyDai on 16/6/14.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppInfo;

@protocol AppViewDelegate <NSObject>

@optional
-(void) downloadClickWithBtn:(UIButton *)btn;

@end

@interface AppView : UIView

@property (nonatomic, strong) AppInfo *appInfo;
@property (nonatomic, retain) id <AppViewDelegate> delegate;

+(instancetype) appView;


@end
