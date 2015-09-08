//
//  GEAirCFeedDAO.h
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GEFeedDAO.h"

/************************************************************************************/
/* 属性数据访问中心，修改属性值必须通过此方法，不能直接通过set字典的方法修改，保证数据封闭性       */
/* 这里应该就是生成5种模式、6种模式的地方，查询也是到这里查，改也是到这里改                     */
/************************************************************************************/
@class GEAirCPriFeed;
@class GEAirCPubFeed;

@interface GEAirCFeedDAO : NSObject <GEFeedDAO>
{
    @private
    NSMutableDictionary *dic;//这个数组就是保存每台空调，有多少个模式的数据
}
@property (nonatomic, readonly) GEAirCPriFeed *_pri;    //##需要readonly？
@property (nonatomic, readonly) GEAirCPubFeed *_pub;
@property (nonatomic, readonly) NSString *_currentMode;  //当前的控制模式
/*
    返回格式,只是空壳，需要creat之后，在visitor内赋值
    @[
        _pri : KAirAutoMode
        _pri : KAirCoolMode
        _pri : KAirFanMode
        _pri : KAirDryMode
        _pri : KAirHotMode
        _pub : KAirPublicData
     ]
 */
-(void) create;

//按照主键查询数据方法（切换模式时，mode即为当前模式）
/*
    这个参数最好是能够选择的，不然手写容易出错
    mode在此搜寻 
    @[
     _pri : KAirAutoMode
     _pri : KAirCoolMode
     _pri : KAirFanMode
     _pri : KAirDryMode
     _pri : KAirHotMode
     _pub : KAirPublicData
     ]
 */
-(GEFeedFather *) findByMode:(NSString *) mode;

//查询所有数据方法
-(NSMutableDictionary *) findAllMode;

//////////////////////////////////////////////////////

//JSON格式的全部空调数据
- (NSString *)JsonFormatValue;

//接受内容改变
-(void)acceptAircDaoVisitor:(id<FeedVisitor>)visitor;

//stuff 在填充前，确保_pri及_pub处于正常状态即可
- (void) setStuff:(id)stuff forKey:(id)key;

@end
