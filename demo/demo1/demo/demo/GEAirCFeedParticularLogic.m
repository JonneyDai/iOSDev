//
//  GEAirCFeedParticularLogin.m
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEAirCFeedParticularLogic.h"
#import "GEAirCFeedDAO.h"

@implementation GEAirCFeedParticularLogic
{
    id _value;
    id _key;
}

-(instancetype)initWithValue:(id)value andKey:(id)key
{
    self = [super init];
    if (self) {
        _value = value;
        _key = key;
    }
    
    return self;
}

-(void)visitDao:(id<GEFeedDAO>)dao
{
    //
}

-(void)visitAircDao:(GEAirCFeedDAO *)air
{
    //根据key来判断是否需要进行逻辑修改，不用则直接赋值
    [dao setStuff:_value forKey:_key];
    
}

-(void)FanLogic
{
    //如果需要风速逻辑，那就调用咯。。日后也可以提取出来
    [dao setStuff:@"xx" forKey:@"yy"];
}

@end
