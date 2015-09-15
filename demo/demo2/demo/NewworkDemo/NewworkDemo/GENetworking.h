//
//  GENetworking.h
//  NewArchitecture
//
//  Created by gree's apple on 1/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GETCPSocket.h"
#import "GEUDPSocket.h"
#import "RTTCPDAO.h"
#import "RTUDPDAO.h"

/************************************************************************************/
/*     这个类的意  图是，网络的总入口及出口，所有数据交互打止到这里，下面的连接是隐藏起来的。     */
/*   此类与业务息息相关&&此类打包起来既是一个设备的网络信息啦...                             */
/*   各自去维护自己的socketDelegate                                                    */
/*   ############每个设备对象各种管理自己的delegate#############                         */
/*   由于后续可能扩充TCP/UDP返回的数据，如果现在在这里写死的话，那以后不就经常要改这个文件？？？   */
/*   让应用层自己去实现接收代理吧。。。。                                                  */
/************************************************************************************/

@interface GENetworking : NSObject
{
    RTTCPDAO *_tcpDao;
    RTUDPDAO *_udpDao;
    
    @private
    /*
        具体操作添加删除tcp、udp是在对应的DAO类中
     */
    GETCPSocket *tcpSocket_;
    GEUDPSocket *udpSocket_;
}

@property (nonatomic, strong) RTTCPDAO *_tcpDao;
@property (nonatomic, strong) RTUDPDAO *_udpDao;
@property (nonatomic, strong) NSString *identify;       //创建TCP时需要标识

+ (GENetworking *)shareInstance;    //因为需要管理DAO，故使用单例

- (GETCPSocket *) creatTcpWithDAO:(id <RTSocketDAO>)dao
             withIpAndPortContext:(NSDictionary *)context
                         withType:(GETCPType)type
                     withDelegate:(id)delegate;

- (GEUDPSocket *) creatUdpWithDAO:(id <RTSocketDAO>)dao
             withIpAndPortContext:(NSDictionary *)context
                     withDelegate:(id)delegate;  //普通UDP

- (GEUDPSocket *) creatUdpBroadCastWithDAO:(id<RTSocketDAO>)dao
                              withDelegate:(id)delegate;  //专为broadcast定制

- (void) removeTcpSocketByMac:(NSString *)mac;

- (void) removeUdpSocketByMac:(NSString *)mac;

- (GETCPSocket *)findTcpSocketByMac:(NSString *)mac;

- (GEUDPSocket *)findUdpSocketByMac:(NSString *)mac;

- (NSMutableDictionary *)findAllTcpSocket;

- (NSMutableDictionary *)findAllUdpSocket;

@end
