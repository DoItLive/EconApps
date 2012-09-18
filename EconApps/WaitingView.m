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

-(void) initView:(NSString *)nameLabelText{
    [usernameLabel setText:nameLabelText];
    
    [activityIndicator startAnimating];
    
    [self poll:nil];
}

-(void)poll:(NSTimer*)timer{
    
    [[Connection alloc] initWithFinishSelector:@selector(dataReceived:)
                             withFailSeclector:@selector(connectionFailed)
                                      toTarget:self
                                       withURL:kWAITING_VIEW_URL
                                    withString:@""];
}

-(void)dataReceived:(NSData*)data{
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger code = [[jsonData objectForKey:@"code"] integerValue];
    
    switch (code) {
        case kPUBLIC_GOODS_MODULE:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToPublicGoodsView" object:nil];
            break;
        case kPIT_MARKET_MODULE:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToPitMarketView" object:nil];
            break;
        default:
            [NSTimer scheduledTimerWithTimeInterval:kPOLLING_INTERVAL target:self selector:@selector(poll:) userInfo:nil repeats:NO];
            break;
    }
    
}

-(void)connectionFailed {
    [NSTimer scheduledTimerWithTimeInterval:kPOLLING_INTERVAL target:self selector:@selector(poll:) userInfo:nil repeats:NO];
}

@end
