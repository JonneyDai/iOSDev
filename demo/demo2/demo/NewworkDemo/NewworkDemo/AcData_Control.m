  //
//  AcData_Control.m
//  Remote
//
//  Created by 翁 健峰 on 13-7-28.
//  Copyright (c) 2013年 WJF-Monk  330694. All rights reserved.
//

#import "AcData_Control.h"
#import "GEAirCDeviceInfoBL.h"
#import "GEAirCFeedDAO.h"
#import "GEAirCPriFeed.h"
#import "GEAirCPubFeed.h"
#include <arpa/inet.h>
#import "GEAirCDeviceInfoBL.h"
#import "AppContext.h"

@interface AcData_Control()
{
    NSArray *unitCData;
    NSArray *unitFData;
    
    GEAirCFeedDAO *_dao;
    GEAirCDeviceInfoBL *_bl;
}

@end

@implementation AcData_Control
{
    int SetOnValue;
    int SetOffValue;
    BOOL synchronizedToPhone;
    NSDictionary *weekdayOnDic;
    NSDictionary *weekdayOffDic;
}

-(id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

-(id)initWithBL:(GEAirCDeviceInfoBL *)BL
{
    self = [super init];
    if (self)
    {
        _bl = BL;
        //更新所有数据
        [self UpDateNewDB];
        
        
        unitCData = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:160],[NSNumber numberWithInt:170],[NSNumber numberWithInt:180],[NSNumber numberWithInt:190],[NSNumber numberWithInt:200],[NSNumber numberWithInt:210],[NSNumber numberWithInt:220],[NSNumber numberWithInt:230],[NSNumber numberWithInt:240],[NSNumber numberWithInt:250],[NSNumber numberWithInt:260],[NSNumber numberWithInt:270],[NSNumber numberWithInt:280],[NSNumber numberWithInt:290],[NSNumber numberWithInt:300], nil];
        unitFData = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:61],[NSNumber numberWithInt:61],[NSNumber numberWithInt:62],[NSNumber numberWithInt:63],[NSNumber numberWithInt:64],[NSNumber numberWithInt:65],[NSNumber numberWithInt:66],[NSNumber numberWithInt:67],[NSNumber numberWithInt:68],[NSNumber numberWithInt:68],[NSNumber numberWithInt:69],[NSNumber numberWithInt:70],[NSNumber numberWithInt:71],[NSNumber numberWithInt:72],[NSNumber numberWithInt:73],[NSNumber numberWithInt:74],[NSNumber numberWithInt:75],[NSNumber numberWithInt:76],[NSNumber numberWithInt:77],[NSNumber numberWithInt:77],[NSNumber numberWithInt:78],[NSNumber numberWithInt:79],[NSNumber numberWithInt:80],[NSNumber numberWithInt:81],[NSNumber numberWithInt:82],[NSNumber numberWithInt:83],[NSNumber numberWithInt:84],[NSNumber numberWithInt:85],[NSNumber numberWithInt:86],[NSNumber numberWithInt:86], nil];
        
        weekdayOnDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"KDefaultPowerOnTimer_mWeekDay_Timer_Sun",@"1",
                                                                   @"KDefaultPowerOnTimer_mWeekDay_Timer_Mon",@"2",
                                                                   @"KDefaultPowerOnTimer_mWeekDay_Timer_Tue",@"3",
                                                                   @"KDefaultPowerOnTimer_mWeekDay_Timer_Wed",@"4",
                                                                   @"KDefaultPowerOnTimer_mWeekDay_Timer_Thu",@"5",
                                                                   @"KDefaultPowerOnTimer_mWeekDay_Timer_Fri",@"6",
                                                                   @"KDefaultPowerOnTimer_mWeekDay_Timer_Sat",@"7",nil];
        
        weekdayOffDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"KDefaultPowerOffTimer_mWeekDay_Timer_Sun",@"1",
                                                                    @"KDefaultPowerOffTimer_mWeekDay_Timer_Mon",@"2",
                                                                    @"KDefaultPowerOffTimer_mWeekDay_Timer_Tue",@"3",
                                                                    @"KDefaultPowerOffTimer_mWeekDay_Timer_Wed",@"4",
                                                                    @"KDefaultPowerOffTimer_mWeekDay_Timer_Thu",@"5",
                                                                    @"KDefaultPowerOffTimer_mWeekDay_Timer_Fri",@"6",
                                                                    @"KDefaultPowerOffTimer_mWeekDay_Timer_Sat",@"7",nil];
        
    }
    return self;
}

-(int)TcpNwkBuildHeaderFrame:(unsigned char *)Buf
{
    int len = 0;
    unsigned char *Bufptr = Buf;
    
    *Bufptr = 0x7E;//同步字
    len += 1;
    Bufptr ++;
    
    *Bufptr = 0x7E;//同步字
    len += 1;
    Bufptr ++;
    
    *Bufptr = 0;//长度
    len += 1;
    Bufptr ++;
    
    *Bufptr = 0x01;//命令字
    len += 1;
    Bufptr ++;
    
    return len;
}

-(void)UpDateNewDB
{
    //得到需要的mac储存库
    _dao = [_bl findByMac:[AppContext shareAppContext].currentMac];
    //根据当前模式，更新数据库对象
    [_dao findByMode:_dao._currentMode];
}

