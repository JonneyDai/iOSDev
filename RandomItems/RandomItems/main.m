//
//  main.m
//  RandomItems
//
//  Created by 代隽杰 on 15/9/11.
//  Copyright (c) 2015年 Jonney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        //NSLog(@"Hello, World!");
        
        //创建NSMutableArray对象，并用items变量保存该对象的地址；
        NSMutableArray *items = [[NSMutableArray alloc]initWithCapacity:10];
        //向items所指向的NSMutableArray对象发送addObject:消息，每次传入一个字符串
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];
        //继续向同一个对象发送添加消息
        [items insertObject:@"Zero" atIndex:0];
        
        //使用for循环实现遍历数组
//        for (int i = 0; i < [items count]; i++) {
//            NSString *item = [items objectAtIndex:i];
//            NSLog(@"%@",item);
//        }
        
        //使用快速枚举实现遍历items数组中的每一个item
        for (NSString *item in items){
            NSLog(@"%@",item);
        }
        
//        //使用id快速遍历存储不同类型对象的数组
//        for(id item in items){
//            NSLog(@"%@",item);
//        }
        
        
        //创建一个BNRItem对象并输出至控制台
//        BNRItem *item = [[BNRItem alloc]init];
//        NSLog(@"%@ %@ %@ %d",[item itemName],[item dateCreated],[item serialNumber],[item valueInDollars]);
//
//        BNRItem *item = [[BNRItem alloc ]init];
//        //创建一个新的NSString对象，并传给BNRItem对象
////        [item setItemName: @"Red Sofa"];
//        item.itemName = @"Red Sofa";
//        
//        //创建一个新的nsstring对象，并传给bnritem对象。
////        [item setSerialNumber: @"A1B2C"];
//        item.serialNumber = @"A1B2C";
//        
//        //将数值100传给bnritem对象，赋值给valueInDollars
////        [item setValueInDollars:100];
//        item.valueInDollars = 100;
//        
        //创建BNRItem对象并初始化
        BNRItem *item = [[BNRItem alloc]initWithItemName:@"Red Sofa"
                                          valueInDollars:100
                                            serialNumber:@"A1B2C"];
        
       
//        //打印item实例对象的值
//        NSLog(@"%@ %@ %@ %d",item.itemName,item.dateCreated,item.serialNumber,item.valueInDollars);
//
        
        //程序会先调用相应实参的description方法，然后用返回的字符串替换%@
        NSLog(@"%@",item);
        
        BNRItem *itemWithName = [[BNRItem alloc]initWithItemName:@"Blue Sofa"];
        NSLog(@"%@",itemWithName);
        
        BNRItem *itemWithNoName = [[BNRItem alloc]init];
        NSLog(@"%@",itemWithNoName);
        //释放items所指向的nsmutablearray对象
        items = nil;
        
    }
    return 0;
}
