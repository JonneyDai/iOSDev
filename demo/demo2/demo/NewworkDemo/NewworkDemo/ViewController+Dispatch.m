//
//  ViewController+Dispatch.m
//  NewworkDemo
//
//  Created by gree's apple on 10/9/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "ViewController+Dispatch.h"
#import <objc/runtime.h>

typedef void (*_VIMP) (id, SEL, ...);

@implementation UIViewController (ViewController_Dispatch)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        _VIMP viewWillAppear_IMP = (_VIMP)method_getImplementation(viewWillAppear);
        method_setImplementation(viewWillAppear, imp_implementationWithBlock(^(id target,SEL action){
            viewWillAppear_IMP(target, @selector(viewWillAppear:));
            
//            [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(ReceiverNotification:) name:updataNotification object:nil];
            NSLog(@"target %@",target);
        }));
    });
    
//    dispatch_once(&onceToken, ^{
//        Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewDidLoad));
//        _VIMP viewWillDisappear_IMP = (_VIMP)method_getImplementation(viewWillDisappear);
//        method_setImplementation(viewWillDisappear, imp_implementationWithBlock(^(id target,SEL action){
//            viewWillDisappear_IMP(target, @selector(viewDidLoad));
//            NSLog(@"disappear %@",target);
//        }));
//    });
}



@end
