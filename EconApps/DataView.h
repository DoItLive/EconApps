//
//  DataView.h
//  EconApps
//
//  Created by Christian Weigandt on 9/12/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridView.h"

@interface DataView : UIView{
    
    GridView* header;
    GridView* body;
    
}

@property(nonatomic)GridView* header;
@property(nonatomic)GridView* body;

- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)data;

@end
