//
//  GEDeviceBLRepository.h
//  NewworkDemo
//
//  Created by gree's apple on 8/9/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VirtualDeviceProtocol;
@class GEAirCDeviceInfoBL;

@interface GEDeviceBLRepository : NSObject
{
    //这两个库在此，可以比较数目是否一样，不一样则认为需要重发或查询或提示
    @private
    NSMutableDictionary *virtualDeviceRepository;
    NSMutableDictionary *DeviceInfoDBRepository;
}
//移植到APPContext中
//@property (nonatomic, strong) NSString *excuteMac;    //当前mac，界面or后台需要发送数据的mac

+ (GEDeviceBLRepository *)shareInstance;

- (BOOL) removeByMac:(NSString *)mac;

- (BOOL)clear;

/*********************************************/
/*       这是虚拟设备状态信息，包括wifi之类的信息  */
/*********************************************/
- (void) addVirtualDeviceObj:(id<VirtualDeviceProtocol>)obj;

- (BOOL) modifyVirtualDeviceObj:(id<VirtualDeviceProtocol>)obj byMac:(NSString *)mac;

- (id<VirtualDeviceProtocol>) findVirtualDeviceByMac:(NSString *)mac;

- (NSMutableDictionary*) findAllVirtualDevice;

/*********************************************/
/*       这是虚拟设备状态信息，包括wifi之类的信息  */
/*********************************************/
- (void) addDeviceInfoDBObj:(GEAirCDeviceInfoBL *)obj byMac:(NSString *)mac;

- (BOOL) modifyDeviceInfoDBObj:(GEAirCDeviceInfoBL *)obj byMac:(NSString *)mac;

- (GEAirCDeviceInfoBL *) findDeviceInfoDBByMac:(NSString *)mac;

- (NSMutableDictionary*) findAllDeviceInfoDBDevice;

@end
