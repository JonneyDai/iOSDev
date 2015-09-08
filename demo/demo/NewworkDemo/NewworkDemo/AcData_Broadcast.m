//
//  AcData_Broadcast.m
//  NewworkDemo
//
//  Created by gree's apple on 26/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "AcData_Broadcast.h"
#import "AppContext.h"
#include <arpa/inet.h>

@implementation AcData_Broadcast
{
    AppContext *ctx;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        ctx = [AppContext sharelocalIPV4];
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
    
    *Bufptr = 0x011;//命令字
    len += 1;
    Bufptr ++;
    
    return len;
}

-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf
{
    int len = 0;
    unsigned char *Bufptr = Buf;
    
    *(unsigned int *)Bufptr = inet_addr([ctx.lh cStringUsingEncoding:NSASCIIStringEncoding]);
    
    len += 4;
    Bufptr += 4;
    
    //手机软件版本号
    *Bufptr = [ctx.osv intValue];
    len += 1;
    Bufptr += 1;
    
    //获得系统名称
    int Temp;//临时变量，存放系统名称长度
    Temp = [super FillPacketWithString:ctx.osn Buffer:Bufptr];
    
    len += Temp;
    Bufptr += Temp;
    
    //手机名称
    //改Bug：手机名称过长时，无法搜索到空调，将手机名称减少到14个字节后使用
    //Temp = [self FillPacketWithString:StaticLocalIPV4.TelName Buffer:Bufptr];
    NSString *abbreviatedPhoneName = [self subStringOfString:ctx.teln withByteLength:14];
    Temp = [super FillPacketWithString:abbreviatedPhoneName Buffer:Bufptr];
    
    len += Temp;
    
    return len;
}

-(NSString*)subStringOfString:(NSString*)string withByteLength:(int)length
{
    NSUInteger stringByteLength = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger stringCharactersCount = [string length];
    int index;
    if (stringByteLength <= length) {
        return nil;
    }else{
        //从头开始按照字符添加，超出长度则停止，取出这时的index，进而取出子字符串
        for (index = 4; index < stringCharactersCount; index ++) {
            NSString *subString = [string substringToIndex:index];
            NSUInteger subStringByteLength = [subString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            if (subStringByteLength > length) {
                break;
            }
        }
        return [string substringToIndex:index-1];
    }
}

@end
