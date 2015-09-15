//
//  GEFormatFactory.h
//  NewworkDemo
//
//  Created by gree's apple on 26/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol VirtualDeviceProtocol;
@class GEAirCDeviceInfoBL;

@protocol GEFormatFactory <NSObject>

@optional
- (NSData *)creatWithIdentify:(NSString *)identify withBL:(GEAirCDeviceInfoBL *)bl;

- (id)parseWithData:(NSData *)data withBL:(id)bl;

@end