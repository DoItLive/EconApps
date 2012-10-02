//
//  TokenStackView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "TokenStackView.h"

@implementation TokenStackView

@synthesize holderView, size, grid, sizeLabel, nameLabel;

-(id) initWithSize:(NSInteger)numTokens andFrame:(CGRect)frame andName:(NSString *)name{
    
    self = [super initWithFrame:frame];
    
    UIFont* sizeFont = [UIFont fontWithName:@"Helvetica" size:self.frame.size.height-20];
    self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 15, frame.size.width, frame.size.height)];
    [self.sizeLabel setBackgroundColor:[UIColor clearColor]];
    [self.sizeLabel setFont:sizeFont];
    [self.sizeLabel setTextColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
    [self.sizeLabel setText:[NSString stringWithFormat:@"0"]];
    [self addSubview:sizeLabel];
    
    self.holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self addSubview:holderView];
    
    size = 0;
    for (int i=0;i<numTokens;i++) {
        [self addTokenfromPoint:holderView.center withSpeed:0];
    }
    
    UIFont* nameFont = [UIFont fontWithName:@"Futura" size:30];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-[name sizeWithFont:nameFont].width-10, 0, [name sizeWithFont:nameFont].width, [name sizeWithFont:nameFont].height)];
    self.nameLabel.text = name;
    self.nameLabel.textAlignment = UITextAlignmentLeft;
    self.nameLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.15];
    self.nameLabel.font = nameFont;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    
    [self setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"PG_TokenStack_BG.png"]]];
    action = 0;
    
    return self;
}

//point must be relative to screen
-(void) addTokenfromPoint:(CGPoint)point withSpeed:(CGFloat)speed{
    
    UIImageView* t = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"token-1.png"]];
    [t setFrame:CGRectMake(point.x-t.frame.size.width/2-self.frame.origin.x, point.y-t.frame.size.height/2-self.frame.origin.y, t.frame.size.width, t.frame.size.height)];
    [self.holderView addSubview:t];
    size++;
    [self.sizeLabel setText:[NSString stringWithFormat:@"%d",size]];
    if (self.grid) {
        [self.grid updateSelectedColumn: size + 1];
    }
    
    [UIView animateWithDuration:speed
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                            t.frame =  CGRectMake(self.frame.size.width-t.image.size.width*1.5, self.frame.size.height - t.image.size.height - size*2-10,t.frame.size.width,t.frame.size.height);
                     }
                     completion:nil];
    
}

-(void)addTokenfromPoint:(CGPoint)point{
    [self addTokenfromPoint:point withSpeed:0.2];
}

-(UIImageView *) removeToken{
    
    if(size > 0){
        UIImageView* t = [self.holderView.subviews lastObject];
        [t removeFromSuperview];
        size--;
        [self.sizeLabel setText:[NSString stringWithFormat:@"%d",size]];
        if (self.grid) {
            [self.grid updateSelectedColumn: size + 1];
        }
        return t;
    }
    return nil;
}

//Set action to the number of fingers
//Bring view to the front
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.superview bringSubviewToFront:self];
    if(size==0){
        action = 0;
    }else{
        for(UIView* view in [self.superview subviews]){
            if([view isKindOfClass:[TokenStackView class]])
                [view setUserInteractionEnabled:NO];
        }
        action = [[event allTouches] count];
    }
}

//Iterate through superview's subviews to find where the token(s) were released
//Thus if 2 tokenstackviews are able to trade then they must have the same superview
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UIView* view in [self.superview subviews]){
        if([view isKindOfClass:[TokenStackView class]])
            [view setUserInteractionEnabled:YES];
    }
    switch (action) {
        case 1:{
            action=0;
            CGPoint point = CGPointMake([(UITouch*)[touches anyObject] locationInView:self.superview].x, [(UITouch*)[touches anyObject] locationInView:self.superview].y);
            [self removeToken];
            for(UIView* view in [self.superview subviews]){
                if([view isKindOfClass:[TokenStackView class]] && CGRectContainsPoint(view.frame, point) && view!=self){
                    [(TokenStackView*)view addTokenfromPoint:point];
                    return;
                }
            }
            [self addTokenfromPoint:point];
            break;
        }case 2:{
            action=0;
            CGPoint startPoint = CGPointMake([(UITouch*)[touches anyObject] locationInView:self.superview].x, [(UITouch*)[touches anyObject] locationInView:self.superview].y);

            //CGPoint startPoint = CGPointMake(self.holderView.center.x+self.frame.origin.x, self.holderView.center.y+self.frame.origin.y);
            int numTokens = size;
            self.holderView.frame = CGRectMake(0, 0,self.holderView.frame.size.width,self.holderView.frame.size.height);
            for(UIImageView* t in [self.holderView subviews])
                [self removeToken];
            for(UIView* view in [self.superview subviews]){
                if([view isKindOfClass:[TokenStackView class]] && CGRectContainsPoint(view.frame, startPoint) && view!=self){
                    for(int i=0;i<numTokens;i++){
                        [(TokenStackView*)view addTokenfromPoint:startPoint withSpeed:(i+1)/25.0];
                    }
                    return;
                }
            }
            for(int i=0;i<numTokens;i++)
                [self addTokenfromPoint:startPoint withSpeed:(i+1)/15.0];
        }
        default:
            break;
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    switch(action){
        case 1:{
            CGPoint point = CGPointMake([(UITouch*)[touches anyObject] locationInView:self].x, [(UITouch*)[touches anyObject] locationInView:self].y);
            [[[self.holderView subviews] lastObject] setCenter:point];
            break;
        }case 2:
            [self.holderView setCenter:[(UITouch*)[touches anyObject] locationInView:self]];
            break;
        default:
            break;
    }
    
}

-(NSMutableArray*)removeAllTokens{
    
    NSMutableArray* tokens = [[NSMutableArray alloc] initWithCapacity:self.size];
    self.size = 0;
    for(UIImageView* t in [self.holderView subviews]){
        [tokens addObject:t];
        [t removeFromSuperview];
        
    }
    return tokens;
}



@end
