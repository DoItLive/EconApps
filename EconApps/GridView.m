//
//  GridView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/6/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)data
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"Init gridView");
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.showsHorizontalScrollIndicator = FALSE;
        [self addSubview:scrollView];
        
        NSInteger columns = [data count];
        //NSInteger rows = [(NSMutableArray*)[data objectAtIndex:1] count];
        
        scrollView.contentSize = CGSizeMake(columns*50, 1);

        tableViews = [[NSMutableArray alloc] initWithCapacity:columns];
        
        for (int i=0;i<columns;i++){
            
            UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(i*50, 0, 50, frame.size.height)];
            t.dataSource = [data objectAtIndex:i];
            [tableViews addObject:t];
            [scrollView addSubview:t];
            NSLog(@"table %d",i);
        }
        
    }
    return self;
}




@end
