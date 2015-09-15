//
//  GEFeedDAO.h
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GEFeedFather.h"
#import "FeedVisitor.h"

@protocol GEFeedDAO <NSObject>

@optional

//插入方法
-(void) create;

//删除方法
-(void) removeByMode:(NSString *) mode;

//暂时没有此修改需求
-(void) modifyByMode:(NSString *) mode;

//按照主键查询数据方法
-(GEFeedFather *) findByMode:(NSString *) mode;

//查询所有数据方法
-(NSMutableDictionary *) findAllMode;

//接受内容改变
- (void)acceptAircDaoVisitor:(id <FeedVisitor>) visitor;

@end
