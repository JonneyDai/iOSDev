//
//  studentInfo.h
//  UserDefaultTest
//
//  Created by 代隽杰 on 16/6/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface studentInfo : NSObject <NSCoding>

@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *studentNumber;
@property (nonatomic, assign) NSString *sex;

@end
