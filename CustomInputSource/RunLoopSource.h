//
//  RunLoopSource.h
//  CustomInputSource
//
//  Created by MAC-MiNi on 2017/10/18.
//  Copyright © 2017年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunLoopSource : NSObject
{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray *commands;
}

- (id)init;
- (void)addToCurrentRunLoop;
- (void)invalidate;

// Handler method
- (void)sourceFired;

// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data;
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runLoop;
- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop;
@end

// These are the CFRunLoopSourceRef callback functions.
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);
void RunLoopSourcePerformRoutine (void *info);
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);

@interface RunLoopContext: NSObject

@property (readonly) CFRunLoopRef runLoop;
@property (readonly) RunLoopSource *source;

- (id)initWithSource:(RunLoopSource*)src andLoop:(CFRunLoopRef)loop;

@end
