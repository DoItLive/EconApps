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
    
}


-(id) initWithSize:(NSInteger)numTokens;
-(void) addToken;

@end
