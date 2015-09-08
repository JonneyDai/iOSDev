//
//  VirtualDeviceForBroadcast.m
//  NewworkDemo
//
//  Created by gree's apple on 25/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "VirtualDeviceForBroadcastBL.h"
#import "GEHexFactory.h"

#define repeatTime 5
@implementation VirtualDeviceForBroadcastBL
{
    GEUDPSocket *udp;
    RTUDPDAO *udpDao;
}
@synthesize _command,isUdpBroadcast,_nw = nw,excuteMac;

#pragma mark-
#pragma mark life cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
        nw = [GENetworking shareInstance];
        udpDao = [RTUDPDAO shareInstance];
        _command = [[Command alloc] init];
    }
    return self;
}

-(void)broadcast
{
    GEHexFactory *fac = [[GEHexFactory alloc] init];
    NSData *data = [_command excuteWithIdentify:@"AcData_Broadcast" withFactory:fac withBL:nil];
    [udp writeData:data withRepeat:repeatTime];
}

//Command
- (void)excuteWithIdentify:(NSString *)identify withFactory:(id <GEFormatFactory>)factory;
{
    NSData *data = [_command excuteWithIdentify:identify withFactory:factory withBL:nil];
    [udp writeData:data withRepeat:repeatTime];
}

- (void)creatUdpWithIpAndPortContext:(NSDictionary *)context
{
    [nw set_udpDao:udpDao];
    
    udp = [nw creatUdpBroadCastWithDAO:udpDao withDelegate:self];
    
    [udpDao setExcuteMac:@"00000000"];
    NSLog(@"UDP creat");
}

#pragma mark-
#pragma mark UdpDelegate
- (BOOL)onUdpSocket:(GEUDPSocket *)sock didReceiveData:(NSData *)data fromHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"*******Start******* Udp didReceive *******Start*******");
    NSLog(@"%@",data);
    NSLog(@"*******End********* Udp didReceive *******End*********");
    return YES;
}


@end
