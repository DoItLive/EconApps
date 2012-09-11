//
//  WaitingView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "WaitingView.h"

@implementation WaitingView

@synthesize usernameLabel, activityIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void) initPolling{
    
    [NSTimer timerWithTimeInterval:3 target:self selector:@selector(poll:) userInfo:nil repeats:NO];
    
}

-(void)poll:(NSTimer*)timer{
    
    [[Connection alloc] initWithSelector:@selector(dataReceived:)
                                toTarget:self
                                 withURL:@"URL"
                              withString:@"HEYGIRL"];
    
}

-(void)dataReceived:(NSData*)data{
    
    
    
}


@end
