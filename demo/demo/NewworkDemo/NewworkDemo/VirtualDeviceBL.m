//
//  VirtualDevice.m
//  NewworkDemo
//
//  Created by gree's apple on 24/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "VirtualDeviceBL.h"

@implementation VirtualDeviceBL
{
    GETCPSocket *tcp;
    GEUDPSocket *udp;
    
    GENetworking *_nw;
}

@synthesize excuteMac,isUdpBroadcast,_context,_command;

#pragma mark-
#pragma mark lift cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
        _context = [[GEWiFiContext alloc] init];
        _nw = [[GENetworking alloc] init];
        _command = [[Command alloc] init];
        
        tcpDao = [[RTTCPDAO alloc] init];
        udpDao = [[RTUDPDAO alloc] init];
    }
    
    return self;
}

#pragma mark-
#pragma mark Context
-(GEWiFiContext *)configContextWithData:(NSData *)data
{
    //传入任何数据，都在这区分开
    return nil;
}

#pragma mark-
#pragma mark Network
-(void)creatTcpWithIpAndPortContext:(NSDictionary *)context
{
    [_nw set_tcpDao:tcpDao];
    
    tcp = [_nw creatTcpWithDAO:tcpDao withIpAndPortContext:@{
                                                              @"IP" : @"192.168.1.1",
                                                              @"Port" : [NSNumber numberWithInt:6000]
                                                              }
                                              withDelegate:self];

    NSLog(@"1111111");

    tcp._tcpType = GETcpTypeOfPTP;
    tcp._isAlive = NO;
    NSLog(@"222222");

    NSLog(@"33333");

}

-(void)creatUdpWithIpAndPortContext:(NSDictionary *)context
{
    [_nw set_udpDao:udpDao];
    
    udp = [_nw creatUdpWithDAO:udpDao withIpAndPortContext:@{
                                                              @"IP" : @"255.255.255.0",
                                                              @"Port" : [NSNumber numberWithInt:9090]
                                                              }
                                              withDelegate:self];
    NSLog(@"UDP creat");
}

#pragma mark-
#pragma mark command
-(void)excuteWithTcp:(BOOL)isTcp
{
//    if (isTcp) {
////        tcp = [tcpDao findByMac:excuteMac];
//        NSData *data = [_command excute];
//        [tcp writeData:data];
//    }else{
//        NSData *data = [_command excute];
//        if (isUdpBroadcast) {
//            [udp writeData:data withRepeat:5];
//        }else{
//            [udp writeData:data];
//        }
//    }
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
    NSLog(@"sock didReadData");
}

- (void)GEonSocket:(GETCPSocket *)sock didReadData:(NSData *)data
{
    NSLog(@"sock willConnect");
}

- (void)GEonSocketDidDisconnect:(GETCPSocket *)sock
{
    NSLog(@"sock didDisconnect");
}

#pragma mark-
#pragma mark UdpDelegate
- (BOOL)onUdpSocket:(GEUDPSocket *)sock didReceiveData:(NSData *)data fromHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Udp didReceive");
    return YES;
}

@end




