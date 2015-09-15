//
//  AcData_Broadcast.m
//  NewworkDemo
//
//  Created by gree's apple on 26/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "AcData_Broadcast.h"
#import "AppContext.h"
#import "VirtualDeviceForBroadcastBL.h"
#include <arpa/inet.h>

@implementation AcData_Broadcast
{
    AppContext *ctx;
    VirtualDeviceForBroadcastBL *bl;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        ctx = [AppContext shareAppContext];
    }
    return self;
}

-(id)initWithBL:(VirtualDeviceForBroadcastBL *)BL
{
    self = [super init];
    if (self) {
        bl = BL;

        ctx = [AppContext shareAppContext];
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
    
    //获得系统名称长度
    int Temp;
    Temp = [super FillPacketWithString:ctx.osn Buffer:Bufptr];
    
    len += Temp;
    Bufptr += Temp;
    
    //手机名称
    //改Bug：手机名称过长时，无法搜索到空调，将手机名称减少到14个字节后使用
    NSString *abbreviatedPhoneName = [self subStringOfString:ctx.teln withByteLength:14];
    Temp = [super FillPacketWithString:abbreviatedPhoneName Buffer:Bufptr];
    
    len += Temp;
    
    return len;
}

-(void)HandleRecDate:(NSData *)data
{
    unsigned char *buf;
    buf = (unsigned char *)[data bytes];
    
    struct in_addr addr;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:10];
    
    buf += 4;//去除头码
    
    addr.s_addr = *(unsigned int *)buf;
    [dic setValue:[NSString stringWithUTF8String:inet_ntoa(addr)] forKey:@"mWifiInfo.ip"];
    buf += 4;
    
    addr.s_addr = *(unsigned int *)buf;
    [dic setValue:[NSString stringWithUTF8String:inet_ntoa(addr)] forKey:@"mWifiInfo.mask"];
    buf += 4;

    addr.s_addr = *(unsigned int *)buf;
    [dic setValue:[NSString stringWithUTF8String:inet_ntoa(addr)] forKey:@"mWifiInfo.gate"];
    buf += 4;

    addr.s_addr = *(unsigned int *)buf;
    [dic setValue:[NSString stringWithUTF8String:inet_ntoa(addr)] forKey:@"mWifiInfo.dns"];
    buf += 4;

    NSMutableString *mutableString = [[NSMutableString alloc]initWithCapacity:10];
    for (int z = 0; z < 6; z ++)
    {
        [mutableString appendFormat:@"%02x",*buf];
        buf +=1;
    }
    [dic setValue:mutableString forKey:@"mWifiInfo.mac"];
    
    int t = *buf;
    buf += 1;
    
    NSString *NameStr;
    NameStr = [[NSString alloc]initWithBytes:(const char *)buf length:t encoding:NSUTF8StringEncoding];
    
    /**********人为修改deviceName***********/
    if ([NameStr isEqualToString:@"卧室"]){
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if(![currentLanguage isEqualToString:@"zh-Hans"]){
            NameStr = NSLocalizedString(@"LocBedroom", @"卧室");
        }
    }
    [dic setValue:NameStr forKey:@"deviceName"];
    /**********人为修改deviceName***********/
    
    [bl configContextWithDictionary:dic];   //修改GEWiFiContext
    
//    创建设备的动作应该是在BL处理，不该在此。
    [bl sendMessage:BLMessageEvt_BroadcastDone];
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
