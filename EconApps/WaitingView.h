//
//  WaitingView.h
//  EconApps
//
//  Created by Christian Weigandt on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "UserData.h"

@interface WaitingView : UIView{
    
    UILabel *usernameLabel;
    UIActivityIndicatorView *activityIndicator;
    
    UserData *userData;
}

@property (nonatomic) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)initView;
-(void)poll:(NSTimer*)timer;
-(void)dataReceived:(NSData*)data;


@end
