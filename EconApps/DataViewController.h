//
//  DataViewController.h
//  EconApps
//
//  Created by Kevin Sanders on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    
    UIView *view;
    UIScrollView *scrollView;
    
    NSMutableArray *cells;
    NSMutableArray *tables;
    
    NSMutableArray *data;
    NSNumber *numCols, *numRows, *cellWidth, *cellHeight;
}

@property (nonatomic) UIView *view;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSMutableArray *cells;
@property (nonatomic) NSMutableArray *tables;
@property (nonatomic) NSMutableArray *data;
@property (nonatomic) NSNumber *numCols;
@property (nonatomic) NSNumber *numRows;
@property (nonatomic) NSNumber *cellWidth;
@property (nonatomic) NSNumber *cellHeight;


- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)data;

@end
