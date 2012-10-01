//
//  UserData.h
//  EconApps
//
//  Created by Thomas Langford on 9/28/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject {
    NSString *firstName;
    NSString *lastName;
    NSString *userName;
}

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *userName;

+ (UserData*)userDataInstance;

@end
