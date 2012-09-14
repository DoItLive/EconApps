//
//  DataView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/12/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "DataView.h"

@implementation DataView

@synthesize body, header;

- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)data
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        int cellHeight = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"].frame.size.height;
        //Who knows why we need to divide by 2
        CGRect bodyFrame = CGRectMake(0, cellHeight/2, frame.size.width, frame.size.height-cellHeight);
        
        int numCols = [data count];
        int numRows = [[data objectAtIndex:0] count];
        
        NSMutableArray* bodyData = [[NSMutableArray alloc] initWithCapacity:numCols+1];
        NSMutableArray* firstCol = [[NSMutableArray alloc] initWithCapacity:numRows];
        
        for(int i=1;i<numRows+1;i++){
            [firstCol addObject:[[NSNumber alloc] initWithInt:i]];
        }
        [bodyData addObject:firstCol];
        
        NSMutableArray* headerData = [[NSMutableArray alloc] initWithCapacity:numCols];
        for(int i=0;i<numCols;i++){
            [headerData addObject:[[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:i+1], nil]];
            [bodyData addObject:[[NSMutableArray alloc] initWithArray:[data objectAtIndex:i] copyItems:YES]];
        }
        
        self.body = [[GridView alloc] initWithFrame:bodyFrame andData:bodyData];
        CGRect headerFrame = CGRectMake([self.body.controller.cellWidth intValue], 0, frame.size.width, cellHeight);
        self.header = [[GridView alloc] initWithFrame:headerFrame andData:headerData];

        [self addSubview:header];
        [self addSubview:body];
    }
    return self;
}

@end
