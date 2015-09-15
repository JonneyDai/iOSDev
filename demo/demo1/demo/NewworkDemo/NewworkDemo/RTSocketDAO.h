//
//  RTSocketDAO.h
//  NewArchitecture
//
//  Created by gree's apple on 13/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GESocket.h"

@protocol RTSocketDAO <NSObject>

//插入方法
-(int) create:(id <GESocket>)obj;

//删除方法
-(int) removeByMac:(NSString *)mac;

//修改方法
-(int) modify:(id <GESocket>)obj;

//按照主键查询数据方法
-(id <GESocket>) findByMac:(NSString *)mac;

//查询所有数据方法
-(NSMutableDictionary *) findAll;

@end
