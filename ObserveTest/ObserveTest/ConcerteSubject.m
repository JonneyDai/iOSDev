//
//  ConcerteSubject.m
//  ObserveTest
//
//  Created by 代隽杰 on 15/11/19.
//  Copyright © 2015年 gree. All rights reserved.
//

#import "ConcerteSubject.h"
//#import "ConcreteObserver.h"
#import "Observer.h"

@implementation ConcerteSubject
@synthesize observers;

static ConcerteSubject * shareConcerteSubject = nil
;
+(ConcerteSubject *)shareConcertSubject{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareConcerteSubject = [[self alloc]init];
        shareConcerteSubject.observers = [[NSMutableArray alloc]init];
    });
    return  shareConcerteSubject;
}



-(void)attach:(Observer *)observer{
    [self.observers addObject:observers];
    
}

-(void)detach:(Observer *)observer{
    [self.observers removeObject:observers];
}

-(void) notifyObservers{
    for (id obs in self.observers)
    {
        [obs update];
    }
    
}
@end
