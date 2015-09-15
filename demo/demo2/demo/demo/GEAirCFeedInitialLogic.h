//
//  GEAirCFeedNormalLogic.h
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedVisitor.h"
/************************************************************************************/
/*      我是这么想的。。DAO在构建数据库时并不对数据库里的成员赋初始值（因为运行过程中还要修改啊   */
/*      所以通过BL来赋值*/
/************************************************************************************/

@interface GEAirCFeedInitialLogic : NSObject <FeedVisitor>
{
//    @private
//    NSMutableDictionary *_dic;
}

//- (id) initWithDictionary:(NSMutableDictionary *)dic;

- (void) visitDao:(id <GEFeedDAO>)dao;
- (void) visitAircDao:(GEAirCFeedDAO *)air;

@end
