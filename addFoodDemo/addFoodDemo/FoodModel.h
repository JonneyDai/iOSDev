//
//  FoodModel.h
//  addFoodDemo
//
//  Created by 代隽杰 on 16/8/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface FoodModel : NSObject

//食材名称
@property (nonatomic ,strong) NSString *FoodName;
//食材图片
@property (nonatomic ,strong) NSString *FoodPhoto;
//食材存入时间
@property (nonatomic ,strong) NSString *FoodProDate;
//食材保质日期
@property (nonatomic ,assign) float  FoodShelfLf;
//食材保质期单位
@property (nonatomic ,strong) NSString *FoodSLUnit;
//食材重量、数量
@property (nonatomic ,assign) float FoodWeight;
//食材重量、数量单位
@property (nonatomic ,strong) NSString *FoodWUnit;
//食材添加位置
@property (nonatomic ,strong) NSString *FoodAddPos;

@end
