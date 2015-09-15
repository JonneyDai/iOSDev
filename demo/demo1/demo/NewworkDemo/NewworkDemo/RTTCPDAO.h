//
//  RTTCPDAO.h
//  NewArchitecture
//
//  Created by gree's apple on 3/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTSocketDAO.h"
#import "GETCPSocket.h"

@interface RTTCPDAO : NSObject <RTSocketDAO>
{
    @private
    /*
     *ATTATION:因为手机与板子存在多连接的问题，故不能单纯通过MAC来辨别，需要构建规则....如传输文件时储存的Socket为
     *TF+xxxxxx(MAC)!
     *服务器连接Socket为SV+xxxxxx(MAC).....其余同理
     */
    NSMutableDictionary *_tcpStorage; //储存TCP库,所有GETCPSocket都储存在此，key为对应的MAC
}

+ (RTTCPDAO *) shareInstance;

//插入方法
- (int) create:(GETCPSocket *)obj;

//删除方法
- (int) removeByMac:(NSString *)mac;

//修改方法
- (int) modify:(GETCPSocket *)obj;

//按照主键查询数据方法
- (GETCPSocket *) findByMac:(NSString *)mac;

//查询所有数据方法
- (NSMutableDictionary*) findAll;

@end

