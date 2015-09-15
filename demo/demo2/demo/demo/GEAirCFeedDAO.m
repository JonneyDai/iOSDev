//
//  GEAirCFeedDAO.m
//  NewArchitecture
//
//  Created by gree's apple on 15/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "GEAirCFeedDAO.h"
#import "GEAirCPriFeed.h"
#import "GEAirCPubFeed.h"

@implementation GEAirCFeedDAO
@synthesize _pri = pri,_pub = pub,_currentMode = currentMode;

#pragma mark-
#pragma mark life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    return self;
}

#pragma mark-
#pragma mark GEFeedDAO Protocol

//插入方法
- (void) create
{
    NSArray *keyarr = @[KAirCAutoMode,
                        KAirCCoolMode,
                        KAirCFanMode,
                        KAirCDryMode,
                        KAirCHotMode,
                        KAirCPublicData,
                       ];
    
    int index;
    for (index = 0; index < 5; index++) {
        
        pri = [[GEAirCPriFeed alloc] init];

        [dic setObject:pri forKey:[keyarr objectAtIndex:index]];
    }
    
    pub = [[GEAirCPubFeed alloc] init];
    [dic setObject:pub forKey:[keyarr objectAtIndex:index]];
    
    currentMode = KAirCAutoMode;
}

-(void) modifyByMode:(NSString *) mode;
{
    //do nothing
}

//按照主键查询数据方法
-(GEFeedFather *) findByMode:(NSString *) mode;
{
    GEFeedFather *father = [[GEFeedFather alloc] init];
    
    if ([mode isEqualToString:KAirCPublicData]) {
        pri = [dic objectForKey:currentMode];//设成默认
        pub = [dic objectForKey:mode];
        father = pub;
    }else{
        currentMode = mode;
        
        pri = [dic objectForKey:mode];
        pub = [dic objectForKey:KAirCPublicData];
        father = pri;
    }

    return father;
}

//查询所有数据方法
-(NSMutableDictionary *) findAllMode;
{
    return dic;
}

- (void)acceptAircDaoVisitor:(id<FeedVisitor>)visitor
{
    [visitor visitAircDao:self];
}

#pragma mark-
#pragma mark privateMethods

- (void)setStuff:(id)stuff forKey:(id)key
{
    //反正通过各种方式来判断stuff是属于哪个类的就行啦，然后set它
    //待优化。。。无法知道哪里key是在哪个类..........setValuesForKeysWithDictionary
    if ([key isEqualToString:KAircFanSpeed]) {
        [pri setValue:stuff forKey:key];
    }
    else{
        [pub setValue:stuff forKey:key];
    }
}

- (NSString *)JsonFormatValue
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
