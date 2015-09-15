//
//  GENetworking.m
//  NewArchitecture
//
//  Created by gree's apple on 1/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GENetworking.h"

@implementation GENetworking
@synthesize _tcpDao,_udpDao;

#pragma mark-
#pragma mark life cycle

+ (GENetworking *)shareInstance
{
    static GENetworking *_nw = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nw = [[self alloc] init];
    });
    return _nw;
}

#pragma mark-
#pragma mark TcpDao
-(GETCPSocket *)creatTcpWithDAO:(id<RTSocketDAO>)dao withIpAndPortContext:(NSDictionary *)context withDelegate:(id)delegate
{
    tcpSocket_ = [[GETCPSocket alloc] creatSocketWithHostIP:[context objectForKey:@"IP"]
                                                   HostPort:[[context objectForKey:@"Port"] intValue]
                                                   Delegate:delegate];
    if (dao) {
        [dao create:tcpSocket_];
    }
    
    return tcpSocket_;
}

- (void) removeTcpSocketByMac:(NSString *)mac
{
    [_tcpDao removeByMac:mac];
}

- (GETCPSocket *)findTcpSocketByMac:(NSString *)mac
{
    return [_tcpDao findByMac:mac];
}

- (NSMutableDictionary *)findAllTcpSocket
{
    return [_tcpDao findAll];
}

#pragma mark-
#pragma mark UdpDao
-(GEUDPSocket *)creatUdpWithDAO:(id<RTSocketDAO>)dao withIpAndPortContext:(NSDictionary *)context withDelegate:(id)delegate
{
    udpSocket_ = [[GEUDPSocket alloc] creatSocketWithHostIP:[context objectForKey:@"IP"]
                                                   HostPort:[[context objectForKey:@"Port"] intValue]
                                                   Delegate:delegate];
    
    if (dao) {
        [dao create:udpSocket_];
    }
    
    return udpSocket_;
}

-(GEUDPSocket *)creatUdpBroadCastWithDAO:(id<RTSocketDAO>)dao withDelegate:(id)delegate
{
    udpSocket_ = [[GEUDPSocket alloc] creatSocketWithHostIP:@"192.168.0.255"
                                                   HostPort:988
                                                   Delegate:delegate];
    [udpSocket_ setUdpType:GEUdpTypeOfBC];
    if (dao) {
        [dao create:udpSocket_];
    }
    
    return udpSocket_;
}

- (void) removeUdpSocketByMac:(NSString *)mac
{
    [_udpDao removeByMac:mac];
}

- (GEUDPSocket *)findUdpSocketByMac:(NSString *)mac
{
   return [_udpDao findByMac:mac];
}

- (NSMutableDictionary *)findAllUdpSocket
{
   return [_udpDao findAll];
}

#pragma mark-
#pragma mark getters and setters
-(void)set_tcpDao:(RTTCPDAO *)mtcpDao
{
    _tcpDao = mtcpDao;
}

-(void)set_udpDao:(RTUDPDAO *)mudpDao
{
    _udpDao = mudpDao;
}

@end
