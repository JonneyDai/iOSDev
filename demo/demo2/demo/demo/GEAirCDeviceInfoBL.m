//
//  GEAirCDeviceInfoStore.m
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEAirCDeviceInfoBL.h"
#import "GEAirCPriFeed.h"
#import "GEAirCPubFeed.h"
#import "GEAirCFeedDAO.h"
#import "GEFeedDAO.h"
#import "GEAirCFeedInitialLogic.h"
#import "GEAirCFeedParticularLogic.h"

@implementation GEAirCDeviceInfoBL
{
    GEAirCFeedDAO *_dao;
}
#pragma mark-
#pragma mark life cycle

-(id) init
{
    self = [super init];
    
    if (self) {
        /**********************/
        //此处需要根据板子是什么类型，对应生成不动的dao
        _dao = [[GEAirCFeedDAO alloc] init];
        /**********************/

        dic = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    return self;
}
#pragma mark-
#pragma mark message
-(void)sendMessage:(BLMessageEvt)msg
{
    if (msg == BLMessageEvt_UpdataSuccess) {    //数据更新完成，进而通知页面
        
    }else if (msg == BLMessageEvt_LoginDone){   //页面需要跳转
            //可能使用notification方式
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:updataNotification
                                                        object:[NSString stringWithFormat:@"%d",msg]];
}

#pragma mark-
#pragma mark eventResponse

//插入
-(void) createByMac:(NSString *)mac
{
    /**********************/
    //此处需要根据板子是什么类型，对应生成不动的dao、生成对应的logic
    [_dao create];
    
    GEAirCFeedInitialLogic *logic = [[GEAirCFeedInitialLogic alloc] init];
    /**********************/
    [_dao acceptAircDaoVisitor:logic];
    
    [dic setObject:_dao forKey:mac];
}

//删除
-(void) removeByMac:(NSString *)mac
{
    [dic removeObjectForKey:mac];
}

//修改方法
-(void) modifyByMac:(NSString *)mac andContext:(NSString *)context
{
    /**********************/
//    modify主要是支持一次性修改多个Device里的值，是Dao:setStuff:forKey的扩张
    /**********************/
//    _dao = [dic objectForKey:mac];
}

//按照主键查询数据方法
-(id <GEFeedDAO>) findByMac:(NSString *)mac
{
    _dao = [dic objectForKey:mac];
    return _dao;
}

//查询所有数据方法
-(NSMutableDictionary *) findAllDevice
{
    return dic;
}

#pragma mark-
#pragma mark getters and setters

//stuff 在填充前，确保_pri及_pub处于正常状态即可
- (void) Dao:(id<GEFeedDAO>)dao setStuff:(id)stuff forKey:(id)key
{
    GEAirCFeedParticularLogic *logic = [[GEAirCFeedParticularLogic alloc] init];
    [_dao acceptAircDaoVisitor:logic];
}


@end
