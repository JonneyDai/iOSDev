//
//  GEWiFiContext.h
//  NewArchitecture
//
//  Created by gree's apple on 13/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
/************************************************************************************/
/*     WIFI板子的基本信息                                                              */
/************************************************************************************/
typedef NS_ENUM(NSInteger, WiFiNetWorkType)
{
    WiFiNetWorkTypeClient = 0,
    WiFiNetWorkTypeAp,
};

typedef NS_ENUM(NSInteger, WiFiNetWorkSecureType)
{
    WiFiNetWorkSecureTypeAuto = 0,      //自动
    WiFiNetWorkSecureTypeOpen,          //开放
    WiFiNetWorkSecureTypeWEP64Open,     //WEP64开放
    WiFiNetWorkSecureTypeWEP64Share,    //WEP64共享
    WiFiNetWorkSecureTypeWEP128Open,    //WEP128开放
    WiFiNetWorkSecureTypeWEP128Share,   //WEP128共享
    WiFiNetWorkSecureTypeWPATKIP,       //WPA模式.TKIP
    WiFiNetWorkSecureTypeWPAAES,        //WPA模式.AES
    WiFiNetWorkSecureTypeWPA2TKIP,      //WPA2模式.TKIP
    WiFiNetWorkSecureTypeWPA2AES,       //WPA2模式.AES
};

typedef struct {
    const char *ip;
    const char *port;
    const char *mac;
    const char *mask;
    const char *gate;
    const char *dns;
}WiFiInfo;

typedef struct {
    BOOL isOnline;  //设备连上了服务器
    BOOL isLAN;     //设备在局域网能找到（优先级较高）
}WiFiNetWorkStatus;

@interface GEWiFiContext : NSObject

@property (nonatomic, readonly) NSString *isStartConfig;    //貌似可以弃用，使用target-action来触发？否则每次都要重置标志位
@property (nonatomic, readonly) BOOL isBind;                //设备是否绑定到服务器的标识
@property (nonatomic, readonly) NSString *wifiSSID;         //wifi的SSID
@property (nonatomic, readonly) int HWBoardType;//检测板类型 0为亚信板、1为高通板、2为TI板。

@property (nonatomic, assign) WiFiNetWorkStatus mWiFiNetWorkStatus;
@property (nonatomic, assign) WiFiNetWorkType mWiFiNetWorkType;
@property (nonatomic, assign) WiFiNetWorkSecureType mWiFiNetWorkSecureType;
@property (nonatomic, assign) WiFiInfo mWifiInfo;
@property (nonatomic, strong) NSString *deviceName;//设备名称


@end
