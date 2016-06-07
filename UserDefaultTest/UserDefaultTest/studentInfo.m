//
//  studentInfo.m
//  UserDefaultTest
//
//  Created by 代隽杰 on 16/6/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "studentInfo.h"

@implementation studentInfo

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.studentNumber forKey:@"studentNumber"];
    [coder encodeObject:self.sex forKey:@"sex"];
    
    NSLog(@"%@",coder);
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
//    self = [super initWithCoder:coder];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.studentNumber = [coder decodeObjectForKey:@"studentNumber"];
        self.sex = [coder decodeObjectForKey:@"sex"];
    }
    return self;
}


@end
