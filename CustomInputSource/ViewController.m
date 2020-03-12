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
}

@end
