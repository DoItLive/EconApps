//
//  WaitingView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "WaitingView.h"
#import "Defs.h"

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
    
    [NSTimer timerWithTimeInterval:kPOLLING_INTERVAL target:self selector:@selector(poll:) userInfo:nil repeats:NO];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator startAnimating];
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
