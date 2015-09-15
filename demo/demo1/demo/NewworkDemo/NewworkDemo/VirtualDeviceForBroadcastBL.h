//
//  VirtualDeviceForBroadcast.h
//  NewworkDemo
//
//  Created by gree's apple on 25/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VirtualDeviceProtocol.h"
/************************************************************************************/
/*  UDP广播类                      */
/************************************************************************************/

@interface VirtualDeviceForBroadcastBL : NSObject <VirtualDeviceProtocol,GEUDPSocketDelegate>


@property (nonatomic, strong) NSString *excuteMac;
@property (nonatomic, strong) GENetworking *_nw;
@property (nonatomic, strong) Command *_command;
@property (nonatomic, assign) BOOL isUdpBroadcast;
//@property (nonatomic, strong) NSString *identify;           //标识 可以认为是MAC

//Command
//- (void)excuteWithIdentify:(NSString *)identify withFactory:(id <GEFormatFactory>)factory;
- (void)broadcast;

- (void)creatUdpWithIpAndPortContext:(NSDictionary *)context;

@end
