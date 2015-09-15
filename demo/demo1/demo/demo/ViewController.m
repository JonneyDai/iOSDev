//
//  ViewController.m
//  demo
//
//  Created by gree's apple on 21/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "ViewController.h"
#import "GEAirCDeviceInfoBL.h"
#import "GEAirCFeedDAO.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个业务逻辑
    GEAirCDeviceInfoBL *BL = [[GEAirCDeviceInfoBL alloc] init];
    //创建模拟添加设备ID为mac007的实体类，并初始化空调各模式数据
    [BL createByMac:@"mac007"];
    
    NSLog(@"DAO及数据构建完成");
    
    /**************************以下为正常情况下的赋值************************************/
    //根据设备找到对应的实体类访问对象
    GEAirCFeedDAO *fatherDAO = [BL findByMac:@"mac007"];
    NSLog(@"father %@",fatherDAO);
    //通过模式更新最新状态
    [fatherDAO findByMode:KAirCAutoMode];
    //通过业务逻辑层进行数据更改
    [BL Dao:fatherDAO setStuff:@"0" forKey:KAircPowerOn];
    NSLog(@"father %@",fatherDAO);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
