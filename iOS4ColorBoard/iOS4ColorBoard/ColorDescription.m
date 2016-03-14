//
//  ColorDescription.m
//  iOS4ColorBoard
//
//  Created by 代隽杰 on 16/3/14.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ColorDescription.h"

@implementation ColorDescription

-(instancetype) init
{
    self = [super init];
    if (self) {
        _color = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        _name = @"Blue";
        
    }
    return self;
    
}

@end