#pragma mark --- Send
//设置有效数据内容
-(int)TcpNwkBuildPacketFrame:(unsigned char *)Buf
{
    int len = 0;
    unsigned char *Bufptr = NULL;
    unsigned char data = 0;
    Bufptr = Buf;
    int TempIntData = 0;
    NSNumber *TempData;
    int ACPower = 0;
    BOOL TemperatureUnit = NO;//华氏度
    BOOL unitFState = NO;//接近点
    
    NSNumber *mPacketMode;
    BOOL isTimerValue = NO;
    
    /***/
    int intTemp;
    GEAirCPriFeed *priFeed = _dao._pri;
    GEAirCPubFeed *pubFeed = _dao._pub;
    /***/
    
// FM码
    *Bufptr = 0xaf;
    Bufptr += 1;
    len += 1;

// Data 2
    ACPower = [pubFeed mPowerOn];
    data = (ACPower << 7) & 0x80;                           //开关机
    NSString *mode = _dao._currentMode;                     //模式
    if ([mode isEqualToString:KAirCAutoMode]) {             //自动
        data |= 0x00;
    }else if([mode isEqualToString:KAirCCoolMode]){         //制冷
        data |= 0x10 & 0x70;
    }else if([mode isEqualToString:KAirCDryMode]){          //除湿
        data |= 0x20 & 0x70;
    }else if([mode isEqualToString:KAirCFanMode]){          //送风
        data |= 0x30 & 0x70;
    }else if([mode isEqualToString:KAirCHotMode]){          //制热
        data |= 0x40 & 0x70;
    }else{
        data |= 0x00;
    }
    
    intTemp = [priFeed mSleepModeState];
    if (intTemp == 1){
        intTemp = (int)[priFeed mSleepModeOpenID];
        switch (intTemp) {
            case 0: data |= 0x08; break;                    //DIY
            case 1: data |= 0x08; break;                    //睡1
            case 2: data |= 0x00; break;                    //睡2
            case 3: data |= 0x00; break;                    //睡眠4只判断data14
            default: data |= 0x00; break;
        }
    }else{
        data |= 0x00;
    }
       
    int LRSwing = [priFeed mLRSwingON];
    int UDSwing = [priFeed mUDSwingON];
    if ( (LRSwing == 1) || (UDSwing == 1) ){
        data |= 0x04;                                       //扫风
    } else {
        data |= 0x00;
    }
    
    intTemp = [priFeed mFanSpeed];
    switch (intTemp) {                                      //风速
        case 0: data |= 0x00; break;                        //自动
        case 1: data |= 0x01; break;                        //低风
        case 2:                                             //中风
        case 3: data |= 0x02; break;
        case 4:                                             //高风
        case 5: data |= 0x03; break;
        default:
            break;
    }
    
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    
// Data 3
    data = 0;
    TemperatureUnit = [pubFeed mTepUnitC];                  //温度单位
    float tempData = [priFeed mTemperature];                //温度
    intTemp = tempData*10;
    
    int TepData = 0;
    int index = 0;

    if (!TemperatureUnit){
        TepData = TempIntData/10 - 16;
        index = TepData;
    } else {                                                //华氏
        TepData = TempIntData/10 - 61;
        switch (TepData) {
            case 0: index = 0; unitFState = NO; break;      //61对应0
            case 1: index = 1; unitFState = NO; break;
            case 3: index = 2; unitFState = NO; break;
            case 5: index = 3; unitFState = NO; break;
            case 7: index = 4; unitFState = NO; break;
            case 8: index = 5; unitFState = NO; break;
            case 10: index = 6; unitFState = NO; break;
            case 12: index = 7; unitFState = NO; break;
            case 14: index = 8; unitFState = NO; break;
            case 16: index = 9; unitFState = NO; break;
            case 17: index = 10; unitFState = NO; break;
            case 19: index = 11; unitFState = NO; break;
            case 21: index = 12; unitFState = NO; break;
            case 23: index = 13; unitFState = NO; break;
            case 25: index = 14; unitFState = NO; break;
            case 2: index = 1; unitFState = YES; break;     //62
            case 4: index = 2; unitFState = YES; break;
            case 6: index = 3; unitFState = YES; break;
            case 9: index = 5; unitFState = YES; break;
            case 11: index = 6; unitFState = YES; break;
            case 13: index = 7; unitFState = YES; break;
            case 15: index = 8; unitFState = YES; break;
            case 18: index = 10; unitFState = YES; break;
            case 20: index = 11; unitFState = YES; break;
            case 22: index = 12; unitFState = YES; break;
            case 24: index = 13; unitFState = YES; break;
            default:
                break;
        }
    }
    data |= (index<<4) & 0xf0;
    
    int TimeOnNum = [pubFeed mPowerOnTimer].mTimerOn;
    int TimeOffNum = [pubFeed mPowerOffTimer].mTimerOn;
    
    if ( (TimeOnNum == YES) || (TimeOffNum == YES) ){
        data |= 0x08;                                       //有定时
        isTimerValue = YES;
    } else {
        data |= 0x00;                                       //无定时
        isTimerValue = NO;
    }
    
    /**时间定时bit3~bit0暂不处理**/
    *Bufptr = data;
    Bufptr += 1;
    len += 1;
    {
//// Data 4    
//    data = 0;
//    /**时间定时bit7~bit4暂不处理**/
//    switch ([mPacketMode intValue]) {
//        case 0:
//        case 3: data |= 0x00; break;                        //自动及送风置0
//        case 1:                                             //制冷
//        {
//            TempData = [mPublicData objectForKey:@"KDefaultDrying"];        //干燥
//            data |= ([TempData intValue] << 3) & 0x08;
//            TempData = [mModeData objectForKey:@"KDefaultSpeed_High"];      //超强
//            data |= [TempData intValue] & 0x01;
//        }
//            break;
//        case 2://除湿
//        {
//            TempData = [mPublicData objectForKey:@"KDefaultDrying"];//干燥
//            data |= ([TempData intValue] << 3) & 0x08;
//            
//            //TempData = [mPublicData objectForKey:@"KDefaultSpeed_High"];//超强
//            data |= 0 & 0x01;
//        }
//            break;
//        case 4://制热
//        {
//            TempData = [mPublicData objectForKey:@"KDefaultHeatHeating"];//辅热
////            if ([TempData intValue] == 1)//辅热关
////            {
////                data |= 0x08;
////            }
////            else
////            {
////                data |= 0x00;
////            }
//            if ([TempData intValue] == 0)//1为关闭 0为开启
//            {
//                data |= 0x08;//关闭
//            }
//            else
//            {
//                data |= 0x00;//开启
//            }
//            
//            TempData = [mModeData objectForKey:@"KDefaultSpeed_High"];//超强
//            data |= [TempData intValue] & 0x01;
//        }
//            break;
//        default:
//            break;
//    }
//    TempData = [mPublicData objectForKey:@"KDefaultPurify"];//健康充当净化
//    data |= ([TempData intValue] << 2) & 0x04;
//    
//    TempData = [mPublicData objectForKey:@"KDefaultLight"];//灯关
//    data |= ([TempData intValue] << 1) & 0x02;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 5    //bit6华氏度空缺，未添加
//    data = 0;
//
//    TempData = [mPublicData objectForKey:@"KDefaultTepUnitF"];//温度单位，华氏度为1，摄氏度是0
//    if ([TempData intValue] == 1)//华氏度
//    {
//        data |= 0x80;
//    }
//    else
//    {
//        data |= 0x00;
//    }
//    
//    if (!unitFState)//bit6相邻
//    {
//        data |= 0x00;
//    }
//    else
//    {
//        data |= 0x40;
//    }
//    
//    TempData = [mPublicData objectForKey:@"KDefaultVentilation"];//换气
//    data |= ([TempData intValue]<<4) & 0x30;
//    
//    data |= 0x02;//WiFi开关、WiFi出厂
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 6 扫风
//    data = 0;
//    //上下扫风
//    LRSwing = [mModeData objectForKey:@"KDefaultUDSwing_Start"];
//    UDSwing = [mModeData objectForKey:@"KDefaultUDSwing_End"];
//    if ( ([LRSwing intValue] == 0) && ([UDSwing intValue] == 0 ))//默认
//    {
//        data |= ([LRSwing intValue] << 4) & 0xf0;
//    }
//    else if ([LRSwing intValue] == [UDSwing intValue])//定格
//    {
//        data |= (([LRSwing intValue] + 1) << 4) & 0xf0;
//    }
//    else//扫风
//    {
//        data |= 0x10;
//    }
//    //左右扫风
//    LRSwing = [mModeData objectForKey:@"KDefaultLRSwing_Start"];
//    UDSwing = [mModeData objectForKey:@"KDefaultLRSwing_End"];
//    if ( ([LRSwing intValue] == 0) && ([UDSwing intValue] == 0 ))//默认
//    {
//        data |= [LRSwing intValue] & 0x0f;
//    }
//    else if ([LRSwing intValue] == [UDSwing intValue])//定格
//    {
//        data |= ([LRSwing intValue] + 1) & 0x0f;
//    }
//    else//扫风
//    {
//        data |= 0x01;
//    }
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 7
//    data = 0;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 8
//    data = 0;
//    
////    NSLog(@"vvvvvv %@",mPublicData);
//    TempData = [mPublicData objectForKey:@"KDefaultHumidification"];//加湿
//    if ([mPacketMode intValue] == AcMode_Dry)//除湿模式屏蔽加湿
//    {
//        if (ACPower == 0)//关机
//        {
//            data |= [TempData intValue] & 0x70;
//        }
//        else
//        {
//            data |= 0x00;
//        }
//        
//    }
//    else
//    {
//        data |= [TempData intValue] & 0x70;
//    }
//        
//    TempData = [mModeData objectForKey:@"KDefaultTemperature"];//温度
//    if (!TemperatureUnit)
//    {
//        TempIntData = [TempData floatValue]*10;
//        TepData = TempIntData % 10;
//        if (TepData == 5)//0.5度
//        {
//            data |= 0x08;
//        }
//        else
//        {
//            data |= 0x00;
//        }
//    }
//    else
//    {
//        data |= 0x00;
//    }
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 9
//    data = 0;
//
//    if ([mPacketMode intValue] == 4)//制热有效
//    {
//        TempData = [mPublicData objectForKey:@"KDefaultHeatHeating"];//辅热,与data4重复
//        if([TempData intValue] == 1)//辅热
//        {
//            data |= 0x00;
//        }
//        else if([TempData intValue] == 2)//新国标辅热
//        {
//            data |= 0x80;
//        }
//        else
//        {
//            data |= 0x00;//辅热关
//        }
//    }
//    else
//    {
//        data |= 0x00;
//    }
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 10 定时 剩余时刻
//    data = 0;
//    
//    /**当前时刻**/
//    //当前时刻
//    //星期信息
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
//    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDate *now=[NSDate date];
//    comps = [calendar components:unitFlags fromDate:now];
//    
//    int NowWeekDay = [comps weekday];//sunday是1
//    int NowHour = [comps hour];
//    int NowMin = [comps minute];
//    
//    /**当前时刻**/
//    
//    int hour = [[mPublicData objectForKey:@"KDefaultPowerOnTimer_mTimerFormat_Hour"] intValue];//设置的定时执行时间
//    int min = [[mPublicData objectForKey:@"KDefaultPowerOnTimer_mTimerFormat_Min"] intValue];
//    
//    /**功能需求，弃用**
//    int Sethour = [[mPublicData objectForKey:@"KDefaultPowerOnTimer_SettingTime_Hour"] intValue];//定时打开的时间
//    int SetMin = [[mPublicData objectForKey:@"KDefaultPowerOnTimer_SettingTime_Min"] intValue];
//    int SetTimeValue = (Sethour * 60 + SetMin)%256;
//    int TimeValue = (hour * 60 + min)%256;
//    ****/
////    int SetTimeValue = (NowHour * 60 + NowMin)%256;//当前时刻
////    int TimeValue = (hour * 60 + min)%256;//设置时刻
//    int SetTimeValue = (NowHour * 60 + NowMin);//当前时刻
//    int TimeValue = (hour * 60 + min);//设置时刻
//    
//    if ( (TimeValue - SetTimeValue) == 0)
//    {
//        TimeValue = 24*60;
//    }
//    else if ( (TimeValue - SetTimeValue) < 0)
//    {
//        TimeValue = 24*60 - SetTimeValue + TimeValue;
//    }
//    else
//    {
//        TimeValue = TimeValue - SetTimeValue;
//    }
//    
//    data = (TimeValue%256) & 0xff;//总分钟数，低位
//    *Bufptr = data;
//    //NSLog(@"Time %@",[NSData dataWithBytes:Bufptr length:1]);
//    Bufptr += 1;
//    len += 1;
//    
//// Data 11 
//    data = 0;
//    
//    if (isTimerValue == YES)
//    {
//        data |= 0x80;//只要开了定时就发每日循环
//    }
//    else
//    {
//        data |= 0x00;
//    }
//    
//    TimeValue = TimeValue/256;
//    data |= (TimeValue << 4) & 0xe0;//Bit7~Bit4，定时开高位
//    
//    hour = [[mPublicData objectForKey:@"KDefaultPowerOffTimer_mTimerFormat_Hour"] intValue];
//    min = [[mPublicData objectForKey:@"KDefaultPowerOffTimer_mTimerFormat_Min"] intValue];
//    
//    /**弃用**
//    Sethour = [[mPublicData objectForKey:@"KDefaultPowerOffTimer_SettingTime_Hour"] intValue];//定时打开的时间
//    SetMin = [[mPublicData objectForKey:@"KDefaultPowerOffTimer_SettingTime_Min"] intValue];
//    **弃用**/
//    SetTimeValue = (NowHour * 60 + NowMin);
//    TimeValue = (hour * 60 + min);
//    if ( (TimeValue - SetTimeValue) == 0)
//    {
//        TimeValue = 24*60;
//    }
//    else if ( (TimeValue - SetTimeValue) < 0)
//    {
//        TimeValue = 24*60 - SetTimeValue + TimeValue;
//    }
//    else
//    {
//        TimeValue = TimeValue - SetTimeValue;
//    }
//
//    
//    data |= (TimeValue%16) & 0x0f;//Bit3~Bit0，低位
////    NSLog(@"aaaa.  %d",data);
//    *Bufptr = data;
//    //NSLog(@"Time1 %@",[NSData dataWithBytes:Bufptr length:1]);
//    Bufptr += 1;
//    len += 1;
//
//// Data 12 定时关
//    data = 0;
////    NSLog(@"aaaa .. %d",TimeValue);
//    TimeValue = TimeValue/16;
////    NSLog(@"aaaa .. %d",TimeValue);
//    data = TimeValue & 0xff;//总分钟数，高位
//    
//    *Bufptr = data;
//    //NSLog(@"Time2 %@",[NSData dataWithBytes:Bufptr length:1]);
//    Bufptr += 1;
//    len += 1;
//    
//// Data 13 
//    data = 0;
//    
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_TimerOn"];//有无定时开
//    data |= ([TempData intValue] << 5) & 0x20;
//    
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_TimerOff"];//有无定时关
//    data |= ([TempData intValue] << 4) & 0x10;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 14 睡眠
//    data = 0;
//
//    TempData = [mModeData objectForKey:@"KDefaultSleepModeState"];
//    if ([TempData intValue] == 1)
//    {
//        TempData = [mModeData objectForKey:@"KDefaultSleepModeOpenID"];
//        switch ([TempData intValue]) {
//            case 0: //DIY
//            {
//                data |= 0x10;
//            }
//                break;
//            case 1: //睡1
//            {
//                data |= 0x00;
//            }
//                break;
//            case 2: //睡2
//            {
//                data |= 0x10;
//            }
//                break;
//            case 3: //睡4
//            {
//                data |= 0x80;
//            }
//                break;
//            default:
//            {
//                data |= 0x00;
//            }
//                break;
//        }
//    }
//    else
//    {
//        data |= 0x00;
//    }
//    
//    
//    TempData = [mModeData objectForKey:@"KDefaultSilence"];//静音
//    data |= [TempData intValue] & 0x0C;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//
//// Data 15 睡眠
//    data = 0;
//    
//    NSArray *DiyArr = [mModeData objectForKey:@"KDefaultSleepModeDIY"];
//    float eachData = [[DiyArr objectAtIndex:0] floatValue];
//    eachData /= 10;
//    int sendSleepData = eachData - 16;
//    data |= sendSleepData << 4;
//    
//    eachData = [[DiyArr objectAtIndex:1] floatValue];
//    eachData /= 10;
//    sendSleepData = eachData - 16;
//    data |= sendSleepData;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 16 
//    data = 0;
//    
//    TempData = [mModeData objectForKey:@"KDefaultFanSpeed"];//风速
//    data |= [TempData intValue] & 0x07;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 17 
//    data = 0;
//        
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 18 睡眠值
//    data = 0;
//    
//    eachData = [[DiyArr objectAtIndex:2] floatValue];
//    eachData /= 10;
//    sendSleepData = eachData - 16;
//    data |= sendSleepData << 4;
//    
//    eachData = [[DiyArr objectAtIndex:3] floatValue];
//    eachData /= 10;
//    sendSleepData = eachData - 16;
//    data |= sendSleepData;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 19
//    data = 0;
//    
//    eachData = [[DiyArr objectAtIndex:4] floatValue];
//    eachData /= 10;
//    sendSleepData = eachData - 16;
//    data |= sendSleepData << 4;
//    
//    eachData = [[DiyArr objectAtIndex:5] floatValue];
//    eachData /= 10;
//    sendSleepData = eachData - 16;
//    data |= sendSleepData;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 20
//    data = 0;
//    
//    eachData = [[DiyArr objectAtIndex:6] floatValue];
//    eachData /= 10;
//    sendSleepData = eachData - 16;
//    data |= sendSleepData << 4;
//    
//    eachData = [[DiyArr objectAtIndex:7] floatValue];
//    eachData /= 10;
//    sendSleepData = eachData - 16;
//    data |= sendSleepData;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 21
//    data = 0;
//        
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 22
//    data = 0;
//        
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 23 当前时刻值
//    data = 0;
//    
//    /**功能需求，弃用**
//    hour = [[mModeData objectForKey:@"KDefaultTimerFormat_mHour"] intValue];
//    min = [[mModeData objectForKey:@"KDefaultTimerFormat_mMin"] intValue];
//     ****/
//    TimeValue = (NowHour * 60 + NowMin)/256; //Bit23.0~23.2
//    data |= TimeValue & 0x07;//总分钟数，低位
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 24 当前时刻值
//    data = 0;
//    
//    TimeValue = (NowHour * 60 + NowMin)%256; //Bit24.0~24.7
//    data |= TimeValue & 0xff;//总分钟数，低位
//    
//    *Bufptr = data;
//    //NSLog(@"Time4 %@",[NSData dataWithBytes:Bufptr length:1]);
//    Bufptr += 1;
//    len += 1;
//    
//// Data 25 所有睡眠开时刻
//    data = 0;
//
//    hour = [[mModeData objectForKey:@"KDefaultSleepOpenTimer_mHour"] intValue];//时刻值
//    min = [[mModeData objectForKey:@"KDefaultSleepOpenTimer_mMin"] intValue];
//    TimeValue = (hour * 60 + min)/256; //Bit25.2~25.0
//    data |= TimeValue & 0x07;//总分钟数，低位
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 26 所有睡眠开时刻
//    data = 0;
//    
//    TimeValue = (hour * 60 + min)%256; //Bit26.0~26.7
//    data |= TimeValue & 0xff;//总分钟数，低位
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
//// Data 27 定时关时刻值
//    data = 0;
//    
//    TimeOnNum = [mPublicData objectForKey:@"KDefaultPowerOnTimer_TimerOn"];
//    TimeOffNum = [mPublicData objectForKey:@"KDefaultPowerOffTimer_TimerOff"];
//    if ( [TimeOnNum boolValue] == YES )
//    {
//        TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_fireMode"];
//        data |= ([TempData intValue] << 6) & 0xc0;//有定时
//    }
//    else
//    {
//        data |= 0xC0;//无定时
//    }
//    if ( [TimeOffNum boolValue] == YES )
//    {
//        TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_fireMode"];
//        data |= ([TempData intValue] << 4) & 0x30;//有定时
//    }
//    else
//    {
//        data |= 0x30;//无定时
//    }
//    
//    hour = [[mPublicData objectForKey:@"KDefaultPowerOffTimer_mTimerFormat_Hour"] intValue];//时刻值
//    min = [[mPublicData objectForKey:@"KDefaultPowerOffTimer_mTimerFormat_Min"] intValue];
//    TimeValue = (hour * 60 + min)/256; //Bit27.2~27.0
//    data |= TimeValue & 0x07;//总分钟数，高位
//    
//    *Bufptr = data;
//    //NSLog(@"Time5 %@",[NSData dataWithBytes:Bufptr length:1]);
//
//    Bufptr += 1;
//    len += 1;
//    
//// Data 28
//    data = 0;
//    
//    TimeValue = (hour * 60 + min)%256; //Bit27.2~27.0
//    data |= TimeValue & 0xff;//总分钟数，低位
//    //NSLog(@"Time6 %@",[NSData dataWithBytes:Bufptr length:1]);
//
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
////  Data 29 定时开时刻值
//    data = 0;
//    /**弃用***
//    TempData = [mModeData objectForKey:@"KDefaultWeekDay"];
//     ****/
//    
//    if (NowWeekDay == 1)//周日发码为7,机器中获取为1
//    {
//        data |= 0xe0;
//    }
//    else
//    {
//        data |= ((NowWeekDay - 1)<<5) & 0xe0;
//    }
//    
//    hour = [[mPublicData objectForKey:@"KDefaultPowerOnTimer_mTimerFormat_Hour"] intValue];
//    min = [[mPublicData objectForKey:@"KDefaultPowerOnTimer_mTimerFormat_Min"] intValue];
//    TimeValue = (hour * 60 + min)/256; //Bit29.2~27.0
//    data |= TimeValue & 0x07;//总分钟数，高位
//    //NSLog(@"hour min %d,%d,%d",hour,min,TimeValue);
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
////  Data 30 定时开时刻值
//    data = 0;
//    
//    TimeValue = (hour * 60 + min)%256;
//    data |= TimeValue & 0xff;//总分钟数，低位
//    //NSLog(@"hour min %d,%d,%d",hour,min,TimeValue);
//
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//
////  Data 31 定时开工作日
//    data = 0;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Sun"];
//    data |= ([TempData intValue] << 7) & 0x80;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Sat"];
//    data |= ([TempData intValue] << 6) & 0x40;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Fri"];
//    data |= ([TempData intValue] << 5) & 0x20;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Thu"];
//    data |= ([TempData intValue] << 4) & 0x10;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Wed"];
//    data |= ([TempData intValue] << 3) & 0x08;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Tue"];
//    data |= ([TempData intValue] << 2) & 0x04;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Mon"];
//    data |= ([TempData intValue] << 1) & 0x02;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//
////  Data 32 定时关工作日
//    data = 0;
//    
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Sun"];
//    data |= ([TempData intValue] << 7) & 0x80;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Sat"];
//    data |= ([TempData intValue] << 6) & 0x40;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Fri"];
//    data |= ([TempData intValue] << 5) & 0x20;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Thu"];
//    data |= ([TempData intValue] << 4) & 0x10;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Wed"];
//    data |= ([TempData intValue] << 3) & 0x08;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Tue"];
//    data |= ([TempData intValue] << 2) & 0x04;
//    TempData = [mPublicData objectForKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Mon"];
//    data |= ([TempData intValue] << 1) & 0x02;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//    
////  Data 33 区域
//    data = 0;
//    
//    TempData = [mPublicData objectForKey:@"KDefaultOpenEnvFun"];
//    data |= ([TempData intValue] << 1) & 0x02;//禁止吹人
//    
//    TempData = [mPublicData objectForKey:@"KDefaultManCtrlPos"];
//    if ([TempData intValue] == 256)//0~8
//    {
//        data |=  0x01; //区域9有效
//    }
//    else
//    {
//        data |=  0x00; //区域9无效
//    }
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
// 
////  Data 34 区域
//    data = 0;
//    
//    TempData = [mPublicData objectForKey:@"KDefaultManCtrlPos"];
////    if ([TempData intValue] < 8)
////    {
//        data |= [TempData intValue]; //区域9有效
////    }
////    else
////    {
////        data |= 0x00;
////    }
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
//
////  Data 35 预留
//    data = 0;
//    
//    *Bufptr = data;
//    Bufptr += 1;
//    len += 1;
    }
    
    return len;
    
}

