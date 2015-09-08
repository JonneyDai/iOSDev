//
//  GEUDPSocket.m
//  NewArchitecture
//
//  Created by gree's apple on 1/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEUDPSocket.h"

#define searchTimeInterval 1.0f
static int count = 0;

@implementation GEUDPSocket
{
    AsyncUdpSocket *_sock;
    NSTimer *timer;
    int repeatCount;
}
@synthesize hostIP,hostPort,udpType = _udpType;

#pragma mark-
#pragma mark life cycle
- (void)deallocSock//two Step: 1、closeSocket. 2、releaseSource
{
    
}

-(void)dealloc
{
    
}

#pragma mark-
#pragma mark ThirdParty Delegate
- (GEUDPSocket *)creatSocketWithHostIP:(NSString *)ip
                              HostPort:(UInt16)port
                              Delegate:(id)mDelegate
{
    hostIP = ip;
    hostPort = port;

    self.delegate = mDelegate;
    
    _sock = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [_sock bindToPort:1024 error:nil];
    [_sock receiveWithTimeout:-1 tag:0];//启动接受
    [_sock maxReceiveBufferSize];
    
    return self;
}

- (BOOL)keepAliveWithData:(NSData *)data
{
    return YES;
}

- (BOOL)writeData:(NSData *)data
{
    data = [timer userInfo];
    if (timer) {
        if (count < repeatCount) {
            count ++;
        }else{
            repeatCount = 0;
            count = 0;
            
            [timer invalidate];
            timer = nil;
            
            return YES;
        }
    }
    
    [_sock sendData:data toHost:hostIP port:hostPort withTimeout:-1 tag:0];
    NSLog(@"UDP SendData host: %@ , port: %d",hostIP,hostPort);
    
    return YES;
}

- (BOOL)writeData:(NSData *)data withRepeat:(UInt16)count
{
    repeatCount = count;
    timer = [NSTimer scheduledTimerWithTimeInterval:searchTimeInterval target:self selector:@selector(writeData:) userInfo:data repeats:YES];
    
    return YES;
}

#pragma mark-
#pragma mark ThirdParty Delegate
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    [self.delegate onUdpSocket:self didReceiveData:data fromHost:host port:port];
    return YES;
}

#pragma mark-
#pragma mark setter and getter

-(void)setUdpType:(GEUDPType)mudpType
{
    _udpType = mudpType;
    if (_udpType == GEUdpTypeOfBC) {
        [_sock enableBroadcast:YES error:nil];
    }else{
        [_sock enableBroadcast:NO error:nil];
    }
        
}

@end

