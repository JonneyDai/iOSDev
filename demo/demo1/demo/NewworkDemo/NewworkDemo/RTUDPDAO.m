//
//  RTUdpDAO.m
//  NewArchitecture
//
//  Created by gree's apple on 3/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "RTUDPDAO.h"

@implementation RTUDPDAO

@synthesize excuteMac;

#pragma mark-
#pragma mark life cycle
+ (RTUDPDAO *) shareInstance;
{
    static RTUDPDAO *_dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dao = [[self alloc] init];
    });
    return _dao;
}

#pragma mark-
#pragma mark RTSocketDAO Protocol
-(int) create:(GEUDPSocket *)obj
{
    [_udpStorage setObject:obj forKey:excuteMac];
    return 0;
}

-(int) removeByMac:(NSString *)mac
{
    [_udpStorage removeObjectForKey:excuteMac];
    return 0;
}

-(int) modify:(GEUDPSocket *)obj
{
    //do nothing
    return 0;
}

-(GEUDPSocket *) findByMac:(NSString *)mac
{
    return [_udpStorage objectForKey:mac];
}

-(NSMutableDictionary*) findAll
{
    return _udpStorage;
}

#pragma mark-
#pragma mark getter and setter
-(void)setExcuteMac:(NSString *)mexcuteMac
{
    excuteMac = mexcuteMac;
}

@end
