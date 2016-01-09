//
//  ConcerteSubject.h
//  ObserveTest
//
//  Created by 代隽杰 on 15/11/19.
//  Copyright © 2015年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subject.h"

//#import "Observer.h"
//@class Observer;

@interface ConcerteSubject : NSObject<Subject>
{
    NSMutableArray *observers;
}
@property (nonatomic, strong) NSMutableArray* observers;

+(ConcerteSubject*) shareConcertSubject;

@end
