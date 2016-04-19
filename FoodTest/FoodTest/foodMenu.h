//
//  foodMenu.h
//  FoodTest
//
//  Created by 代隽杰 on 16/4/19.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
/** 每个菜的详情*/
@interface foodMenu : NSObject
/** id*/
@property (nonatomic, strong) NSString *id;
/** 标题*/
@property (nonatomic, strong) NSString *title;
/** 标签*/
@property (nonatomic, strong) NSString *tags;
/** 简介*/
@property (nonatomic, strong) NSString *imtro;
/** 材料*/
@property (nonatomic, strong) NSString *ingredients;
/** 调料*/
@property (nonatomic, strong) NSString *burden;
/** 图片*/
@property (nonatomic, strong) NSArray *albums;
/** 步骤*/
@property (nonatomic, strong) NSArray *steps;
@end


@interface StepModel : NSObject
/** 步骤图片*/
@property (nonatomic, strong) NSString *img;
/** 步骤说明*/
@property (nonatomic, strong) NSString *step;
@end

