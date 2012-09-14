//
//  PublicGoodsView.h
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewController.h"

@interface PublicGoodsView : UIView{
    
    DataViewController *theGrid;
    
}

@property (nonatomic) DataViewController *theGrid;

@end
