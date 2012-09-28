//
//  Socket.m
//  EconApps
//
//  Created by Thomas Langford on 9/27/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "Socket.h"

@implementation Socket

- (id)initSocketToHost:(NSString *)hostAddress atPort:(NSInteger)portNum withTarget:(id)tar withReadFunc:(SEL)func{
    host = hostAddress;
    readFunction = func;
    target = tar;
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStringRef cfHostAddress = (__bridge CFStringRef)hostAddress; //__bridge adds compatibility for arrc compiler
    //This function pairs the cfstreams with the nsstreams
    CFStreamCreatePairWithSocketToHost(NULL, cfHostAddress, portNum, &readStream, &writeStream);
    
    inputStream = (__bridge NSInputStream*)readStream; //__bridge adds compatibility for arrc compiler
    outputStream = (__bridge NSOutputStream*)writeStream; //__bridge adds compatibility for arrc compiler
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    return self;
}

- (void)writeString:(NSString *)string {
    NSData *data = [[NSData alloc] initWithData:[string dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
}

//Delegate Functions:
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"Opened connection with %@",host);
            break;
            
        case NSStreamEventHasBytesAvailable:
            if (aStream == inputStream) {
                uint8_t buffer[kMAX_BUFFER_SIZE];
                int len;
                
                //If there are bytes sitting to be read then read them, convert them to data, and send it to the target function
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        if ([target respondsToSelector:readFunction]) {
                            NSData *data = [[NSData alloc] initWithBytes:buffer length:len];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                            [target performSelector:readFunction withObject:data];
#pragma clang diagnostic pop
                        } else {
                            NSLog(@"Error --- Target %@ does not respond to selector %@",NSStringFromClass([target class]),NSStringFromSelector(readFunction));
                        }
                    }
                }
            }
            break;
            
        case NSStreamEventEndEncountered:
            //Close the streams and remove them from run loop
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"Error -- Received error from socket connection with %@",host);
            break;
        default:
            NSLog(@"Error -- Unknown NSStreamEvent code");
            break;
    }
}

@end
