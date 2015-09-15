//
//  GEHexFactory.m
//  NewworkDemo
//
//  Created by gree's apple on 26/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEHexFactory.h"
#import "ControlFormatLists.h"
#import "AcData.h"
#import "AcData_sync.h"
#import "AcData_Control.h"
#import "AcData_Broadcast.h"
#import "VirtualDeviceProtocol.h"

@implementation GEHexFactory

-(NSData *)creatWithIdentify:(NSString *)identify withBL:(GEAirCDeviceInfoBL *)bl
{
    unsigned char buf[256];
    
    AcData *handler = [[AcData alloc] init];
    if ([identify isEqualToString:KAcDataControl]) {
        handler = [[AcData_Control alloc] init];
    }
    
    if ([identify isEqualToString:KAcDataBroadcast]) {
        handler = [[AcData_Broadcast alloc] init];
    }
    
    if ([identify isEqualToString:KAcSync]) {
        handler = [[AcData_sync alloc] init];
    }
    
    NSData *data = [handler TcpNwkBuildPacket:buf];
    
    NSLog(@"HEX Factory SendData : %@",data);
    
    return data;
}

-(id)parseWithData:(NSData *)data withBL:(id)bl
{
    unsigned char *buf;
    buf = (unsigned char *)[data bytes];
    
    AcData *handler = [[AcData alloc] init];
    if (buf[3] == 0x21) {                                                   //UDP Broadcast
        if ([bl conformsToProtocol:@protocol(VirtualDeviceProtocol)]) {
            handler = [[AcData_Broadcast alloc] initWithBL:bl];
        }else{
            [NSException raise:@"HEXPraseClassError" format:@"Class Cannot conforms To Protocol"];
        }
    }else if (buf[3] == 0x31 || buf[3] == 0x32) {                           //控制帧/同步帧
        handler = [[AcData_Control alloc] initWithBL:bl];
    }else if (buf[3] == 0x33) {                                             //设置帧
        
    }else if (buf[3] == 0x22) {                                             //用户请求登录
        
    }else if (buf[3] == 0x23) {                                             //用户请求登出
        
    }else if (buf[3] == 0x24) {                                             //空调名称
        
    }else if (buf[3] == 0x25) {                                             //用户名及密码
        
    }else if (buf[3] == 0x26) {                                             //配置空调网络信息
        
    }else if (buf[3] == 0x28) {                                             //恢复出厂
        
    }else{
        [NSException raise:@"UndefineFunCode" format:@"HEX Parse Error"];
        return nil;
    }
    
    [handler HandleRecDate:data];
    
    return nil;
}

@end
