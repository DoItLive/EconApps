//
//  PublicGoodsView.m
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "PublicGoodsView.h"
#import "Defs.h"

@implementation PublicGoodsView

@synthesize theGrid, theOtherGrid, localStackView, sendStackView, sendButton, progressView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        userData = [UserData userDataInstance]; //Get pointer to userData
        
        //Test to fill table with junk
        NSString* zero = [[NSString alloc] initWithFormat:@"0"];
        NSString* one = [[NSString alloc] initWithFormat:@"1"];
        NSString* two = [[NSString alloc] initWithFormat:@"2"];
        NSString* three = [[NSString alloc] initWithFormat:@"3"];
        NSString* four = [[NSString alloc] initWithFormat:@"4"];
        NSString* five = [[NSString alloc] initWithFormat:@"5"];
        NSString* six = [[NSString alloc] initWithFormat:@"6"];
        NSString* seven = [[NSString alloc] initWithFormat:@"7"];
        NSString* eight = [[NSString alloc] initWithFormat:@"8"];
        NSString* nine = [[NSString alloc] initWithFormat:@"9"];
        NSString* ten = [[NSString alloc] initWithFormat:@"10"];
        

        NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:zero,zero,one,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array2 = [[NSMutableArray alloc] initWithObjects:zero,zero,one,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array3 = [[NSMutableArray alloc] initWithObjects:one,one,two,three,four,five,six,seven,eight,nine,ten,zero, nil];
        NSMutableArray *array4 = [[NSMutableArray alloc] initWithObjects:two,two,three,four,five,six,seven,eight,nine,ten,zero,one, nil];
        NSMutableArray *array5 = [[NSMutableArray alloc] initWithObjects:three,three,four,five,six,seven,eight,nine,ten,zero,one,two, nil];
        NSMutableArray *array6 = [[NSMutableArray alloc] initWithObjects:four,four,five,six,seven,eight,nine,ten,zero,one,two,three, nil];
        NSMutableArray *array7 = [[NSMutableArray alloc] initWithObjects:five,five,six,seven,eight,nine,ten,zero,one,two,three,four, nil];
        NSMutableArray *array8 = [[NSMutableArray alloc] initWithObjects:six,six,seven,eight,nine,ten,zero,one,two,three,four,five, nil];
        NSMutableArray *array9 = [[NSMutableArray alloc] initWithObjects:seven,seven,eight,nine,ten,zero,one,two,three,four,five,six, nil];
        NSMutableArray *array10 = [[NSMutableArray alloc] initWithObjects:eight,eight,nine,ten,zero,one,two,three,four,five,six,seven, nil];
        NSMutableArray *array11 = [[NSMutableArray alloc] initWithObjects:nine,nine,ten,zero,one,two,three,four,five,six,seven,eight, nil];
        NSMutableArray *array12 = [[NSMutableArray alloc] initWithObjects:ten,ten,zero,one,two,three,four,five,six,seven,eight,nine, nil];
        NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:array1,array2,array3,array4,array5,array6,array7,array8,array9,array10,array11,array12, nil];
        
        
        NSString* round = [[NSString alloc] initWithFormat:@"Round"];
        NSString* yousent = [[NSString alloc] initWithFormat:@"You Sent"];
        NSString* avgsent = [[NSString alloc] initWithFormat:@"Average Others Sent"];
        NSString* total = [[NSString alloc] initWithFormat:@"Total Sent"];
        NSString* outcome = [[NSString alloc] initWithFormat:@"Outcome"];
        NSString* roundearnings = [[NSString alloc] initWithFormat:@"Round Earnings"];
        NSString* totalearnings = [[NSString alloc] initWithFormat:@"Total Earnings"];
        
        NSMutableArray *arraya = [[NSMutableArray alloc] initWithObjects:round,one,two,three,four,five, nil];
        NSMutableArray *arrayb = [[NSMutableArray alloc] initWithObjects:yousent,ten,eight,four,seven,three, nil];
        NSMutableArray *arrayc = [[NSMutableArray alloc] initWithObjects:avgsent,three,four,two,six,nine, nil];
        NSMutableArray *arrayd = [[NSMutableArray alloc] initWithObjects:total,five,nine,four,three,seven, nil];
        NSMutableArray *arraye = [[NSMutableArray alloc] initWithObjects:outcome,one,two,three,four,five, nil];
        NSMutableArray *arrayf = [[NSMutableArray alloc] initWithObjects:roundearnings,five,four,three,two,one, nil];
        NSMutableArray *arrayg = [[NSMutableArray alloc] initWithObjects:totalearnings,five,six,seven,eight,nine, nil];
        NSMutableArray *otherData = [[NSMutableArray alloc] initWithObjects:arraya,arrayb,arrayc,arrayd,arraye,arrayf,arrayg, nil];
        
        self.theGrid = [[DataViewController alloc] initWithFrame:CGRectMake(10, 200, self.frame.size.height, 250) andData:data andStyle:kUNIFORM];
        [self addSubview:theGrid.view];
      
        self.theOtherGrid = [[DataViewController alloc] initWithFrame:CGRectMake(10, 500, self.frame.size.height, 200) andData:otherData andStyle:kNON_UNIFORM];
        [self addSubview:theOtherGrid.view];
        
        localStackView = [[TokenStackView alloc] initWithSize:10 andFrame:CGRectMake(160, 30, 300, 150) andName:@"My Tokens"];
        [self addSubview:localStackView];

        sendStackView = [[TokenStackView alloc] initWithSize:0 andFrame:CGRectMake(567, 30, 300, 150) andName:@"Tokens to Send"];
        [sendStackView setGrid:theGrid];
        [self addSubview:sendStackView];
        
        //Send button with 3 functions to control user interaction and the progress view
        sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"token-blank.png"] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sendButton.adjustsImageWhenHighlighted = NO;
        [sendButton setTitle:@"Send" forState:UIControlStateNormal];
        sendButton.frame = CGRectMake(900, sendStackView.center.y-50, 100, 100);
        [sendButton addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];
        [sendButton addTarget:self action:@selector(buttonTouchUp) forControlEvents:UIControlEventTouchUpInside];
        [sendButton addTarget:self action:@selector(buttonLeft) forControlEvents:UIControlEventTouchDragExit];
        [self addSubview:sendButton];
        
        progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(sendButton.center.x-50, sendButton.center.y-50, 100, 100)];
        progressView.roundedCorners = NO;
        progressView.progressTintColor = [UIColor whiteColor];
        progressView.trackTintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        [progressView setThicknessRatio:0.33];
        progressView.hidden = YES;
        [self addSubview:progressView];
        
        TimerView* timerView = [[TimerView alloc] initWithFrame:CGRectMake(30, sendButton.frame.origin.y, 100, 100) andDuration:630];
        [self addSubview:timerView];
        
    }
    return self;
}

