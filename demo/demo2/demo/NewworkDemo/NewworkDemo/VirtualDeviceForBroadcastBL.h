//
//  VirtualDeviceForBroadcast.h
//  NewworkDemo
//
//  Created by gree's apple on 25/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VirtualDeviceProtocol.h"
/************************************************************************************/
/*  UDP广播类                      */
/************************************************************************************/

typedef void (^BCBLBlock)(void);

@interface VirtualDeviceForBroadcastBL : NSObject <VirtualDeviceProtocol,GEUDPSocketDelegate>

//@property (nonatomic, strong) NSString *excuteMac;
@property (nonatomic, strong) GENetworking *_nw;
@property (nonatomic, strong) Command *_command;
@property (nonatomic, strong) GEWiFiContext *_context;

//@property (nonatomic, strong) NSString *identify;           //标识 可以认为是MAC

//由于是BL，所以应当在此处理时间
-(void)sendMessage:(BLMessageEvt)msg;

//context
-(GEWiFiContext *)configContextWithDictionary:(NSDictionary *)dic;

//Command
- (void)broadcast:(void (^)(void))success fail:(void (^)(void))fail;

- (void)creatUdpWithIpAndPortContext:(NSDictionary *)context;

@end
