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
    
    NSMutableURLRequest *request;
    NSMutableData *receivedData;
    SEL function;
    SEL failFunction;
    id target;
    
}

- (id) initWithFinishSelector:(SEL)f withFailSeclector:(SEL)fs toTarget:(id)t withURL:(NSString*)urlString withString:(NSString*)postString;
-(void) connect;

@end

#endif