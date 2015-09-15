//
//  AcData.h
//  Remote
//
//  Created by gree's apple on 1/2/13.
//  Copyright (c) 2013 WJF-Monk  330694. All rights reserved.
//  只用于发送

#import <Foundation/Foundation.h>
#import "GEAirCDeviceInfoBL.h"
//@protocol VirtualDeviceProtocol;

//enum ControlType
//{
//    TcpControlType_sync = 0,  //同步帧         02
//    TcpControlType_Control,   //控制帧         01
//    TcpControlType_Setting,   //设置帧         03
//    TcpControlType_Login,     //用户请求登录    12
//    TcpControlType_Logout,    //用户请求登出    13
//    TcpControlType_AcName,    //空调名称       14
//    TcpControlType_UserAdmin, //用户名及密码    15
//    TcpControlType_WifiInfo,  //配置空调网络信息 16
//    TcpControlType_Restore,   //恢复出厂       18
//};

@interface AcData : NSObject   //准备使用工厂模式......此为对外接口
{
//    enum ControlType ControlState;
}
//@property (nonatomic) enum ControlType ControlState;

-(id)initWithBL:(GEAirCDeviceInfoBL *)BL;

//设置广播帧头字节数据
-(int)TcpNwkBuildHeaderFrame:(unsigned char *)Buf;

//设置有效数据内容
-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf;

//设置校验码数据
-(unsigned char)TcpNwkBuildCheckSum:(unsigned char *)Buf ForLength:(int)Len;

//设置数据包长度
-(void)TcpPacketLength:(unsigned char *)Buf ForLength:(int)Len;

//设置发送数据
-(NSData *)TcpNwkBuildPacket:(unsigned char *)Buf;

//格式转换
-(int)FillPacketWithString:(NSString *)str Buffer:(unsigned char *)Buf;



//解析回复数据
-(void)HandleRecDate:(NSData *)data;

@end
