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

@synthesize hostIP,hostPort,delegate;

- (GETCPSocket *)creatSocketWithHostIP:(NSString *)ip
                              HostPort:(UInt16)port
                              Delegate:(id)mDelegate
{
    hostIP = ip;
    hostPort = port;
    
    self.delegate = mDelegate;
    
    _sock = [[AsyncSocket alloc] initWithDelegate:self];
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
{
    /*
        第三方库暂时不支持写入返回失败，后续换库
     */
    [_sock writeData:data withTimeout:3.0f tag:0];
    
    return YES;
}

-(void)setDelegate:(id<GETCPSocketDelegate>)mdelegate
{
    delegate = mdelegate;
    NSLog(@"delegate");

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
    NSLog(@"ROOT WillConnect");
    if ([delegate respondsToSelector:@selector(GEonSocketWillConnect:)]) {
        [delegate GEonSocketWillConnect:self];
        NSLog(@"ROOT WillConnect222222");

    }
    
    return YES;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port //这里才是正在连接上
{
    NSLog(@"ROOT didConnect");
    [delegate GEonSocket:self didConnectToHost:host port:port];
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"ROOT Disconnect");
    if ([delegate respondsToSelector:@selector(GEonSocketDidDisconnect:)]) {

    [delegate GEonSocketDidDisconnect:self];
    }
    NSLog(@"ROOT Disconnect22");

}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"ROOT didReadData");
    [delegate GEonSocket:self didReadData:data];
    [sock readDataWithTimeout:-1 tag:0];
}

@end
