//
//  BNRItem.h
//  RandomItems
//
//  Created by 代隽杰 on 15/9/12.
//  Copyright (c) 2015年 Jonney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

//{
//    NSString *_itemName;
//    NSString *_serialNumber;
//    int _valueInDollars;
//    NSDate *_dateCreated;
//    
//    //强引用循环问题
//    BNRItem *_containedItem;
//    __weak BNRItem *_container;
//    //end
//    
//}

@property (nonatomic, strong) BNRItem *containedItem;
@property (nonatomic, weak) BNRItem *container;

@property (nonatomic) NSString *itemName;
@property (nonatomic) NSString *serialNumber;
@property (nonatomic, assign) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

+(instancetype) randomItem;

//BNRItem类指定初始化方法
-(instancetype) initWithItemName:(NSString *) name
                  valueInDollars:(int) value
                    serialNumber:(NSString *) sNumber;
//BNRItem类第二种初始化方法
-(instancetype) initWithItemName:(NSString *)name;

//BNRItem类第三个初始化方法
-(instancetype) initWithItemName:(NSString *) name
                    serialNumber:(NSString *) sNumber;

//-(void) setItemName:(NSString *) str;
//-(NSString *) itemName;
//
//-(void) setSerialNumber:(NSString *) str;
//-(NSString *) serialNumber;
//
//-(void) setValueInDollars:(int) v;
//-(int) valueInDollars;
//
//-(NSDate *) dateCreated;
//
////测试强引用循环问题
//-(void) setContainedItem:(BNRItem *) item;
//-(BNRItem *)containedItem;
//
//-(void) setContainer: (BNRItem *) item;
//-(BNRItem *) container;
////end

@end
