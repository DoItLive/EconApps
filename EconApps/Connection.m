//
//  Connection.m
//  Buzzer
//
//  Created by Christian and Thomas on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Connection.h"

@implementation Connection

- (id) initWithSelector:(SEL)f toTarget:(id)t withURL:(NSString*)urlString withString:(NSString*)postString{
    
    NSLog(@"Connection attempt to %@", urlString);
    NSLog(@"Connection with postString %@", postString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    if(postString){
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if(self = [super initWithRequest:request delegate:self]){
        function = f;
        target = t;
        receivedData = [[NSMutableData alloc] initWithLength:0];
        
    }
    else{
        
        NSLog(@"Connection to server failed at url %@",urlString);
        
    }
    
    return self;
    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [receivedData setLength:0];
    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receivedData appendData:data];
    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"Connection failed with error %@ %@",[error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Data received: %s", (char *)[receivedData mutableBytes]);
    
    if(function!=nil && [receivedData length]){
        
        if([target respondsToSelector:function]){
            
            NSLog(@"Calling [%@ %@]",NSStringFromClass([target class]),NSStringFromSelector(function));
            
            [target performSelector:function withObject:receivedData];
            
        }else{
            NSLog(@"Error --- Target %@ does not respond to selector %@",NSStringFromClass([target class]),NSStringFromSelector(function));
        }
        
    }
    else{
        NSLog(@"No data received");
    }
    
}

@end

