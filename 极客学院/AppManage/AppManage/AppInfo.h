//
//  AppInfo.h
//  AppManage
//
//  Created by 代隽杰 on 16/6/23.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppInfo : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,strong,readonly) UIImage *image;


-(instancetype)initWithDict:(NSDictionary *)dic;

+(instancetype)appInfoWithDict:(NSDictionary *)dic;

@end
