//
//  FoodInfoView.m
//  addFoodDemo
//
//  Created by 代隽杰 on 16/8/1.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "FoodInfoView.h"
#import "GreeToolSet.h"

//手机屏幕宽度
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
//食物图标间隔
#define FoodIconSpace 5
//每行食物图标数量
#define FoodIconNumber 5
//食物图标宽度（等于高度），图标为正方形
#define FoodIconImageWidth (ScreenWidth - FoodIconSpace * (FoodIconNumber - 1)) / FoodIconNumber


@implementation FoodInfoView


- (instancetype)initWithFrame:(CGRect)frame andFoodModel:(FoodModel *) foodModel{
    self = [super initWithFrame:frame];
    if (self) {
        self.isIconShaking = NO;
        self.deleteBtn.hidden = YES;
        [self creatViewWithFoodModel:foodModel];
    }
    return self;
}


-(void)creatViewWithFoodModel:(FoodModel *) foodModel{
    //绘制食物图标
    self.iconImageViewFoodImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FoodIconImageWidth, FoodIconImageWidth)];
    self.iconImageViewFoodImage.backgroundColor = [UIColor redColor];
    GreeToolSet *greeTool = [[GreeToolSet alloc]init];
    self.iconImageViewFoodImage.image = [greeTool Base64StrToUIImage:foodModel.FoodPhoto];
    
    //绘制食物名称
    self.iconLabelFoodName = [[UILabel alloc]initWithFrame:CGRectMake(0, FoodIconImageWidth - 20, FoodIconImageWidth, 20)];
    self.iconLabelFoodName.backgroundColor = [UIColor lightGrayColor];
    self.iconLabelFoodName.textColor = [UIColor blackColor];
    self.iconLabelFoodName.textAlignment = NSTextAlignmentCenter;
    self.iconLabelFoodName.font = [UIFont systemFontOfSize:15];
    self.iconLabelFoodName.text = foodModel.FoodName;
    
    [self.iconImageViewFoodImage addSubview:self.iconLabelFoodName];
    [self addSubview:self.iconImageViewFoodImage];
    
}


    
@end
