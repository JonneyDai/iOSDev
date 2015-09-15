//
//  GEAirCPropertyLists.h
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

/**************************************** */
/*   空调的所有属性值                        */
/*   有空把所有属性值变成string写在这，外部即可 */
/* 通过KVC直接设置了                         */
/****************************************  */

#ifndef GEAirCPropertyLists_h
#define GEAirCPropertyLists_h

/**************************Mode****************************/
//    提取出来的公共数据
static NSString *KAirCAutoMode = @"KAirCAutoMode";
static NSString *KAirCCoolMode = @"KAirCCoolMode";
static NSString *KAirCFanMode = @"KAirCFanMode";
static NSString *KAirCDryMode = @"KAirCDryMode";
static NSString *KAirCHotMode = @"KAirCHotMode";
static NSString *KAirCIFeelMode = @"KAirCIFeelMode";

static NSString *KAirCPublicData = @"KAirCPublicData";

/**************************Property****************************/

//    开关
static NSString *KAircPowerOn = @"mPowerOn";

//    温度
static NSString *KAircTemperatureUnitC = @"mTepUnitC";//摄氏

//    星期
static NSString *KAircWeekDay = @"mWeekDay";

//    定时开关信息
static NSString *KAircPowerOnTimer = @"mPowerOnTimer"; //TimerData Struct类型，可能需要扩张
static NSString *KAircPowerOffTimer = @"mPowerOffTimer";

//    干燥信息
static NSString *KAircDrying = @"mDrying";

//    辅热模式
static NSString *KAircHeating = @"mHeating";

//    净化模式
static NSString *KAircPurify = @"mPurify";

//    灯光模式
static NSString *KAircLight = @"mLight";

//    换气模式
static NSString *KAircVentilation = @"mVentilation";

//    加湿模式
static NSString *KAircHumidification = @"mHumidification";

//    区域选择
static NSString *KAircOpenEnvFun = @"mOpenEnvFun";	   //开启风吹人或风不吹人
static NSString *KAircManCtrlPos = @"mManCtrlPos";

//    当前时刻
static NSString *KAircTimerYear = @"mTimerYear";//年份
static NSString *KAircTimerMon = @"mTimerMon";//月份
static NSString *KAircTimerDay = @"mTimerDay";//日
static NSString *KAircTimerWeekDay = @"mTimerWeekDay";//当前星期信息
static NSString *KAircTimerFormat = @"mTimerFormat";//时间

//    空调位置
static NSString *KAircEnvCtrlPos = @"mEnvCtrlPos";//空调位置

//    房间信息
static NSString *KAircRoomLong = @"mRoomLong";
static NSString *KAircRoomWidth = @"mRoomWidth";
static NSString *KAircRoomHight = @"mRoomHight";

//    噪声信息
static NSString *KAircIndoorNoiseOpen = @"mIndoorNoiseOpen";
static NSString *KAircIndoorCoolNoiseValue = @"mIndoorCoolNoiseValue"; // 22~38DB
static NSString *KAircIndoorHotNoiseValue = @"mIndoorHotNoiseValue"; // 29~39DB

//    节能导航
static NSString *KAircEnergySaver = @"mEnergySaver";

//    房间图标
static NSString *KAirceviceIcon = @"mDeviceIcon";

//睡眠
static NSString *KAircSleepModeState = @"mSleepModeState";
static NSString *KAircSleepModeOpenID = @"mSleepModeOpenID";
static NSString *KAircSleepModeData = @"mSleepModeData";
static NSString *KAircSleepOpenTimer = @"mSleepOpenTimer";

//扫风
static NSString *KAircLRSwingON = @"mLRSwingON";
static NSString *KAircUDSwingON = @"mUDSwingON";
static NSString *KAircSwingModeIndex = @"mSwingModeIndex";

//风速档
static NSString *KAircFanSpeed = @"mFanSpeed";

//静音
static NSString *KAircSilence = @"mSilence";

//温度
static NSString *KAircTemperature = @"mTemperature";

//星期
//NSString * const mWeekDay = @"mWeekDay";

//超强模式
static NSString *KAircSpeed_High = @"mSpeed_High";

#endif

