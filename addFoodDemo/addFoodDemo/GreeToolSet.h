//
//  GreeToolSet.h
//  addFoodDemo
//
//  Created by 代隽杰 on 16/8/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GreeToolSet : NSObject

//图片转字符串
-(NSString *)UIImageToBase64Str:(UIImage *) image;
//字符串转图片
-(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

@end
