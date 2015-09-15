//
//  VirtualDevice.m
//  NewworkDemo
//
//  Created by gree's apple on 24/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "VirtualDeviceBL.h"
#import "GEDeviceBLRepository.h"
#import "ControlFormatLists.h"
#import "GEHexFactory.h"
#import "GEAirCDeviceInfoBL.h"
#import "AppContext.h"

@implementation VirtualDeviceBL
{
    GETCPSocket *tcp;
    GEUDPSocket *udp;
    RTTCPDAO *tcpDao;
    RTUDPDAO *udpDao;
}

@synthesize _context,_nw,_command,identify;

#pragma mark-
#pragma mark lift cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
        _nw = [GENetworking shareInstance];
        _context = [[GEWiFiContext alloc] init];
        _command = [[Command alloc] init];
        
        tcpDao = [RTTCPDAO shareInstance];
        udpDao = [RTUDPDAO shareInstance];
    }
    
    return self;
}

-(void)dealloc
{
    NSLog(@"%s dealloc",__FILE__);
}

#pragma mark-
#pragma mark message
-(void)sendMessage:(BLMessageEvt)msg
{
    if (msg == BLMessageEvt_DeviceInterrupt) {         //此处一般都是网络类
            //通知到mediator
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:updataNotification
                                                        object:[NSString stringWithFormat:@"%d",msg]];
}

#pragma mark-
#pragma mark GEWiFiContext
-(GEWiFiContext *)configContextWithDictionary:(NSDictionary *)dic
{
    [_context setValuesForKeysWithDictionary:dic];
    
    return _context;
}

#pragma mark-
#pragma mark Network
-(void)creatTcpWithIpAndPortContext:(NSDictionary *)context
{
    [_nw set_tcpDao:tcpDao];
    _nw.identify = identify;
    
    tcp = [_nw creatTcpWithDAO:tcpDao
          withIpAndPortContext:context
           withType:GETcpTypeOfPTP
                  withDelegate:self];

    tcp._isAlive = NO;
}

-(void)creatUdpWithIpAndPortContext:(NSDictionary *)context
{
    [_nw set_udpDao:udpDao];
    
    udp = [_nw creatUdpWithDAO:udpDao withIpAndPortContext:@{
                                                              @"IP" : @"255.255.255.0",
                                                              @"Port" : [NSNumber numberWithInt:9090]
                                                              }
                                              withDelegate:self];
}

#pragma mark-
#pragma mark command
-(void)excuteWithTcpIdentify:(NSString *)mIdentify
{
    NSLog(@"*******************发送同步数据");
    [AppContext shareAppContext].tempMac = mIdentify; //设置mac
    
    GEHexFactory *fac = [[GEHexFactory alloc] init];
    NSData *data = [_command excuteWithIdentify:mIdentify withFactory:fac withBL:nil];
    
    [tcp writeData:data];
    NSLog(@"******************发送完毕");
}

-(void)excuteWithUdpIdentify:(NSString *)mIdentify
{
    
}

#pragma mark-
#pragma mark TcpDelegate
- (BOOL)GEonSocketWillConnect:(GETCPSocket *)sock
{
    NSLog(@"sock WillConnect");
    return YES;
}

- (void)GEonSocket:(GETCPSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"sock didConnect");
    
    [self excuteWithTcpIdentify:KAcSync];//需要发送同步帧
}

- (void)GEonSocket:(GETCPSocket *)sock didReadData:(NSData *)data
{
    NSLog(@"sock didReadData %@",data);
    
    unsigned char *buf;
    buf = (unsigned char *)[data bytes];
    if (buf[0] == 0x7E && buf[1] == 0x7E) {
        GEHexFactory *fac = [[GEHexFactory alloc] init];
        
        /********创建设备实体********/
        GEDeviceBLRepository *rp = [GEDeviceBLRepository shareInstance];
        //搜索到只需创建一次，之后都是修改其内容
        GEAirCDeviceInfoBL *obj = [rp findDeviceInfoDBByMac:[self identify]];
        if (!obj) {
            obj = [[GEAirCDeviceInfoBL alloc] init];
            //创建ID的状态实体，并初始化
            [obj createByMac:[self identify]];
            
            //保存BL
            [rp addDeviceInfoDBObj:obj byMac:[self identify]];
        }
        [AppContext shareAppContext].tempMac = [self identify];//每个对象只保留了一个mac，故无需映射(以为需通过IP找到对应储存的mac)
        /********创建设备实体********/
        
        [_command excuteWithData:data withFactory:fac withBL:obj];
    }else{
        //可能是加密的json or other
    }
}

- (void)GEonSocketDidDisconnect:(GETCPSocket *)sock
{
    NSLog(@"sock didDisconnect");
}

#pragma mark-
#pragma mark UdpDelegate
- (BOOL)onUdpSocket:(GEUDPSocket *)sock didReceiveData:(NSData *)data fromHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Udp didReceiveData %@",data);
    return YES;
}

@end




