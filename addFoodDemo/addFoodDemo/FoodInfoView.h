//
//  FoodInfoView.h
//  addFoodDemo
//
//  Created by 代隽杰 on 16/8/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@protocol FoodInfoViewDelegate <NSObject>

-(void)didSelectFoodName:(FoodModel *)foodModel;

@end
@interface FoodInfoView : UIView

//食材图标图片
@property (nonatomic ,strong) UIImageView *iconImageViewFoodImage;
//食材图标名称
@property (nonatomic ,strong) UILabel *iconLabelFoodName;
//图标是否抖动
@property (nonatomic ,assign) BOOL *isIconShaking;
//删除按钮图标
@property (nonatomic ,strong) UIButton *deleteBtn;
//代理
@property (nonatomic ,strong) id<FoodInfoViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame andFoodModel:(FoodModel *) foodModel;

@end
