//
//  RunLoopSource.m
//  CustomInputSource
//
//  Created by MAC-MiNi on 2017/10/18.
//  Copyright © 2017年 MAC-MiNi. All rights reserved.
//

#import "AppDelegate.h"
#import "RunLoopSource.h"
#import "ViewController.h"

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource* obj = CFBridgingRelease(info);
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    
    [ViewController performSelectorOnMainThread:@selector(registerSource:) withObject:theContext waitUntilDone:NO];
}

void RunLoopSourcePerformRoutine (void *info)
{
    RunLoopSource*  obj = CFBridgingRelease(info);
    [obj sourceFired];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource* obj = CFBridgingRelease(info);
    RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    
    [ViewController performSelectorOnMainThread:@selector(removeSource:) withObject:theContext waitUntilDone:YES];
}

@implementation RunLoopSource

- (id)init
{
    CFRunLoopSourceContext    context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
        &RunLoopSourceScheduleRoutine,
        RunLoopSourceCancelRoutine,
        RunLoopSourcePerformRoutine};
    
    runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
    commands = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)addToCurrentRunLoop
{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop
{
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runloop);
}

- (void)sourceFired {
    NSLog(@"on %@", [NSThread currentThread]);
}

@end

@interface RunLoopContext ()

@property CFRunLoopRef runLoop;
@property RunLoopSource *source;

@end

@implementation RunLoopContext

- (id)initWithSource:(RunLoopSource *)src andLoop:(CFRunLoopRef)loop {
    self = [super init];
    if (self) {
        _runLoop = loop;
        _source = src;
    }
    return self;
}


@end


