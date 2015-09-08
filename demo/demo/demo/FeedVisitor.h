//
//  FeedVisitor.h
//  NewArchitecture
//
//  Created by gree's apple on 18/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GEFeedDAO;

@class GEAirCFeedDAO;

@protocol FeedVisitor <NSObject>

- (void) visitDao:(id <GEFeedDAO>)dao;
- (void) visitAircDao:(GEAirCFeedDAO *)air;
@end
