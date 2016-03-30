//
//  RTUdpDAO.h
//  NewArchitecture
//
//  Created by gree's apple on 3/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTSocketDAO.h"
#import "GEUDPSocket.h"

@interface RTUDPDAO : NSObject <RTSocketDAO>
{
    @private
    NSMutableDictionary *_udpStorage;//储存UDP库
}

+ (RTUDPDAO *) shareInstance;
//插入方法
-(int) create:(GEUDPSocket *)obj;

//删除方法
-(int) removeByMac:(NSString *)mac;

//修改方法
-(int) modify:(GEUDPSocket *)obj;

//按照主键查询数据方法
-(GEUDPSocket *) findByMac:(NSString *)mac;

//查询所有数据方法
-(NSMutableDictionary*) findAll;

@end