-(void)buttonTouchDown{
    
    progressView.hidden = NO;
    [progressView setProgress:1.f animated:YES duration:1.0 andTimingFunc:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
}

-(void)buttonTouchUp{
    
    progressView.hidden = YES;
    if([progressView.layer.animationKeys count] > 0){
        progressView.progress = 0;
    }else{
        [self moveTokensToPot];
    }
    
    [progressView.layer removeAllAnimations];
    
}

-(void)buttonLeft{
    
    progressView.hidden = YES;
    [progressView.layer removeAllAnimations];
    progressView.progress = 0;
    
}

-(void)moveTokensToPot{
    
    NSMutableArray* tokens = [sendStackView sendTokensUp];
    
    //Set up potView to animate inwards
    UIImageView* potView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"potOfGold.png"]];
    potView.frame = CGRectMake(self.frame.size.height, 0, 200, 200);
    UILabel* potLabel = [[UILabel alloc] init];
    potLabel.text = [NSString stringWithFormat:@"0+?"];
    potLabel.frame = CGRectMake(0, potView.frame.size.height/1.5,potView.frame.size.width,40);
    potLabel.textColor = [UIColor whiteColor];
    potLabel.textAlignment = UITextAlignmentCenter;
    potLabel.backgroundColor = [UIColor clearColor];
    potLabel.font = [UIFont fontWithName:@"Helvetica" size:40];
    [potView addSubview:potLabel];
    [self addSubview:potView];
    [self.sendStackView removeFromSuperview];
    [self.sendButton removeFromSuperview];
    
    [UIView animateWithDuration:0.4
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         potView.frame = CGRectMake(self.frame.size.height-potView.frame.size.width*1.5, 0, potView.frame.size.width,potView.frame.size.height);
                     }
                     completion:nil];

    
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    int curToken = 1;
    //Move tokens to public goods view and do a loop animation
    for(TokenView* t in tokens){
        t.center = CGPointMake(t.center.x+sendStackView.frame.origin.x, t.center.y+sendStackView.frame.origin.y);
        [self addSubview:t];
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        [path moveToPoint:t.center];
        [path addCurveToPoint:t.center controlPoint1:CGPointMake(t.center.x, self.frame.size.height) controlPoint2:CGPointMake(0, t.center.y)];
        anim.path = path.CGPath;
        anim.rotationMode = kCAAnimationRotateAuto;
        anim.repeatCount = 0;
        anim.duration = (double)curToken/[tokens count]+1;
        [t.layer addAnimation:anim forKey:@"moveToPot"];
        //This block of code gets executed after anim.duration seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, anim.duration * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            potLabel.text = [NSString stringWithFormat:@"%d+?",curToken];
            [t removeFromSuperview];
        });
        
        [path removeAllPoints];
            curToken++;
        
    }
    
    
    NSString* postString = [[NSString alloc] initWithFormat:@"tokens=%d",[tokens count]];
    //Connection *conn = [[Connection alloc] initWithFinishSelector:@selector(validateLogin:)
    //                                             withFailSelector:@selector(validateLogin:)
    //                                                     toTarget:self
    //                                                      withURL:kLOGIN_VIEW_URL
    //                                                   withString:postString];
    //[conn connect];
    
    [self.sendButton setEnabled:FALSE];
    [self.localStackView setUserInteractionEnabled:FALSE];
    [self.sendStackView setUserInteractionEnabled:FALSE];
    
}

@end
