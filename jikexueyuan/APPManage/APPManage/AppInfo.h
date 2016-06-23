//
//  AppInfo.h
//  APPManage
//
//  Created by JonneyDai on 16/6/14.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppInfo : NSObject
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *icon;
@property (nonatomic ,strong ,readonly) UIImage *image;

-(instancetype) initWithDict:(NSDictionary *) dict;

+(instancetype) appInfoWithDict:(NSDictionary *) dict;


@end
