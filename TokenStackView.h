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
    
    NSInteger size;
    NSInteger action;
    
}


-(id)initWithSize:(NSInteger)numTokens andFrame:(CGRect)frame;
-(void) addTokenfromPoint:(CGPoint)point;
-(TokenView*) removeToken;

@end
