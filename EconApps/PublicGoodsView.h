//
//  PublicGoodsView.h
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DataViewController.h"
#import "TokenStackView.h"
#import "Defs.h"
#import "Connection.h"
#import "DACircularProgressView.h"
#import "TimerView.h"
#import "UserData.h"

@interface PublicGoodsView : UIView{
    
    DataViewController *theGrid;
    DataViewController *theOtherGrid;
    TokenStackView* localStackView;
    TokenStackView* sendStackView;
    
    UIButton *sendButton;
    DACircularProgressView* progressView;
    
    UserData *userData;
}

@property (nonatomic) DataViewController *theGrid;
@property (nonatomic) DataViewController *theOtherGrid;
@property (nonatomic) TokenStackView *localStackView;
@property (nonatomic) TokenStackView *sendStackView;
@property (nonatomic) UIButton* sendButton;
@property (nonatomic) DACircularProgressView* progressView;

-(void)buttonTouchDown;
-(void)buttonTouchUp;
-(void)buttonLeft;
-(void)moveTokensToPot;

@end
