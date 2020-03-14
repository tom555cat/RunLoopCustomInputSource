//
//  ThreadKeepAliveViewController.m
//  CustomInputSource
//
//  Created by tongleiming on 2020/3/12.
//  Copyright © 2020 MAC-MiNi. All rights reserved.
//

#import "ThreadKeepAliveViewController.h"
#import "XCThread.h"

@interface ThreadKeepAliveViewController ()

@property (nonatomic, strong) XCThread *thread;

@end

@implementation ThreadKeepAliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"线程保活";
    
    //[self threadRunOnlyOnce];
    [self threadRunEndless];
}

- (IBAction)fireSource0BtnClick:(id)sender {
    [self performSelector:@selector(fireSource0) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)fireSource0 {
    NSLog(@"fire source 0!");
}


#pragma mark - 只运行一次的runLoop的thread
- (void)threadRunOnlyOnce {
    self.thread = [[XCThread alloc] initWithTarget:self selector:@selector(runOnlyOnce) object:nil];
    [self.thread start];
}

- (void)runOnlyOnce {
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    
    // Runs the loop once, blocking for input in the specified mode until a given date.
    // RunLoop只会运行一次，接收完一次输入之后就返回然后退出了
    BOOL result = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    NSLog(@"runloop end runMode:beforeDate: %d", result);
}

#pragma mark - 无限循环runLoop的thread
- (void)threadRunEndless {
    self.thread = [[XCThread alloc] initWithTarget:self selector:@selector(runEndless) object:nil];
    [self.thread start];
}

- (void)runEndless {
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    // 等同于[[NSRunLoop currentRunLoop] run];开启了一个永不停止的线程
    while (1) {
        BOOL result = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"runloop end runMode:beforeDate: %d", result);
    }
    NSLog(@"runloop end after while");
}

@end
