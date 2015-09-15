//
//  AcData.m
//  Remote
//
//  Created by gree's apple on 1/2/13.
//  Copyright (c) 2013 WJF-Monk  330694. All rights reserved.
//

#import "AcData.h"

@implementation AcData

#pragma mark Data

//-(id)initWithMac:(NSString *)mac
//{
//    self = [super init];
//    if (self)
//    {
//
//    }
//    
//    return self;
//}

//设置广播帧头字节数据
-(int)TcpNwkBuildHeaderFrame:(unsigned char *)Buf
{
    
    return 0;
}

//设置有效数据内容
-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf
{    
    
    return 0;
}

//设置校验码数据
-(unsigned char)TcpNwkBuildCheckSum:(unsigned char *)Buf ForLength:(int)Len
{
    int Tlen = Len - 2;
    unsigned char Sum = 0;
    Buf = Buf +2;
    
    for (int i = 0; i < Tlen; i++)
    {
        Sum += *Buf;
        Buf++;
    }
    
    return Sum;
}

//设置数据包长度
-(void)TcpPacketLength:(unsigned char *)Buf ForLength:(int)Len
{
    Buf = Buf - 2;//去除0x7E
    *Buf = Len - 2;//填充数据
}

//设置发送数据
-(NSData *)TcpNwkBuildPacket:(unsigned char *)Buf
{
    unsigned char *Bufptr = Buf;
    int Temp = 0;
    int Len = 0;
    unsigned char sum;
    NSData *data;
    
    Temp = [self TcpNwkBuildHeaderFrame:Bufptr];
    Len += Temp;    
    Bufptr += Temp;
    
    Temp = [self TcpNwkBuildPacketFrame:Bufptr];
    Len += Temp;
    Bufptr += Temp;
    
    [self TcpPacketLength:(Bufptr-Temp) ForLength:Len];
    
    sum = [self TcpNwkBuildCheckSum:Buf ForLength:Len];
    *Bufptr = sum;
    Len += 1;
    
    data = [NSData dataWithBytes:Buf length:Len];
    
    return data;
}

-(void)HandleRecDate:(NSData *)data
{
}

#pragma mark private

-(int)FillPacketWithString:(NSString *)str Buffer:(unsigned char *)Buf
{
    unsigned char *Bufptr = Buf;
    int len = 0;
    int StrLen = (int)[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    *Bufptr = StrLen;
    Bufptr += 1;
    len += 1;
    
    memcpy(Bufptr, [str cStringUsingEncoding:NSUTF8StringEncoding], StrLen); 
    len += StrLen;
    
    return len;
}

@end






