//
//  TokenView.m
//  EconApps
//
//  Created by Christian Weigandt on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "TokenView.h"

@implementation TokenView

- (id)init{
    
    UIImage* tokenImage = [UIImage imageNamed:@"token-1.png"];
    self = [super initWithImage:tokenImage];
    
    return self;
    
}

@end
