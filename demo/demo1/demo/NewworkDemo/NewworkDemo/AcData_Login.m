//
//  AcData_Control.m
//  Remote
//
//  Created by gree's apple on 26/2/13.
//  Copyright (c) 2013 WJF-Monk  330694. All rights reserved.
//

#import "AcData_Login.h"
#import "DeviceNetWork.h"
#import "DeviceData.h"
#import "AirCondDB.h"
#include <arpa/inet.h>

@implementation AcData_Login
@synthesize TcpData;

-(id)initWithMac:(NSString *)mac
{
    self = [super init];
    if (self)
    {
        mDeviceNetWork = [DeviceNetWork shareInstance];
        
        //        mAcDB = [mDeviceNetWork->mDeviceContrDB objectForKey:mDeviceNetWork->currentMac];
        
        mDeviceData = mDeviceNetWork->CurrentDeviceData;
    }
    return self;
}
//-(void)UpDateNewDB
//{
//    [mPublicData removeAllObjects];
//    mPublicData = [NSMutableDictionary dictionaryWithDictionary:mAcDB->mCurrentDB];//获取当前数据
//    NSNumber *mode;
//    mode = [mPublicData objectForKey:@"KDefaultMode"];//根据模式，将模式中的数据提取出来
//    NSString *modeKeyWord = [mAcDB->mModeKey objectAtIndex:[mode intValue]];
//    if (mModeData != nil)
//    {
//        mModeData = nil;
//    }
//    mModeData = [NSMutableDictionary dictionaryWithDictionary:[mAcDB->mCurrentDB objectForKey:modeKeyWord]];//提取数据完成
//}

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
    
    *Bufptr = 0x12;//命令字
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
            
//  *Bufptr = 0x12;//命令字

    *Bufptr = 0x80;//手机遥控码
    Bufptr += 1;
    len += 1;

