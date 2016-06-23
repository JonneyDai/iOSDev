//
//  AppInfo.m
//  AppManage
//
//  Created by 代隽杰 on 16/6/23.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "AppInfo.h"


@implementation AppInfo
{
    UIImage *_image;
}

-(instancetype)initWithDict:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}


+(instancetype)appInfoWithDict:(NSDictionary *)dic{
    
    return [[self alloc]initWithDict:dic];
}

-(UIImage *)image{
    if (!_image) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}
@end
