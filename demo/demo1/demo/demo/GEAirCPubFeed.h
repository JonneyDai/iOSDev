//
//  GEAirCPubInfo.h
//  NewArchitecture
//
//  Created by gree's apple on 5/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GEFeedFather.h"
/************************************************************************************/
/* 本来想每种类型的电器，使用协议来区分，但没找到各类型电器的特点，故没有让本类继承某协议          */
/* 此类为空调控制状态公有数据，每种模式均共用此数据*/
/************************************************************************************/

@interface GEAirCPubFeed : GEFeedFather
//    开关
@property (nonatomic,readonly) BOOL mPowerOn;

//    温度
@property (nonatomic,readonly) BOOL mTepUnitC;//摄氏

//    星期
@property (nonatomic,readonly) int mWeekDay;

//    定时开关信息
@property (nonatomic,readonly) TimerData mPowerOnTimer;
@property (nonatomic,readonly) TimerData mPowerOffTimer;

//    干燥信息
@property (nonatomic,readonly) BOOL mDrying;

//    辅热模式
@property (nonatomic,readonly) Heating mHeating;

//    净化模式
@property (nonatomic,readonly) BOOL mPurify;

//    灯光模式
@property (nonatomic,readonly) BOOL mLight;

//    换气模式
@property (nonatomic,readonly) Ventilation mVentilation;

//    加湿模式
@property (nonatomic,readonly) Humidification mHumidification;

//    区域选择
@property (nonatomic,readonly) BOOL mOpenEnvFun;	   //开启风吹人或风不吹人
@property (nonatomic,readonly) ManCtrlPos mManCtrlPos;

//    当前时刻
@property (nonatomic,readonly) int mTimerYear;//年份
@property (nonatomic,readonly) int mTimerMon;//月份
@property (nonatomic,readonly) int mTimerDay;//日
@property (nonatomic,readonly) int mTimerWeekDay;//当前星期信息
@property (nonatomic,readonly) TimerFormat mTimerFormat;//时间

//    空调位置
@property (nonatomic,readonly) EnvCtrlPos mEnvCtrlPos;//空调位置

//    房间信息
@property (nonatomic,readonly) float mRoomLong;
@property (nonatomic,readonly) float mRoomWidth;
@property (nonatomic,readonly) float mRoomHight;

//    噪声信息
@property (nonatomic,readonly) BOOL mIndoorNoiseOpen;
@property (nonatomic,readonly) int mIndoorCoolNoiseValue; // 22~38DB
@property (nonatomic,readonly) int mIndoorHotNoiseValue; // 29~39DB

//    节能导航
@property (nonatomic,readonly) BOOL mEnergySaver;

//    房间图标
@property (nonatomic,retain) UIImage *mDeviceIcon;

@end



