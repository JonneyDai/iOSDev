//
//  GEUDPSocket.h
//  NewArchitecture
//
//  Created by gree's apple on 1/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GESocket.h"
#import "AsyncUdpSocket.h"

@class GEUDPSocket;

typedef enum {
    GEUdpTypeOfPTP =0,            //点对点
    GEUdpTypeOfBC,                //局域网广播
}GEUDPType;

typedef enum {
    GEUDPStatus_NONE = 0,
    GEUDPStatus_Success,
    GEUDPStatus_Fail,
}GEUDPStatus;

/************************************************************************************/
/*                          GETCPSocketDelegate                                     */
/************************************************************************************/
/*
    回调，你懂得！
    GCDASYNCSOCKET需要每次读取完数据包设置[sock receiveWithTimeout:-1 tag:0];;
 */
@protocol GEUDPSocketDelegate <NSObject>

- (BOOL)onUdpSocket:(GEUDPSocket *)sock
     didReceiveData:(NSData *)data
           fromHost:(NSString *)host
               port:(UInt16)port;

@end

/************************************************************************************/
/*                          GEUDPSocket                                             */
/************************************************************************************/
@interface GEUDPSocket : NSObject <GESocket,AsyncUdpSocketDelegate>

@property (nonatomic, weak) id<GEUDPSocketDelegate> delegate;
@property (nonatomic, strong) NSString *identify;                          //标识
@property (nonatomic) BOOL _isAlive;                                      //客户端选择是否keepAlive
@property (nonatomic) GEUDPType udpType;                                 //需要区分
@property (nonatomic, readonly) NSString *hostIP;
@property (nonatomic, readonly) UInt16 hostPort;
@property (nonatomic, readonly) GEUDPStatus _status;
/*
   为何我不提供单纯的socket构建方法~~因为我已丧心病狂....
   在此使用RTUDPDAO,主要是避免socket乱构建，没有管理的规范，故需要强制使用DAO！
   DAO可通过单例获取
 */
- (GEUDPSocket *)creatSocketWithHostIP:(NSString *)ip
                              HostPort:(UInt16)port
                              Delegate:(id)mDelegate;
/*
   顾名思义就是保活用的
 */
- (BOOL)keepAliveWithData:(NSData *)data;

/*
   客户端调用发送函数，此接口发送失败时会自动重复发送3次。
   此方法将会自动控制发包的时间。
   若此时有多个命令，将会存起来。
 */
- (BOOL)writeData:(NSData *)data;

/*
    同包数据发送次数，此接口不会发送失败不会重复发送。
 */
- (BOOL)writeData:(NSData *)data withRepeat:(UInt16)count;

- (void)deallocSock;//two Step: 1、closeSocket. 2、releaseSource

@end
