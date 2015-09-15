//
//  Command.m
//  NewworkDemo
//
//  Created by gree's apple on 25/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "Command.h"

@implementation Command

- (NSData *)excuteWithIdentify:(NSString *)identify
                   withFactory:(id<GEFormatFactory>)factory
                        withBL:(GEAirCDeviceInfoBL *)bl
{
    NSData *data = [factory creatWithIdentify:identify withBL:bl];
    
    return data;
}

-(id)excuteWithData:(NSData *)data
        withFactory:(id <GEFormatFactory>)factory
             withBL:(id)bl
{
    id d = [factory parseWithData:data withBL:bl];
    
    return d;
}

@end
