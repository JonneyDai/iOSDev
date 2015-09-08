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

- (NSData *)excuteWithIdentify:(NSString *)identify withFactory:(id <GEFormatFactory>)factory withBL:(GEAirCDeviceInfoBL *)bl;

@end
