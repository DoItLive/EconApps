//
//  PublicGoodsView.m
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "PublicGoodsView.h"

@implementation PublicGoodsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:0,1,2,3,4, nil];
        NSMutableArray *array2 = [[NSMutableArray alloc] initWithObjects:0,5,2,3,4, nil];
        NSMutableArray *array3 = [[NSMutableArray alloc] initWithObjects:0,6,2,3,4, nil];
        NSMutableArray *array4 = [[NSMutableArray alloc] initWithObjects:0,7,2,3,4, nil];
        NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:array1,array2,array3,array4, nil];

        gridView = [[GridView alloc] initWithFrame:CGRectMake(0, 0, 400, 200) andData:data];
        [self addSubview:gridView];

    }
    return self;
}

@end