#pragma mark --- REC
-(void)HandleRecDate:(NSData *)adata                       //接收空调回复数据
{
    Byte *buf;
    
    unsigned char data = 0;
    unsigned char Temp = 0;
    NSNumber *mPacketMode;
    BOOL SwingIsUsed;
    BOOL PacketSleepStatus = NO;
    BOOL TemperatureUnit = NO;
    BOOL unitFState = NO;
    float TemperatureValue = 0.0f;
    
    SetOnValue = 0;
    SetOffValue = 0;
    int HeatHeating = 0;                                     //辅热模式
    
    NSMutableDictionary *dic;                                //保存必要数据。
    dic = [[NSMutableDictionary alloc]initWithCapacity:64];
    
    buf = (Byte *)[adata bytes];

    if ( buf[3] == 0x31 || buf[3] == 0x32 )
    {
        buf += 4;                                            //去除头码
        
        buf += 4;                                            //去除4个零
// Data 5
        Temp = *buf;
        data = (Temp & 0x70)>>4;                             //模式
        if (data >= 5){
            data = 0;        //溢出
        }
        
        NSArray *keyarr = @[KAirCAutoMode,
                            KAirCCoolMode,
                            KAirCDryMode,
                            KAirCFanMode,
                            KAirCHotMode,
                            ];
        [_dao findByMode:[keyarr objectAtIndex:data]];       //_dao会自动记录当前模式
        
        data = (Temp & 0x80)>>4;                             //开关
        [_dao setStuff:[NSNumber numberWithBool:data] forKey:KAircPowerOn];
        
        PacketSleepStatus = (Temp & 0x08)>>3;                //睡眠
        [_dao setStuff:[NSNumber numberWithBool:PacketSleepStatus] forKey:KAircSleepModeState];
        
        data = Temp & 0x04;                                  //扫风
        SwingIsUsed = data;
        
        data = Temp & 0x03;                                  //风速
        
        buf += 1;
        
// Data 6
        data = 0;
        Temp = *buf;
        
        data = (Temp & 0xf0)>>4;                             //温度
        TemperatureValue = data;

        //此位好像没用
        data = Temp & 0x08;//有定时
      
        buf += 1;

        {
//// Data 7
//        data = 0;
//        /**时间定时bit7~bit4暂不处理**/
//        Temp = *buf;
//        
//        switch ([mPacketMode intValue])
//        {
//            case 0:
//            case 3://自动及送风置0
//            {
//                //data = Temp & 0x00;
////                [mAcDB setObject:[NSNumber numberWithInt:0] forKey:@"KDefaultDrying" withDB:mAcDB.mModeDefaultDB];
//                [mAcDB setObject:[NSNumber numberWithBool:0] forKey:@"KDefaultSpeed_High" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 1://制冷
//            {
//                data = (Temp & 0x08)>>3;//干燥
//                [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultDrying" withDB:mAcDB.mModeDefaultDB];
//                
//                data = Temp & 0x01;//超强
//                [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultSpeed_High" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 2://除湿
//            {
//                data = (Temp & 0x08)>>3;//干燥
//                [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultDrying" withDB:mAcDB.mModeDefaultDB];
//                
//                //data = Temp & 0x01;//超强
//                [mAcDB setObject:[NSNumber numberWithBool:0] forKey:@"KDefaultSpeed_High" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 4://制热
//            {                
//                //干燥
////                [mAcDB setObject:[NSNumber numberWithInt:0] forKey:@"KDefaultDrying" withDB:mAcDB.mModeDefaultDB];
//                
//                //辅热
//                data = (Temp & 0x08)>>3;
//                //NSLog(@"daadad %d",data);
//                HeatHeating = data;//0是开启，1为关闭
////                [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultHeatHeating" withDB:mAcDB.mModeDefaultDB];
//                
//                //超强
//                data = Temp & 0x01;
//                [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultSpeed_High" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            default:
//                break;
//        }
//        //健康充当净化
//        data = (Temp & 0x04)>>2;
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPurify" withDB:mAcDB->mModeDefaultDB];
//
//        //灯关
//        data = (Temp & 0x02)>>1;
//        [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultLight" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
//// Data 8    //bit6华氏度空缺，未添加
//        data = 0;
//        Temp = *buf;
//
//        //华氏度
//        data = (Temp & 0x80) >> 7;
//        TemperatureUnit = data;
//        [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultTepUnitF" withDB:mAcDB.mModeDefaultDB];
//        
//        //华氏相邻温度
//        data = (Temp & 0x40) >> 6;
//        unitFState = data;
//        
//        //换气
//        data = (Temp & 0x30)>>4;
//        //NSLog(@"aldsfjsdofd %d",data);
//        
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultVentilation" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
//// Data 9 扫风
//        data = 0;
//        Temp = *buf;
//        
//        //上下扫风
//        data = Temp & 0xf0;
//        switch (data)
//        {
//            case 0x00:
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x10://15扫风
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x20://定格1
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x30://定格2
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:2] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:2] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x40://定格3
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:3] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:3] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x50://定格4
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:4] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:4] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x60://定格5removeObjectAtIndex
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x70://35扫风
//            case 0x80://25扫风
//            case 0x90://24扫风
//            case 0xa0://14扫风
//            case 0xb0://13扫风
//            {   //功能需求，均发15扫风
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultUDSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultUDSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultUDSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            default:
//                break;
//        }
//        
//        //左右扫风
//        data = Temp & 0x0f;
//        switch (data)
//        {
//            case 0x00:
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x01://同向扫风
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x02://定格1
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x03://定格2
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:2] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:2] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x04://定格3
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:3] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:3] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x05://定格4
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:4] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:4] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x06://定格5
//            {
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:NO] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            case 0x0c://15扫风
//            case 0x0d://相向扫风
//            {   //功能需求，均发15扫风
//                [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultLRSwing_Start" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithInt:5] forKey:@"KDefaultLRSwing_End" withModeDB:mAcDB->mCurrentDB];
//                [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultLRSwing" withModeDB:mAcDB->mCurrentDB];
//            }
//                break;
//            default:
//                break;
//        }
//        
//        buf += 1;
//        
//// Data 10
//        data = 0;
//        Temp = *buf;
//        
//        buf += 1;
//        
//// Data 11
//        data = 0;
//        Temp = *buf;
//
//        //加湿
//        data = Temp & 0x70;
//        if ([mPacketMode intValue] != AcMode_Dry)
//        {
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultHumidification" withDB:mAcDB->mModeDefaultDB];
//        }
//
//        //温度0.5
//           
//        data = (Temp & 0x08)>>3;
//        //NSLog(@"Temperature2222 ...... %d",data);
//        if (TemperatureUnit == YES)//华氏度
//        {
//            if (unitFState == YES)//大值
//            {
//                int index = (int)TemperatureValue * 2 + 1;
//                TemperatureValue = [[unitFData objectAtIndex:index] floatValue];
//            }
//            else
//            {
//                int index = (int)TemperatureValue * 2;
//                TemperatureValue = [[unitFData objectAtIndex:index] floatValue];
//            }
//        }
//        else//摄氏度
//        {
//            if (data == 1)//带小数点
//            {
//                TemperatureValue += (16 + 0.5f);//C.5
//            }
//            else
//            {
//                TemperatureValue += 16;//C
//            }
//        }
//        NSLog(@"unitFF %f",TemperatureValue);
//        [mAcDB setObject:[NSNumber numberWithFloat:TemperatureValue] forKey:@"KDefaultTemperature" withModeDB:mAcDB->mCurrentDB];
//        
//        buf += 1;
//        
//// Data 12
//        data = 0;
//        Temp = *buf;
//        
//        //辅热,与data4重复
//        if ([mPacketMode intValue] == 4)//制热有效
//        {
//            if (HeatHeating == 0)//开启
//            {
//                data = (Temp & 0x80)>>7;
//                if (data == 1)//新国标辅热
//                {
//                    data = 2;
//                }
//                else if (data == 0)//非新辅热
//                {
//                    data = 1;
//                }
//            }
//            else
//            {
//                data = 0;
//            }
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultHeatHeating" withDB:mAcDB.mModeDefaultDB];
//        }
//        
//        buf += 1;
//        
//// Data 13 定时剩余时间
//        data = 0;
//        Temp = *buf;
//        long PowerOnValue = 0;
//        
//        int hour = 0;//[[mModeData objectForKey:@"KDefaultPowerOnTimer_mTimerFormat_Hour"] intValue];
//        int min = 0;//[[mModeData objectForKey:@"KDefaultPowerOnTimer_mTimerFormat_Min"] intValue];
//        //NSLog(@"a %hhu",Temp);
////        hour = Temp/60;
////        min = Temp%60;
//        PowerOnValue = Temp;
//
//        buf  += 1;
//        
//// Data 14
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0x70;//定时开高位          
//        PowerOnValue += data<<4;
//        hour = PowerOnValue/60;
//        min = PowerOnValue%60;
//        //NSLog(@"b %d",hour);
//        //NSLog(@"b %d",min);
////        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultPowerOnTimer_mTimerFormat_Min" withDB:mAcDB.mModeDefaultDB];
////        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultPowerOnTimer_mTimerFormat_Hour" withDB:mAcDB.mModeDefaultDB];
//        SetOnValue = PowerOnValue;
//        
//        hour = 0;
//        min = 0;
//        PowerOnValue = 0;
//        PowerOnValue = Temp & 0x0f;//Bit3~Bit0，定时关低位
//        
//        buf += 1;
//        
//// Data 15 定时关
//        data = 0;
//        Temp = *buf;
//        
//        PowerOnValue += Temp<<4;
//        hour = PowerOnValue/60;
//        min = PowerOnValue%60;
//        //NSLog(@"b %d",hour);
//        //NSLog(@"b %d",min);
////        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Hour" withDB:mAcDB.mModeDefaultDB];
////        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Min" withDB:mAcDB.mModeDefaultDB];
//        SetOffValue = PowerOnValue;
//        
//        buf += 1;
//        
//// Data 16
//        data = 0;
//        Temp = *buf;
//        
//        //有无定时开
//        data = Temp & 0x20;
//        [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_TimerOn" withDB:mAcDB.mModeDefaultDB];
//        //有无定时关
//        data = Temp & 0x10;
//        [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOffTimer_TimerOff" withDB:mAcDB.mModeDefaultDB];
//
//        buf += 1;
//        
//// Data 17 睡眠
//        data = 0;
//        Temp = *buf;
//        //NSLog(@"aa %d",Temp);
//        
////        int sleepStatus = [[mModeData objectForKey:@"KDefaultSleepModeState"] intValue];//BIT 2.3
//        
//        data = Temp & 0xf0;
//        if (data == 0x80)//睡4    Bit2.3~1 Bit17.4~8
//        {
//            [mAcDB setObject:[NSNumber numberWithInt:3] forKey:@"KDefaultSleepModeOpenID" withModeDB:mAcDB->mCurrentDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultSleepModeState" withModeDB:mAcDB->mCurrentDB];
//        }
//        else
//        {
//            if (PacketSleepStatus == 1)//Bit2.3~~1
//            {
//                switch (data)
//                {
//                    case 0x10: //DIY    Bit2.3~1 Bit17.4~1
//                    {
//                        [mAcDB setObject:[NSNumber numberWithInt:0] forKey:@"KDefaultSleepModeOpenID" withModeDB:mAcDB->mCurrentDB];
//                    }
//                        break;
//                    case 0x00: //睡1    Bit2.3~1 Bit17.4~0
//                    {
//                        [mAcDB setObject:[NSNumber numberWithInt:1] forKey:@"KDefaultSleepModeOpenID" withModeDB:mAcDB->mCurrentDB];
//                    }
//                        break;
//                }
//            }
//            else
//            {
//                if (data == 0x10)//睡2    Bit2.3~0 Bit17.4~1
//                {
//                    [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultSleepModeState" withModeDB:mAcDB->mCurrentDB];
//                    [mAcDB setObject:[NSNumber numberWithInt:2] forKey:@"KDefaultSleepModeOpenID" withModeDB:mAcDB->mCurrentDB];
//                }
//                else
//                {
//                    [mAcDB setObject:[NSNumber numberWithInt:0] forKey:@"KDefaultSleepModeOpenID" withModeDB:mAcDB->mCurrentDB];
//
//                }
//            }
//        }
//                   
//        //静音
//        data = Temp & 0x0C;
//        //NSLog(@"aa %d",data);
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultSilence" withModeDB:mAcDB->mCurrentDB];
//        
//        buf += 1;
//        
//// Data 18 睡眠
//        data = 0;
//        Temp = *buf;
//        
//        NSMutableArray *DiyArr = [[NSMutableArray alloc]initWithCapacity:10];
//        //[mModeData objectForKey:@"KDefaultSleepModeDIY"];
//        data = (Temp & 0xf0) >> 4;
//        int DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWithInt:DiyData]];
//        
//        data = Temp & 0x0f;
//        DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWithInt:DiyData]];
//        
//        buf += 1;
//        
//// Data 19
//        data = 0;
//        Temp = *buf;
//
//        //风速
//        data = Temp & 0x07;
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultFanSpeed" withModeDB:mAcDB->mCurrentDB];
//
//        buf += 1;
//        
//// Data 20
//        data = 0;
//        Temp = *buf;
//
//        buf += 1;
//        
//// Data 21 睡眠值
//        data = 0;
//        Temp = *buf;
//
//        //[mModeData objectForKey:@"KDefaultSleepModeDIY"];
//        data = (Temp & 0xf0) >> 4;
//        DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWithInt:DiyData]];
//        
//        data = Temp & 0x0f;
//        DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWithInt:DiyData]];
//        
//        buf += 1;
//        
//// Data 22
//        data = 0;
//        Temp = *buf;
//        
//        //[mModeData objectForKey:@"KDefaultSleepModeDIY"];
//        data = (Temp & 0xf0) >> 4;
//        DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWit9637846465767667676hInt:DiyData]];
//        
//        data = Temp & 0x0f;
//        DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWithInt:DiyData]];
//        
//        buf += 1;
//        
//// Data 23
//        data = 0;
//        Temp = *buf;
//        
//        //[mModeData objectForKey:@"KDefaultSleepModeDIY"];
//        data = (Temp & 0xf0) >> 4;
//        DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWithInt:DiyData]];
//        
//        data = Temp & 0x0f;
//        DiyData = (data + 16)*10;
//        [DiyArr addObject:[NSNumber numberWithInt:DiyData]];
//        
//        [DiyArr addObject:[NSNumber numberWithInt:0]];//人为添加
//        
//        [mAcDB setObject:DiyArr forKey:@"KDefaultSleepModeDIY" withModeDB:mAcDB->mCurrentDB];
//        
//        buf += 1;
//        
//// Data 24
//        data = 0;
//        Temp = *buf;
//        
//        buf += 1;
//        
//// Data 25
//        data = 0;
//        Temp = *buf;
//        
//        buf += 1;
//        
//// Data 26 当前时刻值
//        data = 0;
//        Temp = *buf;
//        
//        hour = 0;
//        min = 0;
//        min = Temp & 0x07;
//        
//        buf += 1;
//        
//// Data 27 当前时刻值
//        data = 0;
//        Temp = *buf;
//        
//        long TimeData = Temp << 4;
//        data = TimeData + min;
//        hour = data / 60;
//        min = data % 60;
//        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultTimerFormat_mHour" withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultTimerFormat_mMin" withDB:mAcDB.mModeDefaultDB];
//
//        buf += 1;
//        
//// Data 28 所有睡眠开时刻
//        data = 0;
//        Temp = *buf;
//        
//        Byte bb = *buf;
//        if (bb == 0x80) {
//            synchronizedToPhone = NO;
//        }else{
//            synchronizedToPhone = YES;
//        }
//        
//        hour = 0;
//        min = 0;
//        min = Temp & 0x07;
//
//        buf += 1;
//        
//// Data 29 所有睡眠开时刻
//        data = 0;
//        Temp = *buf;
//        
//        TimeData = Temp + (min << 8);
//        hour = TimeData / 60;
//        min = TimeData % 60;
//        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultSleepOpenTimer_mHour" withModeDB:mAcDB->mCurrentDB];
//        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultSleepOpenTimer_mMin" withModeDB:mAcDB->mCurrentDB];
//        
//
//        buf += 1;
//        
//// Data 30 定时开关、关时刻值
//        data = 0;
//        Temp = *buf;
//
//        data = Temp & 0xc0;
//        int TimerOnValue = data>>6;
//        //NSLog(@"Timervalue %d",TimerOnValue);
//        [mAcDB setObject:[NSNumber numberWithInt:TimerOnValue] forKey:@"KDefaultPowerOnTimer_fireMode" withDB:mAcDB.mModeDefaultDB];
//
//        data = Temp & 0x30;
//        int TimerOffValue = data>>4;
//        //NSLog(@"Timervalue %d",TimerOnValue);
//        [mAcDB setObject:[NSNumber numberWithInt:TimerOffValue] forKey:@"KDefaultPowerOffTimer_fireMode" withDB:mAcDB.mModeDefaultDB];
//        
//        data = Temp & 0x07;
//        hour = 0;
//        min = data;
////        NSLog(@"data ....%d",min);
//        
//        buf += 1;
//        
//// Data 31
//        data = 0;
//        Temp = *buf;
//        
//        TimeData = Temp + (min << 8);
////        NSLog(@"data ....%d",min<<8);
////        NSLog(@"data ....%d",Temp);
////        NSLog(@"data ....%ld",TimeData);
//        hour = TimeData / 60;
//        min = TimeData % 60;
//        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Hour" withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Min" withDB:mAcDB.mModeDefaultDB];
//        /**弃用**
//        if ( (SetOffValue + TimeData)> 1440 )
//        {
//            SetOffValue = 24 - SetOffValue - TimeData;
//        }
//        else
//        {
//            SetOffValue = SetOffValue + TimeData;
//        }
//        hour = SetOffValue / 60;
//        min = SetOffValue % 60;
//        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Hour" withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Min" withDB:mAcDB.mModeDefaultDB];
//        *****/
//        buf += 1;
//        
////  Data 32 定时开时刻值
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xe0;
//        /*弃用*/
//        /*兼容过程会出bug，先按发码日期换做单次开日期*/
//        //[mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultWeekDay" withModeDB:mAcDB->mCurrentDB];
//        
//        
//        data = Temp & 0x07;//Bit32.2~32.0
//        hour = 0;
//        min = data;
//        
//        buf += 1;
//        
////  Data 33 定时开时刻值
//        data = 0;
//        Temp = *buf;
//        
//        TimeData = Temp + (min<<8);
////        NSLog(@"data ....%d",min<<8);
////        NSLog(@"data ....%d",Temp);
////        NSLog(@"data ....%hhu",data);
//        hour = TimeData / 60;
//        min = TimeData % 60;
//        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultPowerOnTimer_mTimerFormat_Hour" withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultPowerOnTimer_mTimerFormat_Min" withDB:mAcDB.mModeDefaultDB];
//        /**弃用**
//        if ( (SetOnValue + data)> 1440 )
//        {
//            SetOnValue = 24 - SetOnValue - data;
//        }
//        else
//        {
//            SetOnValue = SetOnValue + data;
//        }
//        hour = SetOnValue / 60;
//        min = SetOnValue % 60;
//        [mAcDB setObject:[NSNumber numberWithInt:hour] forKey:@"KDefaultPowerOffTimer_SettingTime_Hour" withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:min] forKey:@"KDefaultPowerOffTimer_SettingTime_Min" withDB:mAcDB.mModeDefaultDB];
//        *****/
//        buf += 1;
//        
////  Data 34 定时开工作日
//        data = 0;
//        Temp = *buf;
////        if (TimerOnValue == 0x01)//自定义周期
//        {
//            data = (Temp & 0x80 )>>7;
//            [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Sun" withDB:mAcDB.mModeDefaultDB];
//
//            data = (Temp & 0x40 )>>6;
//            [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Sat" withDB:mAcDB.mModeDefaultDB];
//
//            data = (Temp & 0x20 )>>5;
//            [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Fri" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x10 )>>4;
//            [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Thu" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp& 0x08 )>>3;
//            [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Wed" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x04 )>>2;
//            [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Tue" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x02 )>>1;
//            [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Mon" withDB:mAcDB.mModeDefaultDB];
//        }
//        /******关闭定时不清此数据，不存在一次定时*****
//        else if (TimerOnValue == 0x02)//每天
//        {
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Sun" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Sat" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Fri" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Thu" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Wed" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Tue" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOnTimer_mWeekDay_Timer_Mon" withDB:mAcDB.mModeDefaultDB];
//        }
//        else if (TimerOnValue == 0x00 || TimerOnValue == 0x03)
//        {
//            
//        }
//        **************/
//        buf += 1;
//        
////  Data 35 定时关工作日
//        data = 0;
//        Temp = *buf;
////        if (TimerOffValue == 0x10)//自定义周期
//        {
//            data = (Temp & 0x80 )>>7;
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Sun" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x40 )>>6;
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Sat" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x20 )>>5;
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Fri" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x10 )>>4;
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Thu" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp& 0x08 )>>3;
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Wed" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x04 )>>2;
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Tue" withDB:mAcDB.mModeDefaultDB];
//            
//            data = (Temp & 0x02 )>>1;
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Mon" withDB:mAcDB.mModeDefaultDB];
//        }
//        /***开关机不清除***
//        else if (TimerOffValue == 0x20)
//        {
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Sun" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Sat" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Fri" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Thu" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Wed" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Tue" withDB:mAcDB.mModeDefaultDB];
//            [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:@"KDefaultPowerOffTimer_mWeekDay_Timer_Mon" withDB:mAcDB.mModeDefaultDB];
//        }
//        ******/
//        buf += 1;
//        
////  Data 36 区域
//        data = 0;
//        Temp = *buf;
//        
//        data = (Temp & 0x02)>>1;//禁止吹人
//        [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultOpenEnvFun" withDB:mAcDB.mModeDefaultDB];
//        
//        data = Temp & 0x01; //区域9有效
//        if (data != 0)
//        {
//            [mAcDB setObject:[NSNumber numberWithInt:256] forKey:@"KDefaultManCtrlPos" withDB:mAcDB.mModeDefaultDB];
//        }
//        else
//        {
//            [mAcDB setObject:[NSNumber numberWithInt:0] forKey:@"KDefaultManCtrlPos" withDB:mAcDB.mModeDefaultDB];
//        }
//
//        buf += 1;
//        
////  Data 37 区域
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xff; //区域9有效
//        if (data != 0)
//        {
//            [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultManCtrlPos" withDB:mAcDB.mModeDefaultDB];
//        }
//
//        buf += 1;
//        
////  Data 38 预留
//        data = 0;
//        Temp = *buf;
//        
//        buf += 1;
//        
////  Data 39 噪声
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0x01;
//        [mAcDB setObject:[NSNumber numberWithBool:data] forKey:@"KDefaultIndoorNoiseOpen" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
////  Data 40 空调位置
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xf0;
//        int position = 0;
//        switch (data)
//        {
//            case 0x10://靠左
//            {
//                position = 0;
//            }
//                break;
//            case 0x20://偏左
//            {
//                position = 1;
//            }
//                break;
//            case 0x00://居中
//            {
//                position = 2;
//            }
//                break;
//            case 0x40://偏右
//            {
//                position = 3;
//            }
//                break;
//            case 0x30://靠右
//            {
//                position = 4;
//            }
//                break;
//                
//            default://无效
//            {
//                position = 3;
//            }
//                break;
//        }
//        [mAcDB setObject:[NSNumber numberWithInt:position] forKey:@"KDefaultEnvCtrlPos" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
////  Data 41 房间位置
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xff;
//        int decameter = (data & 0xf0) >> 4;
//        int meter = data & 0x0f;
//        float RoomValue = (decameter + (meter * 0.1));
//        //NSLog(@"mmmmmm ROom111 %f",RoomValue);
//        [mAcDB setObject:[NSNumber numberWithFloat:RoomValue] forKey:@"KDefaultRoomLong" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
////  Data 42 房间位置
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xff;
//        decameter = (data & 0xf0) >> 4;
//        meter = data & 0x0f;
//        RoomValue = (decameter + (meter * 0.1));
//        //NSLog(@"mmmmmm ROom222 %f",RoomValue);
//        [mAcDB setObject:[NSNumber numberWithFloat:RoomValue] forKey:@"KDefaultRoomWidth" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
////  Data 43 房间位置
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xff;
//        decameter = (data & 0xf0) >> 4;
//        meter = data & 0x0f;
//        RoomValue = decameter + (meter * 0.1);
//        //NSLog(@"mmmmmm ROom333 %f",RoomValue);
//        [mAcDB setObject:[NSNumber numberWithFloat:RoomValue] forKey:@"KDefaultRoomHight" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
////  Data 44 制冷噪声值
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xff;
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultCoolNoise" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
////  Data 45 制热噪声值
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xff;
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultHotNoise" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//        
////  Data 46 节能导航
//        data = 0;
//        Temp = *buf;
//        
//        data = Temp & 0xff;
//        [mAcDB setObject:[NSNumber numberWithInt:data] forKey:@"KDefaultEnergySaver" withDB:mAcDB.mModeDefaultDB];
//        
//        buf += 1;
//    
//        //NSLog(@"距离开机时间：%d, 距离关机时间：%d,是否是手机控制：%d",SetOnValue,SetOffValue,synchronizedToPhone);
//        if (!synchronizedToPhone) { //通过遥控器控制
//            [self adjustPhoneTimeWhenRemotlyControlled];//设定手机端同步定时开关机
//        }
    }
