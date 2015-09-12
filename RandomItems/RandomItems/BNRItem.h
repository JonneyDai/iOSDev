//
//  BNRItem.h
//  RandomItems
//
//  Created by 代隽杰 on 15/9/12.
//  Copyright (c) 2015年 Jonney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
    
}

+(instancetype) randomItem;

//BNRItem类指定初始化方法
-(instancetype) initWithItemName:(NSString *) name
                  valueInDollars:(int) value
                    serialNumber:(NSString *) sNumber;
//BNRItem类第二种初始化方法
-(instancetype) initWithItemName:(NSString *)name;

-(void) setItemName:(NSString *) str;
-(NSString *) itemName;

-(void) setSerialNumber:(NSString *) str;
-(NSString *) serialNumber;

-(void) setValueInDollars:(int) v;
-(int) valueInDollars;

-(NSDate *) dateCreated;


@end
