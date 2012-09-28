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

-(void) initView {
    
    userData = [UserData userDataInstance];
    [usernameLabel setText:[NSString stringWithFormat:@"%@ %@",userData.firstName,userData.lastName]];
    [usernameLabel setTextColor:[UIColor whiteColor]];
    
    [activityIndicator startAnimating];
    
    [self poll:nil]; //Start polling the server
}

-(void)poll:(NSTimer*)timer{
    
    Connection *conn = [[Connection alloc] initWithFinishSelector:@selector(dataReceived:)
                             withFailSelector:@selector(connectionFailed)
                                      toTarget:self
                                       withURL:kWAITING_VIEW_URL
                                    withString:@""];
    [conn connect];
}

-(void)dataReceived:(NSData*)data{
    
    // Data should come back from the server in a JSON string. It should look like:
    // code:{0,1,2}
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger code = [[jsonData objectForKey:@"code"] integerValue];
    
    //Switch to the correct module based off of the information from the server
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

//If the connection fails then just keep polling to hopefully reconnect
-(void)connectionFailed {
    [NSTimer scheduledTimerWithTimeInterval:kPOLLING_INTERVAL target:self selector:@selector(poll:) userInfo:nil repeats:NO];
}

@end
