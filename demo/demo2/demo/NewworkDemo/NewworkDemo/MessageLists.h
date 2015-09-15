//
//  MessageLists.h
//  NewworkDemo
//
//  Created by gree's apple on 10/9/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MessageLists_h
#define MessageLists_h

//主要用于数据处理完成后，反馈给上层用以更高处理的事件
typedef NS_ENUM(uint, BLMessageEvt)
{
    BLMessageEvt_BroadcastDone = 0, //UDP广播解析完成
    BLMessageEvt_LoginDone,         //登录完成
    BLMessageEvt_UpdataSuccess,     //数据解析完成
    BLMessageEvt_NetworkInterrupt,  //网络中断,此事件应由更高层来处理
    BLMessageEvt_DeviceInterrupt,   //设备断开
};
//所有均通过此监听
static NSString *updataNotification = @"updataNotification";

#endif
