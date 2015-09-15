//
//  RTTCPDAO.m
//  NewArchitecture
//
//  Created by gree's apple on 3/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "RTTCPDAO.h"

@implementation RTTCPDAO

-(instancetype)init
{
    self = [super init];
    if (self) {
        _tcpStorage = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    
    return self;
}

+ (RTTCPDAO *) shareInstance;
{
    static RTTCPDAO *_dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dao = [[self alloc] init];
    });
    return _dao;
}

//插入方法
-(int) create:(GETCPSocket *)obj
{
    NSString *sid = nil;
    if (obj._tcpType == GETcpTypeOfPTP) {        //近程间的点对点
        sid = [NSString stringWithFormat:@"Loc%@",@"mac"];
    }else if(obj._tcpType == GETcpTypeOfPTSP){   //远程点对点
        sid = [NSString stringWithFormat:@"SVPP%@",@"mac"];
    }else if(obj._tcpType == GETcpTypeOfPTS){    //远程点对服务器
        sid = [NSString stringWithFormat:@"SV%@",@"mac"];
    }else if(obj._tcpType == GETCPTypeOfTFPTP){  //传输文件点对点
        sid = [NSString stringWithFormat:@"TF%@",@"mac"];
    }else{
        [NSException raise:@"tcpTypeError" format:@"tcpTypeError" arguments:nil];
        return -1;
    }
    [_tcpStorage setObject:obj forKey:sid];
    
    return 0;
}

//删除方法
-(int) removeByMac:(NSString *)mac
{
    if ([[_tcpStorage allKeys] containsObject:mac]) {
        [_tcpStorage removeObjectForKey:mac];
    }else{
        return -1;
    }
        
    return 0;
}

//修改方法
-(int) modify:(GETCPSocket *)obj
{
    //do nothing
    return 0;
}

//查询所有数据方法
-(NSMutableDictionary*) findAll
{
    return _tcpStorage;
}

//按照主键查询数据方法
-(GETCPSocket *) findByMac:(NSString *)mac
{
    return [_tcpStorage objectForKey:mac];
}

@end
