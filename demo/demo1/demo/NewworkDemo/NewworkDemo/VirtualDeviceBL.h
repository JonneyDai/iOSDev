//
//  VirtualDevice.h
//  NewworkDemo
//
//  Created by gree's apple on 24/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VirtualDeviceProtocol.h"
/************************************************************************************/
/*     WIFI虚拟设备,其中包括WIFI设备信息、数据通道、控制指令（包括撤销）                      */
/*     此为一台设备的所有网络信息                                                        */
/************************************************************************************/



@interface VirtualDeviceBL : NSObject<GETCPSocketDelegate,GEUDPSocketDelegate,VirtualDeviceProtocol>
{
    NSString *excuteMac;    //需要执行命令的mac
    
    @private
    //socket管理类，貌似没必要啊....因为socket类型已在上层区分
    RTTCPDAO *tcpDao;
    RTUDPDAO *udpDao;
    
}
@property (nonatomic, strong) NSString *excuteMac;
@property (nonatomic, assign) BOOL isUdpBroadcast;
@property (nonatomic, strong) GEWiFiContext *_context;
@property (nonatomic, strong) Command *_command;
@property (nonatomic, strong) NSString *identify;           //标识 可以认为是MAC

//Context
- (GEWiFiContext *) configContextWithData:(NSData *)data;

//Command
- (void)excuteWithTcp:(BOOL)isTcp;

//NW
- (void)creatTcpWithIpAndPortContext:(NSDictionary *)context;

- (void)creatUdpWithIpAndPortContext:(NSDictionary *)context;

@end
