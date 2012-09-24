//
//  PublicGoodsView.h
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewController.h"
#import "TokenStackView.h"
#import "Defs.h"
#import "Connection.h"

@interface PublicGoodsView : UIView{
    
    DataViewController *theGrid;
    TokenStackView* localStackView;
    TokenStackView* sendStackView;
    
    UIButton *sendButton;
    
}

@property (nonatomic) DataViewController *theGrid;
@property (nonatomic) TokenStackView *localStackView;
@property (nonatomic) TokenStackView *sendStackView;
@property (nonatomic) UIButton* sendButton;

-(void)sendTokens;

@end