//        [mAcDB UpDataDBDidEnd];
        NSLog(@"_dao._pri %d",_dao._pri.mFanSpeed);
        NSLog(@"_dao._pub %d",_dao._pub.mPowerOn);
        NSLog(@"_dao.mode %@",_dao._currentMode);

        [_bl sendMessage:BLMessageEvt_UpdataSuccess];
    }

}
//修改Bug：遥控器更改预约时，手机无法同步显示时间
-(void)adjustPhoneTimeWhenRemotlyControlled
{
    NSString *currentTime = [self getCurrentTime];
    NSLog(@"CALENDAR === %@",currentTime);
    NSArray *timeComponents = [currentTime componentsSeparatedByString:@":"];
    int hour = [timeComponents[0] intValue]; //当前时间的小时
    int min = [timeComponents[1] intValue]; //当前时间的分钟
    int weekday = [timeComponents[2] intValue];
    
    if (SetOnValue > 0) {
//        int leftHour,leftMin;
//        NSString *weekdayKey;
//        int totalMinutes = hour * 60 + min + SetOnValue;//当天已经经历的分钟数加上预约剩余的分钟数
//        if (totalMinutes >= 24 * 60) { //定时位于第二天
//            int leftMinuts = totalMinutes - 24 * 60;
//            leftHour = leftMinuts / 60;
//            leftMin = leftMinuts % 60;
//            //周几要加一
//            weekdayKey = [[NSString alloc]initWithFormat:@"%d",(weekday+1)%7];
//        }else{
//            leftHour = totalMinutes / 60;
//            leftMin = totalMinutes % 60;
//            weekdayKey = [[NSString alloc]initWithFormat:@"%d",weekday];
//        }
//        NSString *weekdayValue = [weekdayOnDic valueForKey:weekdayKey];
//        NSLog(@"WEEKDAYONVALUE === %@",weekdayValue);
//        [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:weekdayValue withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:leftHour] forKey:@"KDefaultPowerOnTimer_mTimerFormat_Hour" withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:leftMin] forKey:@"KDefaultPowerOnTimer_mTimerFormat_Min" withDB:mAcDB.mModeDefaultDB];
//    }
//    if(SetOffValue > 0){
//        int leftHour,leftMin;
//        NSString *weekdayKey;
//        int totalMinutes = hour * 60 + min + SetOffValue;
//        //NSLog(@"TOTAL OFF TIME == %d",totalMinutes);
//        if (totalMinutes >= 24 * 60) {
//            int leftMinuts = totalMinutes - 24 * 60;
//            leftHour = leftMinuts / 60;
//            leftMin = leftMinuts % 60;
//            weekdayKey = [[NSString alloc]initWithFormat:@"%d",(weekday+1)%7];
//        }else{
//            leftHour = totalMinutes / 60;
//            leftMin = totalMinutes % 60;
//            weekdayKey = [[NSString alloc]initWithFormat:@"%d",weekday];
//        }
//        NSString *weekdayValue = [weekdayOffDic valueForKey:weekdayKey];
//        //NSLog(@"WEEKDAYOFFVALUE === %@",weekdayValue);
//        [mAcDB setObject:[NSNumber numberWithBool:YES] forKey:weekdayValue withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:leftHour] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Hour" withDB:mAcDB.mModeDefaultDB];
//        [mAcDB setObject:[NSNumber numberWithInt:leftMin] forKey:@"KDefaultPowerOffTimer_mTimerFormat_Min" withDB:mAcDB.mModeDefaultDB];
    }
}
//获取当前时间
-(NSString*)getCurrentTime
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now=[NSDate date];
    NSInteger unitFlags =  NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSInteger weekday = [comps weekday];
    return [[NSString alloc]initWithFormat:@"%ld:%ld:%ld",(long)hour,(long)min,(long)weekday];
}

@end









