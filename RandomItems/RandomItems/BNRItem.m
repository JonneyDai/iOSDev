//
//  BNRItem.m
//  RandomItems
//
//  Created by 代隽杰 on 15/9/12.
//  Copyright (c) 2015年 Jonney. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

-(instancetype) initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber{
    //调用父类的指定初始化方法
    self = [super init];
    //父类的指定初始化方法是否成功创建了父类对象？
    if (self) {
        //为实例变量设定初始值
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        //设置_dateCreated的值为系统当前时间
        _dateCreated = [[NSDate alloc]init];
    }
    //返回初始化后的对象的新地址de
    return  self;
}

//实现initWithItemName:初始化方法
-(instancetype) initWithItemName:(NSString *)name{
    return  [self initWithItemName:name
                    valueInDollars:0
                      serialNumber:@""];
}

-(instancetype) init{
    return [self initWithItemName:@"Item"];
}

-(void) setItemName:(NSString *)str{
    _itemName = str;
}
-(NSString *) itemName{
    return  _itemName;
}

-(void) setSerialNumber:(NSString *)str{
    _serialNumber = str;
}
-(NSString *) serialNumber{
    return _serialNumber;
}

-(void) setValueInDollars:(int)v{
    _valueInDollars = v;
}
-(int) valueInDollars{
    return  _valueInDollars;
}

-(NSDate *) dateCreated{
    return  _dateCreated;
}

-(NSString *) description{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@(%@):Worth $%d,recorded on %@",
                                   self.itemName,
                                   self.serialNumber,
                                   self.valueInDollars,
                                   self.dateCreated];
    return descriptionString;
}

+(instancetype) randomItem{
    
    //创建不可变数组对象，包含三个形容词
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    //创建不可变数组，包含三个名词
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    //根据数组对象所含对象的个数，得到随机索引
    //NSInteger是一种针对unsigned long的类型定义
    NSInteger adjectiveIndex = arc4random()%[randomAdjectiveList count];
    NSInteger nounIndex = arc4random()%[randomNounList count];
    
    NSString *randomName = [NSString ]
    
}

@end
