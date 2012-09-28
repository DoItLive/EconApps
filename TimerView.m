//
//  TimerView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/28/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "TimerView.h"

@implementation TimerView

@synthesize timer, timerCircle, timerLabel, duration, startTime;

- (id)initWithFrame:(CGRect)frame andDuration:(NSInteger)dur
{
    self = [super initWithFrame:frame];
    if (self) {
       
        duration = dur;
        
        startTime = [NSDate date];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        
        CGRect circleFrame = CGRectMake(0, 0, frame.size.width, frame.size.width);
        timerCircle = [[DACircularProgressView alloc] initWithFrame:circleFrame];
        timerCircle.roundedCorners = YES;
        timerCircle.progressTintColor = [UIColor whiteColor];
        timerCircle.trackTintColor = [UIColor clearColor];
        [timerCircle setThicknessRatio:0.10];
        [self addSubview:timerCircle];
        [timerCircle setProgress:1.f];
        [timerCircle setProgress:0.f animated:YES duration:duration andTimingFunc:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        
        timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        timerLabel.textAlignment = UITextAlignmentCenter;
        timerLabel.backgroundColor = [UIColor clearColor];
        timerLabel.textColor = [UIColor whiteColor];
        timerLabel.font = [UIFont fontWithName:@"Helvetica" size:frame.size.height/4];
        timerLabel.text = [NSString stringWithFormat:@"%d:%02d",(int)duration/60,(int)duration%60];
        [self addSubview:timerLabel];
                
        
    }
    return self;
}

-(void)tick:(NSTimer*)t{
    
    NSTimeInterval tI = [[NSDate date] timeIntervalSinceDate:startTime];
    int newTime = ceil(duration - tI);
    if(newTime == 0){
        [timer invalidate];
        [self endRound];
    }
    
    self.timerLabel.text = [NSString stringWithFormat:@"%d:%02d",newTime/60,newTime%60];

    
}

-(void)endRound{
    
    NSLog(@"Round over");
    
}

@end
