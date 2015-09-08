//
//  AcData_Setting.m
//  Remote
//
//  Created by gree's apple on 23/1/14.
//  Copyright (c) 2014 WJF-Monk  330694. All rights reserved.
//

#import "AcData_Setting.h"
#import "DeviceNetWork.h"
#import "DeviceData.h"
#import "AirCondDB.h"

@implementation AcData_Setting

//-(id)init
//{
//    self = [super init];
//    if (self)
//    {
//        mDeviceNetWork = [DeviceNetWork shareInstance];
//        mDeviceData = mDeviceNetWork->CurrentDeviceData;
////        mAcDB = [AirCondDB ShardInstance];
//        mAcDB = [mDeviceNetWork->mDeviceContrDB objectForKey:mDeviceNetWork->currentMac];
//        
//        mPublicData = [[NSMutableDictionary alloc]initWithCapacity:60];
//        mModeData = [[NSMutableDictionary alloc]initWithCapacity:60];
//        
//        mPublicData = [NSMutableDictionary dictionaryWithDictionary:mAcDB->mCurrentDB];//获取当前数据
//        
//        NSNumber *mode;
//        mode = [mPublicData objectForKey:@"KDefaultMode"];//根据模式，将模式中的数据提取出来
//        NSString *modeKeyWord = [mAcDB->mModeKey objectAtIndex:[mode intValue]];
//        mModeData = [NSDictionary dictionaryWithDictionary:[mPublicData objectForKey:modeKeyWord]];//提取数据完成
//    }
//    return self;
//}

