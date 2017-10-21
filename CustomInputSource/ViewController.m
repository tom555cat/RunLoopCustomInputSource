//
//  ViewController.m
//  CustomInputSource
//
//  Created by MAC-MiNi on 2017/10/18.
//  Copyright © 2017年 MAC-MiNi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

static RunLoopContext *context;

@interface ViewController ()

@property (nonatomic, strong) RunLoopSource *source;

@property (nonatomic, strong) NSMutableArray *sourcesToPing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self launch];
}

- (void)launch {
    [NSThread detachNewThreadWithBlock:^{
        @autoreleasepool {

            NSThread.currentThread.name = @"com.myapp.inputsource";
            RunLoopSource *source = [[RunLoopSource alloc] init];
            [source addToCurrentRunLoop];
            
            do {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            } while (YES);
        }
    }];
    
}

- (IBAction)fireSignal:(id)sender {
    [context.source fireCommandsOnRunLoop:context.runLoop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)registerSource:(RunLoopContext*)sourceInfo
{
    context = sourceInfo;
    //[self.sourcesToPing addObject:sourceInfo];
}

+ (void)removeSource:(RunLoopContext*)sourceInfo
{
//    id    objToRemove = nil;
//
//    for (RunLoopContext* context in self.sourcesToPing)
//    {
//        if ([context isEqual:sourceInfo])
//        {
//            objToRemove = context;
//            break;
//        }
//    }
//
//    if (objToRemove)
//        [self.sourcesToPing removeObject:objToRemove];
}

- (NSMutableArray *)sourcesToPing {
    if (_sourcesToPing == nil) {
        _sourcesToPing = [[NSMutableArray alloc] init];
    }
    return _sourcesToPing;
}


@end
