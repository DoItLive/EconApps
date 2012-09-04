//
//  Connection.h
//  Buzzer
//
//  Created by Christian and Thomas on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  This class opens a connection to a url and handles failed and succeeded states

#import <Foundation/Foundation.h>

#ifndef CONNECTION
#define CONNECTION

@interface Connection : NSURLConnection{
    
    
    NSMutableData *receivedData;
    
    SEL function;
    
    id target;
    
}

- (id) initWithSelector:(SEL)f toTarget:(id)t withURL:(NSString*)urlString withString:(NSString*)postString;

@end

#endif