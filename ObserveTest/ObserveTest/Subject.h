//
//  Subject.h
//  ObserveTest
//
//  Created by 代隽杰 on 15/11/19.
//  Copyright © 2015年 gree. All rights reserved.
//

#ifndef Subject_h
#define Subject_h


#endif /* Subject_h */

@class Observer;

@protocol Subject

@required
-(void) attach: (Observer*) observer;
-(void) detach: (Observer*) observer;
-(void) notifyObservers;

@end