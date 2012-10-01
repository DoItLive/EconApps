//
//  Socket.h
//  EconApps
//
//  Created by Thomas Langford on 9/27/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMAX_BUFFER_SIZE 1024 //Max receiving buffer size

@interface Socket : NSObject <NSStreamDelegate> {
    //Using nsstreams instead of cfstreams as they are a little more friendly to use
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSString *host;
    
    id target;
    SEL readFunction;
}

- (id)initSocketToHost:(NSString*)hostAddress atPort:(NSInteger)portNum withTarget:(id)tar withReadFunc:(SEL)func;
- (void)writeString:(NSString*)string;

//Delegate Functions:
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode;

@end
