//
//  TokenStackView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "TokenStackView.h"

@implementation TokenStackView

-(id) initWithSize:(NSInteger)numTokens andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    size = 0;
    NSLog(@"HERE");
    for (int i=0;i<numTokens;i++) {
        [self addToken];
    }
    
    UIPanGestureRecognizer* gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self addGestureRecognizer:gr];
    
    return self;
}

-(void) addToken{
    
    TokenView* t = [[TokenView alloc] init];
    [t setFrame:CGRectMake(0, self.frame.size.height - t.image.size.height - size*2, t.image.size.width, t.image.size.height)];
    [self addSubview:t];
    size++;
    
}

-(TokenView *) removeToken{
    
    if(size > 0){
        TokenView* t = [self.subviews lastObject];
        [t removeFromSuperview];
        [self.superview addSubview:t];
        size--;
        return t;
    }
    return nil;
}

-(void)swipe:(UIGestureRecognizer*)gr{
    
    [self setCenter: [gr locationInView:[self superview]]];
    switch(gr.numberOfTouches){
        case 1:
            //move one bro out
            break;
        case 2:
            //move the stack out
            break;
        default:
            break;
    }
    
}



@end
