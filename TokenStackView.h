//
//  TokenStackView.h
//  EconApps
//
//  Created by Christian Weigandt on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenView.h"

@interface TokenStackView : UIView{
    
    NSInteger size;         //Number of tokens in stack
    NSInteger action;       //Number of fingers originally touched, i.e. if user is holding stack or single token
    UIView* holderView;     //Holds the token stack
    
}

@property(nonatomic)UIView* holderView;

-(id)initWithSize:(NSInteger)numTokens andFrame:(CGRect)frame;
-(void) addTokenfromPoint:(CGPoint)point;
-(void) addTokenfromPoint:(CGPoint)point withSpeed:(CGFloat)speed;
-(TokenView*) removeToken;

@end
