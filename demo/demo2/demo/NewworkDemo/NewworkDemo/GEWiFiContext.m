//
//  GEWiFiContext.m
//  NewArchitecture
//
//  Created by gree's apple on 13/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEWiFiContext.h"

@implementation GEWiFiContext
@synthesize mWifiInfo,mWiFiNetWorkStatus;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"mWifiInfo.ip"]) {
        mWifiInfo.ip = [value UTF8String];
    }else if ([key isEqualToString:@"mWifiInfo.port"]){
        mWifiInfo.port = [value UTF8String];
    }else if ([key isEqualToString:@"mWifiInfo.mac"]){
        mWifiInfo.mac = [value UTF8String];
    }else if ([key isEqualToString:@"mWifiInfo.mask"]){
        mWifiInfo.mask = [value UTF8String];
    }else if ([key isEqualToString:@"mWifiInfo.gate"]){
        mWifiInfo.gate = [value UTF8String];
    }else if ([key isEqualToString:@"mWifiInfo.dns"]){
        mWifiInfo.dns = [value UTF8String];
    }
    if ([key isEqualToString:@"mWiFiNetWorkStatus.isOnline"]){
        mWiFiNetWorkStatus.isOnline = [value intValue];
    }else if ([key isEqualToString:@"mWiFiNetWorkStatus.isLAN"]){
        mWiFiNetWorkStatus.isLAN = [value intValue];
    }
    
    
}

@end
