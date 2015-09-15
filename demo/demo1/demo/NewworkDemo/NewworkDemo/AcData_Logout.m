//
//  AcData_Logout.m
//  Remote
//
//  Created by gree's apple on 9/6/13.
//  Copyright (c) 2013 WJF-Monk  330694. All rights reserved.
//

#import "AcData_Logout.h"

@implementation AcData_Logout

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
    
    *Bufptr = 0x13;//命令字
    len += 1;
    Bufptr ++;
    
    return len;
}

//设置有效数据内容
-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf
{
    int len = 0;
    unsigned char *Bufptr = Buf;
    int Temp = 0;
    
    self.TelName = StaticInfo.TelName;//手机名称字符串
    Temp = [self FillPacketWithString:self.TelName Buffer:Bufptr];
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
    
    if ( buf[3] == 0x23 )
    {
        buf += 4;   //去除头码
        
        if (*buf == 0x00) //登陆状态
        {
            NSString *LoginState = @"0";
            [dic setObject:LoginState forKey:@"LoginState"];
            //NSLog(@"登出成功");
        }
        else
        {
            NSString *LoginState = @"1";
            [dic setObject:LoginState forKey:@"LoginState"];
            //NSLog(@"登出失败");
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
