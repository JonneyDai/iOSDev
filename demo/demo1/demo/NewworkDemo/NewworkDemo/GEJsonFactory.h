//
//  GEJsonFactory.h
//  NewworkDemo
//
//  Created by gree's apple on 26/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GEFormatFactory.h"

@interface GEJsonFactory : NSObject <GEFormatFactory>

-(NSData *)creatWithIdentify:(NSString *)identify withBL:(GEAirCDeviceInfoBL *)bl;

@end
