//
//  PublicGoodsView.m
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "PublicGoodsView.h"

@implementation PublicGoodsView

@synthesize theGrid;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        //Test to fill table with junk
        NSNumber* one = [[NSNumber alloc] initWithInt:1];
        NSNumber* two = [[NSNumber alloc] initWithInt:2];
        NSNumber* three = [[NSNumber alloc] initWithInt:3];
        NSNumber* four = [[NSNumber alloc] initWithInt:4];
        NSNumber* five = [[NSNumber alloc] initWithInt:5];
        NSNumber* six = [[NSNumber alloc] initWithInt:6];
        NSNumber* seven = [[NSNumber alloc] initWithInt:7];

        NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:one,two,three,four,five,six,seven, nil];
        NSMutableArray *array2 = [[NSMutableArray alloc] initWithObjects:two,two,three,four,five,six,seven, nil];
        NSMutableArray *array3 = [[NSMutableArray alloc] initWithObjects:three,two,three,four,five,six,seven, nil];
        NSMutableArray *array4 = [[NSMutableArray alloc] initWithObjects:four,two,three,four,five,six,seven, nil];
        NSMutableArray *array5 = [[NSMutableArray alloc] initWithObjects:five,two,three,four,five,six,seven, nil];
        NSMutableArray *array6 = [[NSMutableArray alloc] initWithObjects:six,two,three,four,five,six,seven, nil];
        NSMutableArray *array7 = [[NSMutableArray alloc] initWithObjects:seven,two,three,four,five,six,seven, nil];
        NSMutableArray *array8 = [[NSMutableArray alloc] initWithObjects:one,three,three,four,five,six,seven, nil];
        NSMutableArray *array9 = [[NSMutableArray alloc] initWithObjects:two,three,three,four,five,six,seven, nil];
        NSMutableArray *array10 = [[NSMutableArray alloc] initWithObjects:three,three,three,four,five,six,seven, nil];
        NSMutableArray *array11 = [[NSMutableArray alloc] initWithObjects:four,three,three,four,five,six,seven, nil];
        NSMutableArray *array12 = [[NSMutableArray alloc] initWithObjects:five,three,three,four,five,six,seven, nil];
        NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:array1,array2,array3,array4,array5,array6,array7,array8,array9,array10,array11,array12, nil];

        self.theGrid = [[DataViewController alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.height-20, 200) andData:data];
        [self addSubview:theGrid.view];

    }
    return self;
}

@end
