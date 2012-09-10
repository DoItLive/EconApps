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
    
    [self poll:nil];
    
}

-(void)poll:(NSTimer*)timer{
    
    [[Connection alloc] initWithSelector:@selector(dataReceived:)
                                toTarget:self
                                 withURL:@"URL"
                              withString:@"HEYGIRL"];
    
}

-(void)dataReceived:(NSData*)data{
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *chunks = [[NSArray alloc] initWithArray:[responseString componentsSeparatedByString: @","]];
    
    NSInteger roundStarted = [[chunks objectAtIndex:0] integerValue];
    
    //0 means to keep polling
    //1 means that the round has started
    
    if (roundStarted){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToPublicGoodsView" object:nil];
    }else{
        [NSTimer timerWithTimeInterval:3 target:self selector:@selector(poll:) userInfo:nil repeats:NO];
    }
    
}


@end
