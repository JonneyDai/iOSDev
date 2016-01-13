//
//  ImageStore.m
//  Homepwner
//
//  Created by 代隽杰 on 16/1/7.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation ImageStore

#pragma -mark 单例模式
+(instancetype)sharedStore
{
    static ImageStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc]initPrivate];
        
    }
    return sharedStore;
}

-(instancetype)init
{
    @throw  [NSException exceptionWithName:@"Singleton" reason:@"Use + [ImageStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype) initPrivate
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}

#pragma -mark 接口实现

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
//    [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
}

-(UIImage *)imageForKey:(NSString *)key
{
//    return [self.dictionary objectForKey:key];
    return self.dictionary[key];
}

-(void) deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}



@end
