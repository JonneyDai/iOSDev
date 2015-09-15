//
//  GEAirCPriInfo.h
//  NewArchitecture
//
//  Created by gree's apple on 5/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GEFeedFather.h"
/************************************************************************************/
/*       以下几层均是数据库，只提供对象，不涉及操作                                        */
/*       本类为空调模式私有数据，每个模式占有独自的数据                                     */
/* (_)由于没有办法确认所有空调都拥有这些数据，所有没办法做成Protocol，公有数据及设备状态同理(_)  */
/****  考虑到空调貌似状态都差不多，撑死就是添加删除功能。删除功能的话，就是对象成员不赋值即可！添加的话那就
    通过对象继承来扩展属性。 MONK 2015.8.6 自我反省 ****/
/************************************************************************************/



/************************************************************************************/
/*           属性设置为readonly是为了防止随意的改动数据，应当有一层是来更改此数据的。          */
/************************************************************************************/
@interface GEAirCPriFeed : GEFeedFather
//睡眠
@property (nonatomic,readonly) BOOL mSleepModeState;
@property (nonatomic,readonly) NSUInteger mSleepModeOpenID;
@property (nonatomic,readonly) NSMutableArray *mSleepModeData;
@property (nonatomic,readonly) TimerFormat mSleepOpenTimer;

//扫风
@property (nonatomic,readonly) BOOL mLRSwingON;
@property (nonatomic,readonly) BOOL mUDSwingON;
@property (nonatomic,readonly) SwindModeIndex mSwingModeIndex;

//风速档
@property (nonatomic,readonly) SPEED mFanSpeed;

//静音
@property (nonatomic,readonly) Silence mSilence;

//温度
@property (nonatomic,readonly) float mTemperature;

//星期 私有数据应该没有星期的需求
//@property (nonatomic,readonly) int mWeekDay;

//超强模式
@property (nonatomic,readonly) BOOL mSpeed_High;

@end
