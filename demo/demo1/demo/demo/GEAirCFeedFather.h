//
//  GEAirCFeedFather.h
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef GEAirCFeedFather_h
#define GEAirCFeedFather_h

/************************************************************************************/
/*  此类的作用是上继承GEFeedFather总数据库父类，下承接空调基本状态                          */
/************************************************************************************/

typedef enum
{
    S_Shut= 0,
    S_Auto,
    S_Silence,
}Silence;		//	静音

/************************************************************************************/
/*                          某些设备的风速有三档、七档，怎么破？                          */
/************************************************************************************/
typedef enum
{
    Speed_AUTO = 0,
    Speed_1,
    Speed_2,
    Speed_3,
    Speed_4,
    Speed_5,
}SPEED;     //	风速

typedef struct
{
    int mHour;
    int mMin;
    int mSec;
}TimerFormat;

typedef struct
{
    int UDSWindSide_Start;	//	上下扫风 1~5,默认时为0
    int UDSWindSide_End;
    int LRSWindSide_Start;		//	左右扫风
    int LRSWindSide_End;
}SwindModeIndex;

/*以下为空调公有数据*/
typedef enum
{
    H_Shut = 0,
    H_Continue,
    H_Aptitude,
    H_40,
    H_50,
    H_60,
    H_70,
}Humidification;	//	加湿

typedef enum
{
    V_Shut = 0,
    V_Inspiration,
    V_Exhaust,
}Ventilation;		//	换气

typedef enum
{
    He_Shut = 0,
    He_Heating,//辅热
    He_standard,//新国标辅热
}Heating;

/*********************************/
/*             定时               */
/*********************************/

typedef enum
{
    Timer_Mode_Once = 0,
    Timer_Mode_WorkDay,
    Timer_Mode_EveryDay,
    Timer_Mode_None,
}TimerMode;

typedef struct
{
    BOOL Timer_Sun;
    BOOL Timer_Mon;
    BOOL Timer_Tue;
    BOOL Timer_Wed;
    BOOL Timer_Thu;
    BOOL Timer_Fri;
    BOOL Timer_Sat;
}TimerWeekDay;

typedef struct
{
    TimerMode mfireMode;
    TimerWeekDay mWeekDay;
    TimerFormat mTimerFormat;
    
    BOOL mTimerOn;
}TimerData;

//空调位置
typedef enum
{
    EnvCtrl_Pos_1 = 0,
    EnvCtrl_Pos_2,
    EnvCtrl_Pos_3,
    EnvCtrl_Pos_4,
    EnvCtrl_Pos_5,
}EnvCtrlPos;

typedef enum
{
    ManCtrl_Pos_1 = 0,
    ManCtrl_Pos_2,
    ManCtrl_Pos_3,
    ManCtrl_Pos_4,
    ManCtrl_Pos_5,
    ManCtrl_Pos_6,
    ManCtrl_Pos_7,
    ManCtrl_Pos_8,
    ManCtrl_Pos_9,
}ManCtrlPos;

#endif


