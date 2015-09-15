//
//  AcData_Setting.h
//  Remote
//
//  Created by gree's apple on 23/1/14.
//  Copyright (c) 2014 WJF-Monk  330694. All rights reserved.
//

#import "AcData.h"
@class DeviceNetWork;
@class DeviceData;
@class AirCondDB;

@interface AcData_Setting : AcData
{
    DeviceNetWork *mDeviceNetWork;
    DeviceData *mDeviceData;
    AirCondDB *mAcDB;
    NSMutableDictionary *mPublicData;
    NSMutableDictionary *mModeData;
}
@end
