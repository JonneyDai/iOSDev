//
//  VirtualDeviceProtocol.h
//  NewworkDemo
//
//  Created by gree's apple on 25/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GEWiFiContext.h"
#import "GENetworking.h"
#import "Command.h"

@protocol VirtualDeviceProtocol <NSObject>

@optional

@property (nonatomic, strong) GENetworking *_nw;            //网络
@property (nonatomic, strong) GEWiFiContext *_context;      //设备信息
@property (nonatomic, strong) Command *_command;            //指令
@property (nonatomic, strong) NSString *identify;           //标识 可以认为是MAC

//Context
- (GEWiFiContext *) configContextWithData:(NSData *)data;

//Command
- (void)excuteWithIdentify:(NSString *)identify withFactory:(id <GEFormatFactory>)factory;

//NW
- (void)creatTcpWithIpAndPortContext:(NSDictionary *)context;

- (void)creatUdpWithIpAndPortContext:(NSDictionary *)context;

@end
