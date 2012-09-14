//
//  GridView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/6/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "GridView.h"

@implementation GridView

@synthesize scrollView, controller, tableViews;

- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)data
{
    self = [super initWithFrame:frame];
    if (self) {
        //Initialize the scrollView
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.showsHorizontalScrollIndicator = FALSE;
        scrollView.bounces = FALSE;
        [self addSubview:scrollView];
                
        /*Find the size of the data set and set the content size of scrollView properly
          Initialize the controller/delegate/datasource
         */
        controller = [[GridViewController alloc] initWithStyle:UITableViewStylePlain];
        [controller setData:data];
        
        controller.numCols = [[NSNumber alloc] initWithInt:[data count]];
        NSLog(@"number of columns %d", [controller.numCols intValue]);
        controller.numRows = [[NSNumber alloc] initWithInt:[[data objectAtIndex:0] count]];
        NSLog(@"Initializing grid of size %d*%d",[controller.numRows intValue], [controller.numCols intValue]);
        [controller setCellWidth:[[NSNumber alloc] initWithInt:frame.size.width/[controller.numCols intValue]]];
        
        int cellHeight = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"].frame.size.height;
        scrollView.contentSize = CGSizeMake(1, [controller.numRows intValue]*cellHeight);
        
        
        tableViews = [[NSMutableArray alloc] initWithCapacity:[controller.numCols intValue]];
        
        /*Loop through each table and initialize properties
          Set each table's delegate and datasource
          Also add it to tableViews
         */
        for (int i=0;i<[controller.numCols intValue];i++){
            NSLog(@"making column %d",i);
            UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(i*101, 0, 100, scrollView.contentSize.height)];
            [t setDelegate:controller];
            [t setDataSource:controller];
            t.showsVerticalScrollIndicator = NO;
            t.backgroundColor = [UIColor clearColor];
            t.separatorColor = [UIColor purpleColor];
            [tableViews addObject:t];
            [scrollView addSubview:t];
        }
    }
    return self;
}


@end
