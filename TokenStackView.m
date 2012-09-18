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
        [self addTokenfromPoint:CGPointMake(1, 1)];
    }
    
    [self setBackgroundColor:[UIColor redColor]];
    
    return self;
}

-(void) addTokenfromPoint:(CGPoint)point{
    
    TokenView* t = [[TokenView alloc] init];
    [t setFrame:CGRectMake(point.x-t.frame.size.width/2, point.y-t.frame.size.height/2, t.frame.size.width, t.frame.size.height)];
    [self addSubview:t];
    size++;
    
    [UIView beginAnimations: @"moveToken" context: nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDuration: 0.3];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    t.frame =  CGRectMake(self.frame.size.width/2-t.image.size.width/2, self.frame.size.height - t.image.size.height - size*2,t.frame.size.width,t.frame.size.height);
    [UIView commitAnimations];
    
}

-(TokenView *) removeToken{
    
    if(size > 0){
        TokenView* t = [self.subviews lastObject];
        [t removeFromSuperview];
        //[self.superview addSubview:t];
        size--;
        return t;
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    switch ([[event allTouches] count]) {
        case 1:{
            action = 1;
            NSLog(@"One finger");
            break;
        }
        case 2:{
            NSLog(@"Two fingers");
            action = 2;
        }
        default:
            break;
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    switch (action) {
        case 1:
            [self removeToken];
            [self addTokenfromPoint:[(UITouch*)[touches anyObject] locationInView:self.superview]];
            break;
        default:
            break;
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    switch(action){
        case 1:
            [[[self subviews] lastObject] setCenter:[(UITouch*)[touches anyObject] locationInView:self.superview]];
            break;
        case 2:
            [self setCenter:[(UITouch*)[touches anyObject] locationInView:self.superview]];
            break;
        default:
            break;
    }

    
}



@end
