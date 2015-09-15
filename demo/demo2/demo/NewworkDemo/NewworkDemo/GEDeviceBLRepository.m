//
//  GEDeviceBLRepository.m
//  NewworkDemo
//
//  Created by gree's apple on 8/9/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEDeviceBLRepository.h"
#import "VirtualDeviceProtocol.h"

@implementation GEDeviceBLRepository

+ (GEDeviceBLRepository *)shareInstance
{
    static GEDeviceBLRepository *rp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rp = [[self alloc] init];
    });
    
    return rp;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        virtualDeviceRepository = [[NSMutableDictionary alloc] initWithCapacity:1];
        DeviceInfoDBRepository = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}

//删除方法
- (BOOL) removeByMac:(NSString *)mac
{
    if ([[virtualDeviceRepository allKeys] containsObject:mac]) {
        [virtualDeviceRepository removeObjectForKey:mac];
    }
    if ([[DeviceInfoDBRepository allKeys] containsObject:mac]) {
        [DeviceInfoDBRepository removeObjectForKey:mac];
    }
    
    return YES;
}

-(BOOL)clear
{
    [virtualDeviceRepository removeAllObjects];
    [DeviceInfoDBRepository removeAllObjects];
    
    return YES;
}

#pragma mark-
#pragma mark VirtualDevice Handler
//插入方法
- (void) addVirtualDeviceObj:(id<VirtualDeviceProtocol>)obj
{
    if([obj identify]){
        NSLog(@"addVirtualDeviceObj Success");
        [virtualDeviceRepository setObject:obj forKey:[obj identify]];
    }
}

//修改方法
- (BOOL) modifyVirtualDeviceObj:(id<VirtualDeviceProtocol>)obj byMac:(NSString *)mac
{
    if ([[virtualDeviceRepository allKeys] containsObject:mac]) {
        [virtualDeviceRepository setObject:obj forKey:mac];
        return YES;
    }else{
        [self addVirtualDeviceObj:obj];
        return NO;
    }
}

//按照主键查询数据方法
- (id<VirtualDeviceProtocol>) findVirtualDeviceByMac:(NSString *)mac
{
    return [virtualDeviceRepository objectForKey:mac];
}

//查询所有数据方法
- (NSMutableDictionary*) findAllVirtualDevice
{
    return virtualDeviceRepository;
}

#pragma mark-
#pragma mark DeviceInfoDB Handler
- (void) addDeviceInfoDBObj:(GEAirCDeviceInfoBL *)obj byMac:(NSString *)mac
{
    [DeviceInfoDBRepository setObject:obj forKey:mac];
}

- (BOOL) modifyDeviceInfoDBObj:(GEAirCDeviceInfoBL *)obj byMac:(NSString *)mac
{
    if ([[DeviceInfoDBRepository allKeys] containsObject:mac]) {
        [DeviceInfoDBRepository setObject:obj forKey:mac];
        return YES;
    }else{
        [self addDeviceInfoDBObj:obj byMac:mac];
        return NO;
    }
}

- (GEAirCDeviceInfoBL *) findDeviceInfoDBByMac:(NSString *)mac
{
    return [DeviceInfoDBRepository objectForKey:mac];
}

- (NSMutableDictionary*) findAllDeviceInfoDBDevice
{
    return DeviceInfoDBRepository;
}

@end
