//
//  CustomSourceViewController.h
//  CustomInputSource
//
//  Created by tongleiming on 2020/3/12.
//  Copyright © 2020 MAC-MiNi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunLoopSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomSourceViewController : UIViewController

+ (void)registerSource:(RunLoopContext*)sourceInfo;

+ (void)removeSource:(RunLoopContext*)sourceInfo;

@end

NS_ASSUME_NONNULL_END
