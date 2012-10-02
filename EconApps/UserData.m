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
    static UserData *singleton = nil;
    
    //Synchronize before accessing to protect against race issue
    @synchronized(self) {
        if (!singleton) {
            singleton = [[UserData alloc] init]; //Alloc if not created yet
        }
    }
    return singleton; //Pass singleton pointer back to caller
}

@end
