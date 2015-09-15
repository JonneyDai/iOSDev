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
//    NSString *excuteMac;    //需要执行命令的mac  //？？？？？？？当时为何会写多个identify标识？？？？？？当前界面mac及后台需要发送的mac不该标记在此
}
//@property (nonatomic, strong) NSString *excuteMac;
@property (nonatomic, strong) GEWiFiContext *_context;
@property (nonatomic, strong) GENetworking *_nw;
@property (nonatomic, strong) Command *_command;
@property (nonatomic, strong) NSString *identify;           //标识 可以认为是MAC

//由于是BL，所以应当在此处理时间
-(void)sendMessage:(BLMessageEvt)msg;

//Context
- (GEWiFiContext *) configContextWithDictionary:(NSDictionary *)dic;

//Command
- (void)excuteWithTcpIdentify:(NSString *)mIdentify;

- (void)excuteWithUdpIdentify:(NSString *)mIdentify;

//NW
- (void)creatTcpWithIpAndPortContext:(NSDictionary *)context;

- (void)creatUdpWithIpAndPortContext:(NSDictionary *)context;

@end
