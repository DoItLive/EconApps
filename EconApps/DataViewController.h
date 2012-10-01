//
//  DataViewController.h
//  EconApps
//
//  Created by Kevin Sanders on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Defs.h"

@interface DataViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    
    TABLE_STYLE style;
    BOOL allowHighlighting;
    NSInteger numberBuilt;
    
    UIView *view;
    UIScrollView *scrollView;
    
    NSMutableArray *cells;
    NSMutableArray *tables;
    
    NSMutableArray *data;
    NSNumber *numberOfColumns, *numberOfRows, *cellWidth, *cellHeight, *highlightedColumn, *highlightedRow;
}

@property (nonatomic) TABLE_STYLE style;
@property (nonatomic) BOOL allowHighlighting;
@property (nonatomic) NSInteger numberBuilt;
@property (nonatomic) UIView *view;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSMutableArray *cells;
@property (nonatomic) NSMutableArray *tables;
@property (nonatomic) NSMutableArray *data;
@property (nonatomic) NSNumber *numberOfColumns;
@property (nonatomic) NSNumber *numberOfRows;
@property (nonatomic) NSNumber *cellWidth;
@property (nonatomic) NSNumber *cellHeight;
@property (nonatomic) NSNumber *highlightedColumn;
@property (nonatomic) NSNumber *highlightedRow;


- (id)initWithFrame:(CGRect)frameIn andData:(NSMutableArray*)dataIn andStyle:(TABLE_STYLE)styleIn;
- (int)cellWidthForColumn:(int)columnIn;
- (void)updateSelectedColumn:(NSInteger)rowNum;

@end
