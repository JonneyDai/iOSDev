//
//  GETCPScoket.m
//  NewArchitecture
//
//  Created by gree's apple on 1/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GETCPSocket.h"

@implementation GETCPSocket
{
    AsyncSocket *_sock;
}

@synthesize hostIP,hostPort,delegate,identify;

- (GETCPSocket *)creatSocketWithHostIP:(NSString *)ip
                              HostPort:(UInt16)port
                              Delegate:(id)mDelegate
{
    hostIP = ip;
    hostPort = port;
    
    self.delegate = mDelegate;
    [self deallocSock];
    _sock  = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *error;
    BOOL isConnect = [_sock connectToHost:ip onPort:port withTimeout:3.0f error:&error];

    if(!isConnect){
        //can't connect
        return nil;
    }
    return self;
}

- (BOOL)keepAliveWithData:(NSData *)data
{
    return NO;
}

- (BOOL)writeData:(NSData *)data
{               /*
        第三方库暂时不支持写入返回失败，后续换库
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        [_sock writeData:data withTimeout:-1 tag:0];
        [_sock readDataWithTimeout:-1 tag:0];
    });
    
    return YES;
}

-(void)setDelegate:(id<GETCPSocketDelegate>)mdelegate
{
    delegate = mdelegate;
}

- (void)deallocSock
{
    [_sock disconnect];
    //release
}

#pragma mark-
#pragma mark ThirdParty Delegate
-(BOOL)onSocketWillConnect:(AsyncSocket *)sock
{
    if ([delegate respondsToSelector:@selector(GEonSocketWillConnect:)]) {
        [delegate GEonSocketWillConnect:self];
    }
    return YES;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port //这里才是正在连接上
{
    if ([delegate respondsToSelector:@selector(GEonSocket:didConnectToHost:port:)]) {
        [delegate GEonSocket:self didConnectToHost:host port:port];
    }
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    if ([delegate respondsToSelector:@selector(GEonSocketDidDisconnect:)]) {
        [delegate GEonSocketDidDisconnect:self];
    }
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if ([delegate respondsToSelector:@selector(GEonSocket:didReadData:)]) {
        [delegate GEonSocket:self didReadData:data];
    }
    [sock readDataWithTimeout:-1 tag:0];
}

@end
