//
//  NewworkDemoTests.m
//  NewworkDemoTests
//
//  Created by gree's apple on 24/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RTUDPDAO.h"
#import "RTTCPDAO.h"

@interface NewworkDemoTests : XCTestCase

@end

@implementation NewworkDemoTests

- (void)setUp {
    [super setUp];
     [RTUDPDAO shareInstance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
