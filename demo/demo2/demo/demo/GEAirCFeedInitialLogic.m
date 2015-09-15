//
//  GEAirCFeedNormalLogic.m
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEAirCFeedInitialLogic.h"
#import "GEAirCFeedDAO.h"

#import "GEAirCPriFeed.h"
#import "GEAirCPubFeed.h"

@implementation GEAirCFeedInitialLogic

//-(id)initWithDictionary:(NSMutableDictionary *)dic
//{
//    self = [super init];
//    if (self) {
////        _dic = dic;
//    }
//    return self;
//}

- (void) visitDao:(id <GEFeedDAO>)dao
{
    // default behavior
}

- (void) visitAircDao:(GEAirCFeedDAO *)dao
{
    NSArray *keyarr = @[KAirCAutoMode,
                        KAirCCoolMode,
                        KAirCFanMode,
                        KAirCDryMode,
                        KAirCHotMode,
                        KAirCPublicData,
                        ];
    for (int i=0; i<[keyarr count]; i++) {
        [self Store:dao creatInitialLogicWithMode:[keyarr objectAtIndex:i]];
    }
}

-(void)Store:(GEAirCFeedDAO *)dao creatInitialLogicWithMode:(NSString *)mode
{
    [dao findByMode:mode];

    [dao setStuff:@"1" forKey:@"mPowerOn"];
    [dao setStuff:@"1" forKey:@"mTepUnitC"];
    [dao setStuff:@"4" forKey:KAircFanSpeed];
    
    /*
        也可以这样处理
     
    GEFeedFather *father = [dao findByMode:mode];
    [father setValue:@"1" forKey:@"mPowerOn"];
    [father setValue:@"1" forKey:@"mTepUnitC"];
    [father setValue:@"4" forKey:KAircFanSpeed];
     */
}

@end