//  GetLocalIPV4 *GetInfo = [GetLocalIPV4 sharelocalIPV4];//手机软件版本号
    self.TelVersion = StaticInfo.TVERSION;
    *Bufptr = self.TelVersion;
    Bufptr += 1;
    len += 1;
    
    //限制此处使用的系统名称长度为14个字节
    NSUInteger systemNameLength = [StaticInfo.TSystemName lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (systemNameLength >= 14) {
        self.TelSystemName = [self subStringOfString:StaticInfo.TSystemName WithMaxByteLength:14];
    }else{
        self.TelSystemName = StaticInfo.TSystemName;
    }
    //NSLog(@"SYSTEMNAME = %@, systemName = %@",StaticInfo.TSystemName,self.TelSystemName);
    
    Temp = [self FillPacketWithString:self.TelSystemName Buffer:Bufptr];
    Bufptr += Temp;
    len += Temp;

    //限制此处使用的手机名称长度为14个字节
    NSUInteger phoneNameLength = [StaticInfo.TelName lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (phoneNameLength >= 14) {
        self.TelName = [self subStringOfString:StaticInfo.TelName WithMaxByteLength:14];
    }else{
        self.TelName = StaticInfo.TelName;
    }
    //NSLog(@"PHONENAME = %@, phoneName = %@",StaticInfo.TelName,self.TelName);
    
    Temp = [self FillPacketWithString:self.TelName Buffer:Bufptr];
    Bufptr += Temp;
    len += Temp;
/***************************使用 nsstring 作为时间处理*****************************/  //此处使用nsstring比较方便。。。。
    self.TelTime = StaticInfo.TelTime; //获得手机时间
    //NSLog(@"telTIme %@",self.TelTime);
    NSUInteger data = [self.TelTime length];

    data = [[self.TelTime substringToIndex:4]intValue];//Year 占三个字节

    *Bufptr = 0;
    Bufptr += 1;

    if (data >= 0xff)
    {
        *Bufptr = data/256;
        Bufptr += 1;
        *Bufptr = data%256;
        Bufptr += 1;
    }
    else
    {
        Bufptr += 1;
        *Bufptr = data;
    }
    len += 3;

    NSRange range = NSMakeRange(5, 2);//Month
    data = [[self.TelTime substringWithRange:range]intValue];
    *Bufptr = data;
    Bufptr += 1;
    len += 1;

    range = NSMakeRange(8, 2);//Day
    data = [[self.TelTime substringWithRange:range]intValue];
    *Bufptr = data;
    Bufptr += 1;
    len += 1;

    range = NSMakeRange(11, 2);//hours
    data = [[self.TelTime substringWithRange:range]intValue];
    *Bufptr = data;
    Bufptr += 1;
    len += 1;

    range = NSMakeRange(14, 2);//Minute
    data = [[self.TelTime substringWithRange:range]intValue];
    *Bufptr = data;
    Bufptr += 1;
    len += 1;

    range = NSMakeRange(17, 2);//second
    data = [[self.TelTime substringWithRange:range]intValue];
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
/***************************使用 NSTimeInterval 作为时间处理***********************/ //备用。。。
//                self.TimeInterval = StaticInfo.TimeInterval; //获得与1970年的时间间隔
//                int days=((int)self.TimeInterval)/(3600*24);
//                int hours=((int)self.TimeInterval)%(3600*24)/3600;
//                int minutes = ( (((int)self.TimeInterval)%(3600*24)%3600) )/60;
//                int seconds = (( (((int)self.TimeInterval)%(3600*24)%3600) )%60 )%60;
//                NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟%i秒",days,hours,minutes,seconds];
//                //NSLog(@"%@",dateContent);
/***************************使用 NSTimeInterval 作为时间处理***********************/ //备用。。。

//    if (MutableData != nil)
//    {
//        NSMutableDictionary *dic = MutableData;
//        self.LoginName = [dic objectForKey:@"LoginName"];
//        self.LoginPassword = [dic objectForKey:@"LoginPassword"];
//    }
   
    
    Temp = [self FillPacketWithString:mDeviceData->LoginName Buffer:Bufptr];//用户名称
    //NSLog(@"测试用户名称 。。。%@",self.LoginName);
    
    Bufptr += Temp;
    len += Temp;
    
    Temp = [self FillPacketWithString:mDeviceData->LoginPassword Buffer:Bufptr];//用户密码
    //NSLog(@"测试用户密码 。。。%@",self.LoginPassword);
    Bufptr += Temp;
    len += Temp;
    
//    *Bufptr = 0xAA;//用户名称
//    Bufptr += 1;
//    len += 1;
//
//    *Bufptr = 0xAA;//用户密码
//    Bufptr += 1;
//    len += 1;
    
    return len;
}

-(NSString*)subStringOfString:(NSString*)string WithMaxByteLength:(int)length
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

-(id)HandleTcpRecDate:(NSData *)data  //接收空调回复数据
{
    unsigned char *buf;
    struct in_addr addr;
    int Temp = 0;
    NSMutableDictionary *dic; //保存必要数据。
    dic = [[NSMutableDictionary alloc]initWithCapacity:64];
    
    self.TcpData = data;
    buf = (unsigned char *)[data bytes];
    
    if ( buf[3] == 0x22 )
    {
        buf += 4;   //去除头码
        
        if (*buf == 0x00) //登陆状态
        {
            NSString *LoginState = @"0";
            [dic setObject:LoginState forKey:@"LoginState"];
            //NSLog(@"登陆成功");
        }
        else
        {
            NSString *LoginState = @"1";
            [dic setObject:LoginState forKey:@"LoginState"];
            //NSLog(@"登陆失败");
            return nil;     //不保存数据
        }
        buf += 1;
        
        if(*buf == 0x00)  //网络类型
        {
            NSString *NetWorkType = @"0";
            [dic setObject:NetWorkType forKey:@"NetWorkType"];
            //NSLog(@"client模式");
        }
        else if(*buf == 0x02)
        {
            NSString *NetWorkType = @"2";
            [dic setObject:NetWorkType forKey:@"NetWorkType"];
            //NSLog(@"AP模式");
        }
        buf += 1;
        
        Temp = *buf;    //网络名称长度
        //NSLog(@"temp.... = %d",Temp);
        buf += 1;
        
        NSString *Name = [[NSString alloc]initWithBytes:buf length:Temp encoding:NSASCIIStringEncoding]; //网络名称
        //NSLog(@"Name.... = %@",Name);
        [dic setObject:Name forKey:@"AcName"];  //保存网络名称
        buf += Temp;
        
        Temp = *buf;  //安全模式
        NSString *str = [NSString stringWithFormat:@"%d",Temp];
        [dic setObject:str forKey:@"NetWork_SecureType"];   //全转换成字符
        //NSLog(@"safeMode.... = %d",Temp);
        buf += 1;
        
        Temp = *buf; //检测板类型 0为亚信板、1为高通板、2为TI板。
        NSString *HWBoardType = [NSString stringWithFormat:@"%d",Temp];
        [dic setObject:HWBoardType forKey:@"HWBoardType"];
        buf += 2;
        
        Temp = *buf;  //密钥长度
        //NSLog(@"keyLen ... = %d",Temp);
        buf += 1;
        
        NSString *KeyData = [[NSString alloc]initWithBytes:buf length:Temp encoding:NSUTF8StringEncoding];
        [dic setObject:KeyData forKey:@"NetWork_Key"];
        //NSLog(@"Keydata.... = %@",KeyData);
        buf += Temp;
        
        buf += 1;   //预留字节
        
        addr.s_addr = *(unsigned int *)buf; //空调端IP
        NSString *Ip = [NSString stringWithUTF8String:inet_ntoa(addr)];
        [dic setObject:Ip forKey:@"AcIp"];
        //NSLog(@"Ip = %@",Ip);
        buf += 4;
        
        addr.s_addr = *(unsigned int *)buf; //空调端掩码
        NSString *bhost_Cip = [NSString stringWithUTF8String:inet_ntoa(addr)];
        [dic setObject:bhost_Cip forKey:@"AcMask"];
        //NSLog(@"host_mac = %@",bhost_Cip);
        buf += 4;
        
        addr.s_addr = *(unsigned int *)buf; //空调端网关
        NSString *chost_Cip = [NSString stringWithUTF8String:inet_ntoa(addr)];
        [dic setObject:chost_Cip forKey:@"AcGateway"];
        //NSLog(@"cip = %@",chost_Cip);
        buf += 4;
        
        addr.s_addr = *(unsigned int *)buf;  //空调端DNS
        NSString *dhost_Cip = [NSString stringWithUTF8String:inet_ntoa(addr)];
        [dic setObject:dhost_Cip forKey:@"AcDNS"];
        //NSLog(@"cip = %@",dhost_Cip);
        buf += 4;
        
        NSString *mac = [NSData dataWithBytes:buf length:6];  //空调端MAC
        [dic setObject:mac forKey:@"AcMac"];
        //NSLog(@"host_mac = %@",mac);
        //            NSString *str = [NSString stringWithCString: encoding:];
        buf += 6;
        
        return dic; //返回
    }
    else
    {
        return nil;
    }
    
}


@end


