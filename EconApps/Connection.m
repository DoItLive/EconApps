//
//  Connection.m
//  Buzzer
//
//  Created by Christian and Thomas on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Connection.h"

@implementation Connection

- (id) initWithFinishSelector:(SEL)f withFailSelector:(SEL)fs toTarget:(id)t withURL:(NSString *)urlString withString:(NSString *)postString {
    
    NSLog(@"Connection attempt to %@", urlString);
    NSLog(@"Connection with postString %@", postString);
    NSURL *url = [NSURL URLWithString:urlString];
    request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    if(postString){
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if(self = [super initWithRequest:request delegate:self startImmediately:NO]){
        function = f;
        failFunction = fs;
        target = t;
        receivedData = [[NSMutableData alloc] initWithLength:0];
    }
    else{
        NSLog(@"Connection to server failed at url %@",urlString);
    }
    return self;
}

-(void) connect {
    [self start];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [receivedData setLength:0];
    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receivedData appendData:data];
    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"Connection failed with error: %@ %@",[error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    if ([target respondsToSelector:failFunction]) {
        NSLog(@"Calling [%@ %@]",NSStringFromClass([target class]),NSStringFromSelector(failFunction));
//These ignore the compiler warning for performSelector leaks
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:failFunction];
#pragma clang diagnostic pop
    } else {
        NSLog(@"Error --- Target %@ does not respond to selector %@",NSStringFromClass([target class]),NSStringFromSelector(failFunction));
    }
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Data received: %s", (char *)[receivedData mutableBytes]);
    
    if(function!=nil && [receivedData length]){
        
        if([target respondsToSelector:function]){
            
            NSLog(@"Calling [%@ %@]",NSStringFromClass([target class]),NSStringFromSelector(function));
//These ignore the compiler warning for performSelector leaks
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"            
            [target performSelector:function withObject:receivedData];
#pragma clang diagnostic pop            
        }else{
            NSLog(@"Error --- Target %@ does not respond to selector %@",NSStringFromClass([target class]),NSStringFromSelector(function));
        }
        
    }
    else{
        NSLog(@"No data received");
    }
    
}

@end

