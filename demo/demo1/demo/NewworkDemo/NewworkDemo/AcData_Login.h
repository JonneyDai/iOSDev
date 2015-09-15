//
//  AcData_Control.h
//  Remote
//
//  Created by gree's apple on 26/2/13.
//  Copyright (c) 2013 WJF-Monk  330694. All rights reserved.
//

#import "AcData.h"

@class DeviceNetWork;
@class DeviceData;
@class AirCondDB;

@interface AcData_Login : AcData
{
    NSData *TcpData;
    DeviceNetWork *mDeviceNetWork;
    DeviceData *mDeviceData;
    AirCondDB *mAcDB;
    NSMutableDictionary *mPublicData;
    NSMutableDictionary *mModeData;
}
@property (nonatomic) NSData *TcpData;

@end
