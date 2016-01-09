//
//  ItemStore.m
//  Homepwner
//
//  Created by 代隽杰 on 16/1/5.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"
#import "ImageStore.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation ItemStore

+(instancetype)sharedStore
{
    static ItemStore *sharedStore = nil;
    //判断是否需要创建一个sharedStore对象
    if (!sharedStore) {
        sharedStore = [[self alloc]initPrivate];
    }
    return sharedStore;
}

//如果调用[[ItemStore alloc]init]，就提示应该调用[ItemStore shareStore]
-(instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[ItemStore shareStore]"
                                 userInfo:nil];
    return nil;
}


//真正的私有化初始化方法
-(instancetype)initPrivate
{
    self  = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc]init];
    }
    
    return self;
}

-(NSArray *)allItems
{
    return self.privateItems;
}

-(BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return  item;
}

-(void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    [[ImageStore sharedStore]deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
    
}
@end
