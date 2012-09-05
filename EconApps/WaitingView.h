//
//  WaitingView.h
//  EconApps
//
//  Created by Christian Weigandt on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitingView : UIView{
    
    UILabel *usernameLabel;
    UIActivityIndicatorView *activityIndicator;
    
}

@property (nonatomic) IBOutlet UILabel *usernameLabel;
@property (nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
