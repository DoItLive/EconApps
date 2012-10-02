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

@synthesize theGrid, localStackView, sendStackView, sendButton, progressView, potView, potViewLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        userData = [UserData userDataInstance]; //Get pointer to userData
        
        //Test to fill table with junk
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

        NSMutableArray *array0 = [[NSMutableArray alloc] initWithObjects:one,one,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:one,three,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array2 = [[NSMutableArray alloc] initWithObjects:two,three,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array3 = [[NSMutableArray alloc] initWithObjects:three,three,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array4 = [[NSMutableArray alloc] initWithObjects:four,three,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array5 = [[NSMutableArray alloc] initWithObjects:five,three,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array6 = [[NSMutableArray alloc] initWithObjects:six,three,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array7 = [[NSMutableArray alloc] initWithObjects:seven,three,two,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array8 = [[NSMutableArray alloc] initWithObjects:eight,three,three,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array9 = [[NSMutableArray alloc] initWithObjects:nine,three,three,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *array10 = [[NSMutableArray alloc] initWithObjects:ten,three,three,three,four,five,six,seven,eight,nine,ten, nil];
        NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:array0,array1,array2,array3,array4,array5,array6,array7,array8,array9,array10, nil];
        
        self.theGrid = [[DataViewController alloc] initWithFrame:CGRectMake(10, 200, self.frame.size.height, 300) andData:data andStyle:kUNIFORM];
        [self addSubview:theGrid.view];
        //[self.theGrid setUpHierarchy];
        
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
        
        progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        progressView.roundedCorners = NO;
        progressView.progressTintColor = [UIColor whiteColor];
        progressView.trackTintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        [progressView setThicknessRatio:0.33];
        progressView.hidden = YES;
        [self.sendButton addSubview:progressView];
        
        TimerView* timerView = [[TimerView alloc] initWithFrame:CGRectMake(30, sendButton.frame.origin.y, 100, 100) andDuration:9];
        [timerView setTarget:self];
        [timerView setSelector:@selector(endRound)];
        [self addSubview:timerView];
        
        potView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"potOfGold.png"]];
        potView.frame = CGRectMake(self.frame.size.height, 0, 200, 200);
        potView.hidden = YES;
        potViewLabel = [[UILabel alloc] init];
        potViewLabel.text = [NSString stringWithFormat:@"0+?"];
        potViewLabel.frame = CGRectMake(0, potView.frame.size.height/1.5,potView.frame.size.width,40);
        potViewLabel.textColor = [UIColor whiteColor];
        potViewLabel.textAlignment = UITextAlignmentCenter;
        potViewLabel.backgroundColor = [UIColor clearColor];
        potViewLabel.font = [UIFont fontWithName:@"Helvetica" size:40];
        [potView addSubview:potViewLabel];
        [self addSubview:potView];

        
    }
    return self;
}

#pragma mark - Token Functions

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
    
    potView.hidden = NO; //Probably do this first as the check in endRound relies on this begin set
    
    NSMutableArray* tokens = [sendStackView removeAllTokens];
    
    [self.sendButton setEnabled:FALSE];
    [self.localStackView setUserInteractionEnabled:FALSE];
    [self.sendStackView setUserInteractionEnabled:FALSE];
    [self.sendStackView removeFromSuperview];
    [self.sendButton removeFromSuperview];
    
    [UIView animateWithDuration: 0.4
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         potView.frame = CGRectMake(self.frame.size.height-potView.frame.size.width*1.5, 0, potView.frame.size.width,potView.frame.size.height);
                     }
                     completion:nil];

    
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    int curToken = 1;
    //Move tokens to public goods view and do a loop animation
    for(UIImageView* t in tokens){
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
            potViewLabel.text = [NSString stringWithFormat:@"%d+?",curToken];
            [t removeFromSuperview];
        });
        
        [path removeAllPoints];
            curToken++;
        
    }
    
    
    NSString* postString = [[NSString alloc] initWithFormat:@"tokens=%d",[tokens count]];
    Connection *conn = [[Connection alloc] initWithFinishSelector:nil
                                                 withFailSelector:nil
                                                         toTarget:self
                                                          withURL:kSEND_TOKENS_URL
                                                       withString:postString];
    [conn connect];
    
}

-(void)endRound{
    
    //TODO - Fix for case when game ends while user is holding a token
    if(self.potView.hidden == YES){  //User hasn't sent tokens yet
        [self moveTokensToPot];
    }
    
    //Wait 3 seconds for decision to set in before switching views
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        NSLog(@"Switch to end round view");
    });
}


#pragma mark - Polling

-(void)poll:(NSTimer*)timer{
    
    Connection *conn = [[Connection alloc] initWithFinishSelector:@selector(dataReceived:)
                                                 withFailSelector:@selector(connectionFailed)
                                                         toTarget:self
                                                          withURL:kWAITING_VIEW_URL
                                                       withString:@""];
    [conn connect];
}

-(void)dataReceived:(NSData*)data{
    
    // Data should come back from the server in a JSON string. It should look like:
    // 
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    //Parse data here
    [NSTimer scheduledTimerWithTimeInterval:kPUBLIC_GOODS_POLLING_INTERVAL target:self selector:@selector(poll:) userInfo:nil repeats:NO];
}

//If the connection fails then just keep polling to hopefully reconnect
-(void)connectionFailed {
    [NSTimer scheduledTimerWithTimeInterval:kPUBLIC_GOODS_POLLING_INTERVAL target:self selector:@selector(poll:) userInfo:nil repeats:NO];
}


@end
