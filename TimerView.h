//
//  TimerView.h
//  EconApps
//
//  Created by Christian Weigandt on 9/28/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"

@interface TimerView : UIView{
    
    NSTimer* timer;
    DACircularProgressView* timerCircle;
    UILabel* timerLabel;
    
    NSInteger duration;
    NSDate* startTime;
    
    id target;
    SEL selector;
    
}

@property(nonatomic) NSTimer* timer;
@property(nonatomic) DACircularProgressView* timerCircle;
@property(nonatomic) UILabel* timerLabel;
@property(nonatomic) NSInteger duration;
@property(nonatomic) NSDate* startTime;
@property(nonatomic) id target;
@property(nonatomic) SEL selector;

- (id)initWithFrame:(CGRect)frame andDuration:(NSInteger)dur;

-(void)tick:(NSTimer*)t;
-(void)endRound;

@end
