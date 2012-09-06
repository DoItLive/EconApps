//
//  GridView.h
//  EconApps
//
//  Created by Christian Weigandt on 9/6/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView{
    
    UIScrollView *scrollView;
    
    NSMutableArray *tableViews;
    
}

- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)data;

@end
