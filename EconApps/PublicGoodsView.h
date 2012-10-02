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
    
    UIImageView* potView;
    UILabel* potViewLabel;
    
    UserData *userData;
}

@property (nonatomic) DataViewController *theGrid;
@property (nonatomic) DataViewController *theOtherGrid;
@property (nonatomic) TokenStackView *localStackView;
@property (nonatomic) TokenStackView *sendStackView;
@property (nonatomic) UIButton* sendButton;
@property (nonatomic) DACircularProgressView* progressView;
@property (nonatomic) UIImageView* potView;
@property (nonatomic) UILabel* potViewLabel;

//Touch down on send button
-(void)buttonTouchDown;

//Touch up on send button
-(void)buttonTouchUp;

//Leave send button after touch down
-(void)buttonLeft;

//Called after send button was 'activated'
//Moves tokens to pot
-(void)moveTokensToPot;

//Called at timeout
-(void)endRound;

@end
