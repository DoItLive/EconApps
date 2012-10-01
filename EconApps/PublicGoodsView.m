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

@synthesize theGrid, localStackView, sendStackView, sendButton, progressView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        userData = [UserData userDataInstance]; //Get pointer to userData
        
        //Test to fill table with junk
        NSNumber* one = [[NSNumber alloc] initWithInt:1];
        NSNumber* two = [[NSNumber alloc] initWithInt:2];
        NSNumber* three = [[NSNumber alloc] initWithInt:3];
        NSNumber* four = [[NSNumber alloc] initWithInt:4];
        NSNumber* five = [[NSNumber alloc] initWithInt:5];
        NSNumber* six = [[NSNumber alloc] initWithInt:6];
        NSNumber* seven = [[NSNumber alloc] initWithInt:7];
        NSNumber* eight = [[NSNumber alloc] initWithInt:8];
        NSNumber* nine = [[NSNumber alloc] initWithInt:9];
        NSNumber* ten = [[NSNumber alloc] initWithInt:10];
        NSNumber* eleven = [[NSNumber alloc] initWithInt:11];

        NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:seven,two,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array2 = [[NSMutableArray alloc] initWithObjects:two,two,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array3 = [[NSMutableArray alloc] initWithObjects:three,two,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array4 = [[NSMutableArray alloc] initWithObjects:four,two,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array5 = [[NSMutableArray alloc] initWithObjects:five,two,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array6 = [[NSMutableArray alloc] initWithObjects:six,two,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array7 = [[NSMutableArray alloc] initWithObjects:seven,two,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array8 = [[NSMutableArray alloc] initWithObjects:one,three,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array9 = [[NSMutableArray alloc] initWithObjects:two,three,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array10 = [[NSMutableArray alloc] initWithObjects:three,three,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array11 = [[NSMutableArray alloc] initWithObjects:four,three,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *array12 = [[NSMutableArray alloc] initWithObjects:five,three,three,four,five,six,seven,eight,nine,ten,eleven, nil];
        NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:array1,array2,array3,array4,array5,array6,array7,array8,array9,array10,array11,array12, nil];
        
        self.theGrid = [[DataViewController alloc] initWithFrame:CGRectMake(10, 200, self.frame.size.height, 300) andData:data];
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
        
        progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(sendButton.center.x-50, sendButton.center.y-50, 100, 100)];
        progressView.roundedCorners = NO;
        progressView.progressTintColor = [UIColor whiteColor];
        progressView.trackTintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        [progressView setThicknessRatio:0.33];
        progressView.hidden = YES;
        [self addSubview:progressView];
        
        TimerView* timerView = [[TimerView alloc] initWithFrame:CGRectMake(30, sendButton.frame.origin.y, 100, 100) andDuration:630];
        [self addSubview:timerView];
        
        [self poll:nil]; //Start polling the server
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
    Connection *conn = [[Connection alloc] initWithFinishSelector:nil
                                                 withFailSelector:nil
                                                         toTarget:self
                                                          withURL:kSEND_TOKENS_URL
                                                       withString:postString];
    [conn connect];
    
    [self.sendButton setEnabled:FALSE];
    [self.localStackView setUserInteractionEnabled:FALSE];
    [self.sendStackView setUserInteractionEnabled:FALSE];
    
}

//===============================Polling the server===============================================
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
