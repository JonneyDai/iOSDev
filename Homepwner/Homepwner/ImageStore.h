//
//  ImageStore.h
//  Homepwner
//
//  Created by 代隽杰 on 16/1/7.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageStore : NSObject

+(instancetype) sharedStore;

-(void) setImage:(UIImage *)image forKey:(NSString *)key;

-(UIImage *)imageForKey:(NSString *)key;

-(void) deleteImageForKey:(NSString *)key;

@end
