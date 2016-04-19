//
//  main.m
//  Unit5ComposTest
//
//  Created by 代隽杰 on 16/4/14.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>

// ------------------------Tire--------------------------
@interface Tire : NSObject
@end //Tire

@implementation Tire

-(NSString *) description
{
    return @"I am a tire.I last a while.";
}//description

@end //Tire

@interface AllWeatherRadial : Tire
@end

@implementation AllWeatherRadial

-(NSString *)description
{
    return @"I am a tire for rain or shine";
}

@end

// ------------------------Engine--------------------------
@interface Engine : NSObject
@end //Engine


@implementation Engine

-(NSString *)description
{
    return  @"I am a engine. Vrooom!";
}//description

@end//Engine

// ------------------------Slant6--------------------------
@interface Slant6 : Engine
@end

@implementation Slant6

-(NSString *)description
{
    return @"I am a slant - 6. VROOOM!";
}
@end//Slant6

// ------------------------Car--------------------------
@interface Car : NSObject
{
    Engine *engine;
    Tire *tires[4];
}

-(Engine *) engine;

-(void) setEngine:(Engine *) newEngine;

-(Tire *) tireAtIndex:(int) index;

-(void) setTire:(Tire *)tire atIndex:(int) index;

-(void) print;

@end //Car


@implementation Car

-(id) init
{
    if (self = [super init]) {
        engine = [Engine new];
        tires[0] = [Tire new];
        tires[1] = [Tire new];
        tires[2] = [Tire new];
        tires[3] = [Tire new];

    }
    return self;
} //init

-(Engine *) engine
{
    return engine;
}//engine

-(void)setEngine:(Engine *)newEngine
{
    engine = newEngine;
} //setEngine

-(Tire *)tireAtIndex:(int)index
{
    if (index < 0 || index > 3) {
        NSLog(@"bad index (%d) in tireAnIndex:",index);
        exit(1);
    }
    return tires[index];
} //tireAtIndex

-(void)setTire:(Tire *)tire atIndex:(int)index
{
    if (index < 0 || index > 3) {
        NSLog(@"bad index (%d) in setTire:atIndex:",index);
        exit(1);
    }
    tires[index] = tire;
}

-(void)print
{
    NSLog(@"%@", engine);
    NSLog(@"%@", tires[0]);
    NSLog(@"%@", tires[1]);
    NSLog(@"%@", tires[2]);
    NSLog(@"%@", tires[3]);
} //print

@end //Car

// ------------------------main--------------------------
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Car *car = [Car new];
        Engine *engine = [Slant6 new];
        [car setEngine:engine];
        for (int i = 0; i < 4; i++) {
            Tire *tire = [AllWeatherRadial new];
            [car setTire: tire atIndex:i];
        }
        
        [car print];
    }
    return 0;
}