-(id)initWithMac:(NSString *)mac
{
    self = [super init];
    if (self)
    {
        mDeviceNetWork = [DeviceNetWork shareInstance];
        mDeviceData = mDeviceNetWork->CurrentDeviceData;
        mAcDB = [mDeviceNetWork->mDeviceContrDB objectForKey:mac];
        
        mPublicData = [[NSMutableDictionary alloc]initWithCapacity:60];
        mModeData = [[NSMutableDictionary alloc]initWithCapacity:60];
        
        mPublicData = [NSMutableDictionary dictionaryWithDictionary:mAcDB->mCurrentDB];//获取当前数据
        
        NSNumber *mode;
        mode = [mPublicData objectForKey:@"KDefaultMode"];//根据模式，将模式中的数据提取出来
        NSString *modeKeyWord = [mAcDB->mModeKey objectAtIndex:[mode intValue]];
        mModeData = [NSDictionary dictionaryWithDictionary:[mPublicData objectForKey:modeKeyWord]];//提取数据完成
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
    
    *Bufptr = 0x03;//命令字
    len += 1;
    Bufptr ++;
    
    return len;
}

-(void)UpDateNewDB
{
    [mPublicData removeAllObjects];
    mPublicData = [NSMutableDictionary dictionaryWithDictionary:mAcDB->mCurrentDB];//获取当前数据
    NSNumber *mode;
    mode = [mPublicData objectForKey:@"KDefaultMode"];//根据模式，将模式中的数据提取出来
    NSString *modeKeyWord = [mAcDB->mModeKey objectAtIndex:[mode intValue]];
    if (mModeData != nil)
    {
        mModeData = nil;
    }
    mModeData = [NSMutableDictionary dictionaryWithDictionary:[mAcDB->mCurrentDB objectForKey:modeKeyWord]];//提取数据完成
}

#pragma mark --- Send
//设置有效数据内容
-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf
{
    int len = 0;
    unsigned char *Bufptr = NULL;
    unsigned char data = 0;
    Bufptr = Buf;
    NSNumber *TempData;
        
// Data1 噪声开关
    data = 0;
    
    data = [[mPublicData objectForKey:@"KDefaultIndoorNoiseOpen"] intValue];
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 2 预留
    data = 0;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 3 预留
    data = 0;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 4 预留
    data = 0;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 5 预留    
    data = 0;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 6 预留
    data = 0;
        
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 7 静音
    data = 0;
    
    TempData = [mModeData objectForKey:@"KDefaultSilence"];
    data |= ([TempData intValue] << 4) & 0xc0;//静音
    
    TempData = [mModeData objectForKey:@"KDefaultFanSpeed"];//风档
    switch ([TempData intValue])//风速
    {
        case 0://自动
        {
            data |= 0x00;
        }
            break;
        case 1://低风
        {
            data |= 0x01;
        }
            break;
        case 2://中风
        {
            data |= 0x02;
        }
            break;
        case 3://高风
        case 4:
        case 5:
        {
            data |= 0x03;
        }
            break;
        default:
            break;
    }
    
    //超强
    data |= [[mModeData objectForKey:@"KDefaultSpeed_High"] intValue] << 3;
    
    //多档风速
    data |= [TempData intValue];
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 8
    data = 0;
    
    TempData = [mPublicData objectForKey:@"KDefaultEnvCtrlPos"];//空调位置
    //NSLog(@"Setting Pos %d",[TempData intValue]);
    switch ([TempData intValue])
    {
        case 0:
        {
            data |= 0x10;//靠左
        }
            break;
        case 1:
        {
            data |= 0x20;//偏左
        }
            break;
        case 2:
        {
            data |= 0x00;//居中
        }
            break;
        case 3:
        {
            data |= 0x40;//偏右
        }
            break;
        case 4:
        {
            data |= 0x30;//靠右
        }
            break;
        default:
        {
            data |= 0x50;//无效
        }
            break;
    }
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 9
    data = 0;
    
    int FRoomSize = [[mPublicData objectForKey:@"KDefaultRoomLong"] floatValue] * 10;
    int decameter = FRoomSize / 10;
    int meter = FRoomSize % 10;
    data |= (decameter << 4) & 0xf0;
    data |= meter & 0x0f;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 10
    data = 0;
    
    FRoomSize = [[mPublicData objectForKey:@"KDefaultRoomWidth"] floatValue] * 10;
    decameter = FRoomSize / 10;
    meter = FRoomSize % 10;
    data |= (decameter << 4) & 0xf0;
    data |= meter & 0x0f;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;

// Data 11
    data = 0;
    
    FRoomSize = [[mPublicData objectForKey:@"KDefaultRoomHight"] floatValue] * 10;
    decameter = FRoomSize / 10;
    meter = FRoomSize % 10;
    data |= (decameter << 4) & 0xf0;
    data |= meter & 0x0f;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;

// Data 12
    data = 0;
    
    TempData = [mPublicData objectForKey:@"KDefaultCoolNoise"];
    data |= [TempData intValue] & 0xff;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 13
    data = 0;
    
    TempData = [mPublicData objectForKey:@"KDefaultHotNoise"];
    data |= [TempData intValue] & 0xff;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 14
    data = 0;
    
    TempData = [mPublicData objectForKey:@"KDefaultEnergySaver"];
    data |= [TempData intValue] & 0x01;
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
    return len;
    
}

#pragma mark --- REC
-(id)HandleTcpRecDate:(NSData *)adata  //接收空调回复数据
{
    unsigned char *Bufptr;
    unsigned char data = 0;
    [self UpDateNewDB];
    
    NSMutableDictionary *dic; //保存必要数据。
    dic = [[NSMutableDictionary alloc]initWithCapacity:64];
    
    Bufptr = (unsigned char *)[adata bytes];
    
    if ( Bufptr[3] == 0x33)
    {
        Bufptr += 4;   //去除头码
        Bufptr += 4;   //去除4个零
        
// Data1 噪声开关
        data = 0;
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultIndoorNoiseOpen" withDB:mAcDB.mModeDefaultDB];
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 2 预留
//        data = 0;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 3 预留
//        data = 0;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 4 预留
//        data = 0;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 5 预留
//        data = 0;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 6 预留
//        data = 0;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 7 静音
//        data = 0;
//        
//        TempData = [mModeData objectForKey:@"KDefaultSilence"];
//        data |= ([TempData intValue] << 4) & 0xc0;//静音
//        
//        TempData = [mModeData objectForKey:@"KDefaultFanSpeed"];//风档
//        switch ([TempData intValue])//风速
//        {
//            case 0://自动
//            {
//                data |= 0x00;
//            }
//                break;
//            case 1://低风
//            {
//                data |= 0x01;
//            }
//                break;
//            case 2://中风
//            {
//                data |= 0x02;
//            }
//                break;
//            case 3://高风
//            case 4:
//            case 5:
//            {
//                data |= 0x03;
//            }
//                break;
//            default:
//                break;
//        }
//        
//        //超强
//        data |= [[mPublicData objectForKey:@"KDefaultSpeed_High"] intValue] << 3;
//        
//        //多档风速
//        data |= [TempData intValue];
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 8
//        data = 0;
//        
//        TempData = [mPublicData objectForKey:@"KDefaultEnvCtrlPos"];//空调位置
//        //NSLog(@"Setting Pos %d",[TempData intValue]);
//        switch ([TempData intValue])
//        {
//            case 0:
//            {
//                data |= 0x10;//靠左
//            }
//                break;
//            case 1:
//            {
//                data |= 0x20;//偏左
//            }
//                break;
//            case 2:
//            {
//                data |= 0x00;//居中
//            }
//                break;
//            case 3:
//            {
//                data |= 0x40;//偏右
//            }
//                break;
//            case 4:
//            {
//                data |= 0x30;//靠右
//            }
//                break;
//            default:
//            {
//                data |= 0x50;//无效
//            }
//                break;
//        }
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 9
//        data = 0;
//        
//        int FRoomSize = [[mPublicData objectForKey:@"KDefaultRoomLong"] floatValue] * 10;
//        int decameter = FRoomSize / 10;
//        int meter = FRoomSize % 10;
//        data |= (decameter << 4) & 0xf0;
//        data |= meter & 0x0f;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 10
//        data = 0;
//        
//        FRoomSize = [[mPublicData objectForKey:@"KDefaultRoomWidth"] floatValue] * 10;
//        decameter = FRoomSize / 10;
//        meter = FRoomSize % 10;
//        data |= (decameter << 4) & 0xf0;
//        data |= meter & 0x0f;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 11
//        data = 0;
//        
//        FRoomSize = [[mPublicData objectForKey:@"KDefaultRoomHight"] floatValue] * 10;
//        decameter = FRoomSize / 10;
//        meter = FRoomSize % 10;
//        data |= (decameter << 4) & 0xf0;
//        data |= meter & 0x0f;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 12
//        data = 0;
//        
//        TempData = [mPublicData objectForKey:@"KDefaultCoolNoise"];
//        data |= [TempData intValue] & 0xff;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 13
//        data = 0;
//        
//        TempData = [mPublicData objectForKey:@"KDefaultHotNoise"];
//        data |= [TempData intValue] & 0xff;
//        
//        *Bufptr = data;
//        Bufptr += 1;
//        
//        // Data 14
//        data = 0;
//        
//        TempData = [mPublicData objectForKey:@"KDefaultEnergySaver"];
//        data |= [TempData intValue] & 0x01;
//        
//        *Bufptr = data;
//        Bufptr += 1;
        
        [mAcDB UpDataDBDidEnd];
        
        return dic; //返回
    }
    else
    {
        return nil;
    }
    
}


@end
