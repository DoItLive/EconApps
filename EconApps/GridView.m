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
        //Initialize the scrollView and turns its horizontal slider off
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.showsHorizontalScrollIndicator = FALSE;
        [self addSubview:scrollView];
                
        /*Find the size of the data set and set the content size of scrollView properly
          Initialize the controller/delegate/datasource
         */
        controller = [[GridViewController alloc] initWithStyle:UITableViewStylePlain];
        [controller setData:data];
        controller.numCols = [[NSNumber alloc] initWithInt:[data count]];
        controller.numRows = [[NSNumber alloc] initWithInt:[[data objectAtIndex:0] count]];
        NSLog(@"Initializing grid of size %d*%d",[controller.numRows intValue], [controller.numCols intValue]);
        
        scrollView.contentSize = CGSizeMake([controller.numCols intValue]*100, 1);
        tableViews = [[NSMutableArray alloc] initWithCapacity:[controller.numCols intValue]];
        
        /*Loop through each table and initialize properties
          Set each table's delegate and datasource
          Also add it to tableViews
         */
        for (int i=0;i<[controller.numCols intValue];i++){
            NSLog(@"making column %d",i);
            UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(i*100, 0, 100, frame.size.height)];
            [t setDelegate:controller];
            [t setDataSource:controller];
            t.showsVerticalScrollIndicator = NO;
            //[t addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
            [tableViews addObject:t];
            [scrollView addSubview:t];
        }
    }
    return self;
}

//Called when a table is scrolled
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"keyPath:%@\n Object: %@\n change: %@:", keyPath, object, change);
	if ( [ keyPath isEqual:@"contentOffset"]){
        for(UITableView *t in tableViews){
            [t setContentOffset:((UITableView*)object).contentOffset];
        }
    }
}

-(void)dealloc{
    
    for(UITableView *t in tableViews){
        [t removeObserver:self forKeyPath:@"contentSize"];
    }
}




@end
