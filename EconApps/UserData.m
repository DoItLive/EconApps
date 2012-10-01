//
//  UserData.m
//  EconApps
//
//  Created by Thomas Langford on 9/28/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "UserData.h"

@implementation UserData

@synthesize firstName,lastName,userName;

+ (UserData*)userDataInstance {
    static UserData *single = nil;
    
    @synchronized(self) {
        if (!single) {
            single = [[UserData alloc] init];
        }
    }
    return single;
}

@end
