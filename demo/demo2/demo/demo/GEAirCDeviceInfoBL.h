//
//  GEAirCDeviceInfoStore.h
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MessageLists.h"

@protocol GEFeedDAO;

@class GEFeedFather;
@class GEAirCFeedInitialLogic;
@class GEAirCFeedParticularLogic;

/************************************************************************************/
/* 此类底层都是构建最小的数据库，但应用往往需要多个数据结合起来形成一个“设备”的状态库，故生此类     */
/* 业务逻辑层*/
/* 此类对于设备层面进行控制  */
/************************************************************************************/
@interface GEAirCDeviceInfoBL : NSObject
{
    @private
    GEAirCFeedInitialLogic *initLogic;
    GEAirCFeedParticularLogic *particularLogic;
    /*
        数据结构@[
                    @"mac1" : dao1
                    @"mac2" : dao2
                ]
     */
    NSMutableDictionary *dic;//用来储存每台空调的状态数据
}

-(void)sendMessage:(BLMessageEvt)msg;   //后台处理完成后，均需要通过此来通知显示

//插入方法
-(void) createByMac:(NSString *)mac;

//删除方法
-(void) removeByMac:(NSString *)mac;

//修改方法
/*
    如果能通过数组传值最好，[@"mac":xx
                         @"mode":yy
                         @"key":@"value"
                        ]
 */
-(void) modifyByMac:(NSString *)mac andContext:(NSString *)context;//

//按照主键查询数据方法
-(id <GEFeedDAO>) findByMac:(NSString *)mac;

//查询所有数据方法
-(NSMutableDictionary *) findAllDevice;

//stuff 在填充前，确保_pri及_pub处于正常状态即可
- (void) Dao:(id <GEFeedDAO>)dao setStuff:(id)stuff forKey:(id)key;

@end
