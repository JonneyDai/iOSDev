//
//  AcData_sync.m
//  Remote
//
//  Created by gree's apple on 26/2/13.
//  Copyright (c) 2013 WJF-Monk  330694. All rights reserved.
//

#import "AcData_sync.h"

@implementation AcData_sync

-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(id)initWithMac:(NSString *)mac
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

-(int)TcpNwkBuildHeaderFrame:(unsigned char *)Buf
{
    int len = 0;
    unsigned char *Bufptr = Buf;
    
    *Bufptr = 0x7E;//同步字
    len += 1;
    Bufptr ++;
    
    *Bufptr = 0x7E;//同步字
    len += 1;
    Bufptr ++;
    
    *Bufptr = 0;//长度
    len += 1;
    Bufptr ++;
    
    *Bufptr = 0x02;//命令字
    len += 1;
    Bufptr ++;
    
    return len;
}

//设置有效数据内容
-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf
{
    int len = 0;

    return len;
}

@end
