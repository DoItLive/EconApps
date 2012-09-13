//
//  TokenStackView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "TokenStackView.h"

@implementation TokenStackView

-(id) initWithSize:(NSInteger)numTokens{
    
    self = [super init];
    size = 0;
    for (int i=0;i<size;i++) {
        [self addToken];
    }
    
    return self;
}

-(void) addToken{
    
    TokenView* t = [[TokenView alloc] init];
    [t setFrame:CGRectMake(0, self.frame.size.height - t.frame.size.height - size*2, t.frame.size.width, t.frame.size.height)];
    [self addSubview:t];
    size++;
    
}

-(void) removeToken{
    
    if(size > 0){
        [[self.subviews lastObject] removeFromSuperview];
        size--;
    }
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    switch ([touches count]) {
        case 1:
            [self removeToken];
            break;
        case 2:
            [self becomeFirstResponder];
            break;
        default:
            break;
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //[self addToken];
    
}

@end
