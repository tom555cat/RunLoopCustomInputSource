//
//  CustomSourceViewController.m
//  CustomInputSource
//
//  Created by tongleiming on 2020/3/12.
//  Copyright © 2020 MAC-MiNi. All rights reserved.
//

#import "CustomSourceViewController.h"

static RunLoopContext *context;

@interface CustomSourceViewController ()

@property (nonatomic, strong) RunLoopSource *source;

@property (nonatomic, strong) NSMutableArray *sourcesToPing;

@property (nonatomic, strong) UIButton *button;

@end

@implementation CustomSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self launch];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 100, 100);
    [self.button setTitle:@"fire Signal" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(fireSignal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
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

- (void)fireSignal:(UIButton *)button {
    [context.source fireCommandsOnRunLoop:context.runLoop];
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
