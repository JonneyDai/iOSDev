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
#import "AcData_Control.h"
#import "AcData_Broadcast.h"
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
    
    
    NSData *data = [handler TcpNwkBuildPacket:buf];
    
    NSLog(@"HEX Factory SendData : %@",data);
    
    return data;
}

@end
