//
//  GridViewController.h
//  EconApps
//
//  Created by Christian Weigandt on 9/6/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *data;
    NSNumber *numRows,*numCols;
    
}

@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) NSNumber *numRows;
@property(nonatomic, strong) NSNumber *numCols;


@end
