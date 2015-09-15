//
//  AcData_ConfiguredDeviceName.m
//  Remote
//
//  Created by 翁 健峰 on 13-8-5.
//  Copyright (c) 2013年 WJF-Monk  330694. All rights reserved.
//

#import "AcData_ConfiguredDeviceName.h"
#import "DeviceData.h"
#import "DeviceNetWork.h"

@implementation AcData_ConfiguredDeviceName

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
    
    *Bufptr = 0x14;//命令字
    len += 1;
    Bufptr ++;
    
    return len;
}

//设置有效数据内容
-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf
{
    DeviceNetWork *mDeviceNetWork = [DeviceNetWork shareInstance];;
    DeviceData *mDeviceData = mDeviceNetWork->CurrentDeviceData;

    int len = 0;
    unsigned char *Bufptr = Buf;
    int Temp = 0;
    
    NSString *name = mDeviceData->DeviceName;
    Temp = [self FillPacketWithString:name Buffer:Bufptr];
    Bufptr += Temp;
    len += Temp;
    
    return len;
}

-(id)HandleTcpRecDate:(NSData *)data  //接收空调回复数据
{
    unsigned char *buf;
    NSMutableDictionary *dic; //保存必要数据。
    dic = [[NSMutableDictionary alloc]initWithCapacity:64];
    
    buf = (unsigned char *)[data bytes];
    
    if ( buf[3] == 0x24 )
    {
        buf += 4;   //去除头码
        
        if (*buf == 0x00) //登陆状态
        {
            //NSLog(@"空调名修改成功");
        }
        else
        {
            //NSLog(@"空调名修改失败");
            return nil;     //不保存数据
        }
        buf += 1;
        
        return dic; //返回
    }
    else
    {
        return nil;
    }
    
}



@end
