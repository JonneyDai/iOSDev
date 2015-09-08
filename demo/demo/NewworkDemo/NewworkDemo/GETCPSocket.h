//
//  GETCPScoket.h
//  NewArchitecture
//
//  Created by gree's apple on 1/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GESocket.h"
#import "AsyncSocket.h"

@class GETCPSocket;
/************************************************************************************/
/*       提取出此层是为了以后更改第三方socket库时，上层不需要做改动!                         */
/*       我认为的TCP类，应该具备创建、销毁、更改(暂不知改啥)                                */
/*       能够提供多线程入口（恩，其实也是回到主线程，不然资源冲突有得你哭)                     */
/*       能够自我keepAlive,并及时的通知上层修改状态机                                     */
/*       能够有ID来区分不同的应用领域                                                    */
/*       能够在同一Socket循环的发送同一个数据                                            */
/************************************************************************************/


typedef enum {
    GETcpTypeOfPTP =0,            //近程间的点对点
    GETcpTypeOfPTSP,              //远程点对点
    GETcpTypeOfPTS,               //远程点对服务器
    GETCPTypeOfTFPTP,             //传输文件点对点
}GETCPType;

typedef enum {
    GETCPServiceStatusNone,             //连接断开
    GETCPServiceStatusConnecting,       //连接中
    GETCPServiceStatusDone,             //连接完成
}GETCPServiceStatus;


/************************************************************************************/
/*                          GETCPSocketDelegate                                     */
/************************************************************************************/
/*
    回调，你懂得！
    由于TCP需要不断的设置读取状态，所以根据不同的socket库需求，添加对应的功能。
    GCDASYNCSOCKET需要每次读取完数据包设置[sock readDataWithTimeout:-1 tag:0];
 */
@protocol GETCPSocketDelegate <NSObject>

@required
- (void)GEonSocket:(GETCPSocket *)sock didReadData:(NSData *)data;

- (BOOL)GEonSocketWillConnect:(GETCPSocket *)sock;

- (void)GEonSocket:(GETCPSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port;

- (void)GEonSocketDidDisconnect:(GETCPSocket *)sock;

@end



/************************************************************************************/
/*                          GETCPSocket                                             */
/************************************************************************************/
@interface GETCPSocket : NSObject <GESocket,AsyncSocketDelegate>

@property (nonatomic, weak) id<GETCPSocketDelegate> delegate;                    //weak,delegate传不过来
@property (nonatomic, readonly) NSUInteger _tag;                          //标识,每次init完成后都会加入RAM,并主动分配tag
@property (nonatomic, assign) BOOL _isAlive;                              //客户端选择是否keepAlive
@property (nonatomic, assign) GETCPType _tcpType;                         //需要标记类别，因为流程不一样
@property (nonatomic, readonly) GETCPServiceStatus _tcpServiceStatus;      //状态机，针对单个socket的状态机
@property (nonatomic, readonly) NSString *hostIP;
@property (nonatomic, readonly) UInt16 hostPort;
/*
    为何我不提供单纯的socket构建方法~~因为我已丧心病狂....
    在此使用RTTCPDAO,主要是避免socket乱构建，没有管理的规范，故需要强制使用DAO！
    DAO可通过单例获取....ERROR,不用在对象本身创建，会有问题。。如使用DAO创建socket，那么就无需调用此类来创建了，所以这是一个先后问题
 */
- (GETCPSocket *)creatSocketWithHostIP:(NSString *)ip
                              HostPort:(UInt16)port
                              Delegate:(id)mDelegate;

/*
    顾名思义就是保活用的
    ATTENTION:若开启了Alive后，软件进入后台或对象销毁，均要release此circle，否则溢出
 */
- (BOOL)keepAliveWithData:(NSData *)data;

/*
    客户端调用发送函数，此接口发送失败时会自动重复发送3次。
    此方法将会自动控制发包的时间。
    若此时有多个命令，将会存起来。
 */
- (BOOL)writeData:(NSData *)data;

- (void)deallocSock;//two Step: 1、closeSocket. 2、releaseSource

@end
