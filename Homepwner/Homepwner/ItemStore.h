//
//  ItemStore.h
//  Homepwner
//
//  Created by 代隽杰 on 16/1/5.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface ItemStore : NSObject
@property (nonatomic, readonly) NSArray *allItems;

+(instancetype) sharedStore;

-(BNRItem *) createItem;

-(void) removeItem:(BNRItem *)item;

-(void) moveItemAtIndex:(NSInteger )fromIndex toIndex:(NSInteger) toIndex;
@end
