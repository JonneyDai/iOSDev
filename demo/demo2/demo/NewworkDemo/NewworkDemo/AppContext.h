//
//  GetIpV4.h
//  RemoteController
//
//  Created by WJF-Monk  330694 on 13/11/12.
//  Copyright (c) 2012 WJF-Monk  330694. All rights reserved.
//
//  Use for get IP from system,firstly ,you must connet the wifi in setting

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppContext : NSObject

@property (nonatomic, copy, readonly) NSString *lh;             //本地HOST
@property (nonatomic, readonly) NSInteger lp;                   //本地PORT
@property (nonatomic, copy, readonly) NSString *bch;            //广播HOST
@property (nonatomic, readonly) NSInteger bcp;                  //HEX广播PORT
@property (nonatomic, readonly) NSInteger bcJSp;                //JSON格式广播PORT

@property (nonatomic, readonly) NSString *appv;                 //软件版本

@property (nonatomic, copy, readonly) NSString *osv;            //系统版本
@property (nonatomic, copy, readonly) NSString *osn;            //系统名称

@property (nonatomic, copy, readonly) NSString *teln;           //手机名称
@property (nonatomic, copy, readonly) NSString *uuid;

@property (nonatomic, copy, readonly) NSString *currentMac;    /*
                                                                 1.当前界面代表的设备mac值。
                                                                 2.此mac仅与当前设备界面挂钩。
                                                                 3.不存在界面的mac通信，使用临时mac。
                                                                 */
@property (nonatomic, copy, readwrite) NSString *tempMac;       //用于非界面对应的mac
@property (nonatomic, copy, readwrite) NSString *uiMac;         //用于界面对应的mac

+ (AppContext *)shareAppContext;

@end
