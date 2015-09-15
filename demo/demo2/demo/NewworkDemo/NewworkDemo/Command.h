//
//  Command.h
//  NewworkDemo
//
//  Created by gree's apple on 25/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GEFormatFactory.h"
#import "GEAirCDeviceInfoBL.h"

@interface Command : NSObject

//打包数据帧
- (NSData *)excuteWithIdentify:(NSString *)identify
                   withFactory:(id <GEFormatFactory>)factory
                        withBL:(GEAirCDeviceInfoBL *)bl;

//解析
/*
 *使用id的理由：
 *返回值：一般情况下都是void，特别情况返回dictionary!看具体类的使用
 *bl:由于UDP不需要DeviceInfo而需要virtualDevice本身,而TCP有时需要有时不需要，避免方法长度，故使用id
 *bl maybe GEAirCDeviceInfoBL* or <VirtualDeviceProtocol>
 */
- (id)excuteWithData:(NSData *)data
         withFactory:(id <GEFormatFactory>)factory
              withBL:(id)bl;


@end
