//
//  GEAirCFeedParticularLogin.h
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedVisitor.h"
@class GEAirCFeedDAO;

/************************************************************************************/
/*      本类的存在价值就是通过输入的键值，通过构建的规则进行约束                               */
/************************************************************************************/

@interface GEAirCFeedParticularLogic : NSObject <FeedVisitor>
{
    @private
    GEAirCFeedDAO *dao;
}
- (instancetype) initWithValue:(id)value andKey:(id)key;

- (void) visitDao:(id <GEFeedDAO>) dao;
- (void) visitAircDao:(GEAirCFeedDAO *) air;

@end
