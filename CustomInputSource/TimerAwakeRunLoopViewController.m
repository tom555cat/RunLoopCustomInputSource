//
//  TimerAwakeRunLoopViewController.m
//  CustomInputSource
//
//  Created by tongleiming on 2020/3/20.
//  Copyright © 2020 MAC-MiNi. All rights reserved.
//

#import "TimerAwakeRunLoopViewController.h"
#import "XCThread.h"

@interface TimerAwakeRunLoopViewController ()

@property (nonatomic, strong) XCThread *thread;

@end

@implementation TimerAwakeRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self threadRunEndless];
}


#pragma mark - 无限循环runLoop的thread
- (void)threadRunEndless {
    self.thread = [[XCThread alloc] initWithTarget:self selector:@selector(runEndless) object:nil];
    [self.thread start];
}

- (void)runEndless {
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%@, timer fired!", [NSThread currentThread]);
    }];
    
    // 等同于[[NSRunLoop currentRunLoop] run];开启了一个永不停止的线程
    while (1) {
        BOOL result = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"runloop end runMode:beforeDate: %d", result);
    }
    NSLog(@"runloop end after while");
}

@end
