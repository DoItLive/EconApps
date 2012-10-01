//
//  PublicGoodsView.m
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "PublicGoodsView.h"

@implementation PublicGoodsView

@synthesize theGrid, localStackView, sendStackView, sendButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        //Test to fill table with junk
        NSString* one = [[NSString alloc] initWithFormat:@"I like fishsticks"];
        NSString* two = [[NSString alloc] initWithFormat:@"2"];
        NSString* three = [[NSString alloc] initWithFormat:@"Thomas doesnt love you"];
        NSString* four = [[NSString alloc] initWithFormat:@"4"];
        NSString* five = [[NSString alloc] initWithFormat:@"timbuktu"];
        NSString* six = [[NSString alloc] initWithFormat:@"6"];
        NSString* seven = [[NSString alloc] initWithFormat:@"theres a pie over there"];
        NSString* eight = [[NSString alloc] initWithFormat:@"8"];
        NSString* nine = [[NSString alloc] initWithFormat:@"9"];
        NSString* ten = [[NSString alloc] initWithFormat:@"10"];
        NSString* eleven = [[NSString alloc] initWithFormat:@"11"];

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
        
        self.theGrid = [[DataViewController alloc] initWithFrame:CGRectMake(10, 200, self.frame.size.height, 300) andData:data andStyle:kNON_UNIFORM];
        [self addSubview:theGrid.view];
        //[self.theGrid setUpHierarchy];
        
        localStackView = [[TokenStackView alloc] initWithSize:10 andFrame:CGRectMake(60, 30, 300, 150)];
        [self addSubview:localStackView];

        //TokenStackView* stackView2 = [[TokenStackView alloc] initWithSize:0 andFrame:CGRectMake(667, 30, 300, 150)];
        sendStackView = [[TokenStackView alloc] initWithSize:0 andFrame:CGRectMake(567, 30, 300, 150)];
        [sendStackView setGrid:theGrid];
        [self addSubview:sendStackView];
        
        sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sendButton setTitle:@"Send" forState:UIControlStateNormal];
        sendButton.frame = CGRectMake(900, 30, 100, 40);
        [sendButton addTarget:self action:@selector(sendTokens) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendButton];
    }
    return self;
}

-(void)sendTokens{

    int numTokenstoSend = [sendStackView sendTokensUp];
    NSString* postString = [[NSString alloc] initWithFormat:@"tokens=%d",numTokenstoSend];
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
