//
//  GESocket.h
//  NewArchitecture
//
//  Created by gree's apple on 13/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GESocket <NSObject>

@property (nonatomic, readonly) NSString *hostIP;
@property (nonatomic, readonly) UInt16 hostPort;

- (BOOL)writeData:(NSData *)data;
- (BOOL)keepAliveWithData:(NSData *)data;

@end