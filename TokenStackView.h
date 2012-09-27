//
//  TokenStackView.h
//  EconApps
//
//  Created by Christian Weigandt on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenView.h"
#import "EconApps/DataViewController.h"

@interface TokenStackView : UIView{
    
    NSInteger size;         //Number of tokens in stack
    NSInteger action;       //Number of fingers originally touched, i.e. if user is holding stack or single token
    UIView* holderView;     //Holds the token stack
    
    DataViewController *grid; //Grid associated with stack if there is one, otherwise nil.
    
    UILabel* sizeLabel;
    
    UILabel* nameLabel;
    
}

@property(nonatomic)DataViewController *grid;
@property(nonatomic)UIView* holderView;
@property(nonatomic) NSInteger size;
@property(nonatomic)UILabel* sizeLabel;
@property(nonatomic)UILabel* nameLabel;

-(id)initWithSize:(NSInteger)numTokens andFrame:(CGRect)frame andName:(NSString*)name;
-(void) addTokenfromPoint:(CGPoint)point;
-(void) addTokenfromPoint:(CGPoint)point withSpeed:(CGFloat)speed;
-(TokenView*) removeToken;
-(NSMutableArray*)sendTokensUp;

@end
