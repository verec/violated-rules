//
//  AppDelegate.m
//  Host
//
//  Created by verec on 15/05/2014.
//  Copyright (c) 2014 CantabiLabs. All rights reserved.
//

#import "DynamicViewController.h"

#import "AppDelegate.h"

@interface DynamicView : UIView

@property (nonatomic, strong) UILabel * label ;

@end

@implementation DynamicView

- (NSString *) stringWithCurrentInterfaceOrientation {

#define CONCAT(s)   #s
#define STR(x)      @CONCAT(x)
#define CASE(x)     case x: text = STR(x) ; break ;

    NSString * text = @"?Huh?" ;

    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation ;

    switch(orientation) {
        CASE(UIInterfaceOrientationPortrait) ;
        CASE(UIInterfaceOrientationPortraitUpsideDown) ;
        CASE(UIInterfaceOrientationLandscapeLeft) ;
        CASE(UIInterfaceOrientationLandscapeRight) ;
    }


#undef CASE
#undef STR
#undef CONCAT
    return text ;
}

- (void) layoutSubviews {

    // Lazily create the label: we're completely resetting its geometry here
    // anyway so we trade an insignificant performance cost for the code space
    // of the DynamicView's initWithFrame that we would need to write otherwise.

    if (self.label == nil) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero] ;
        self.label.textColor = [UIColor grayColor] ;
        [self addSubview:self.label] ;
    }

    self.label.text = [self stringWithCurrentInterfaceOrientation] ;

    [self.label sizeToFit] ;

    CGRect bounds = self.bounds ;
    CGRect labelFrame = self.label.frame ;

    labelFrame.origin.x = (bounds.size.width - labelFrame.size.width) / 2.0f ;
    labelFrame.origin.y = (bounds.size.height - labelFrame.size.height) / 2.0f ;

    self.label.frame = labelFrame ;
}

@end

@implementation AppDelegate

- (instancetype) init {
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserverForName: nil
                                                          object: nil
                                                           queue: nil
                                                      usingBlock:^(NSNotification *note) {
            NSLog(@"%@", note) ;
        }] ;
    }

    return self ;
}

+ (AppDelegate *) appDelegate {
    return (AppDelegate *) [UIApplication sharedApplication].delegate ;
}

- (BOOL) application: (UIApplication *) application
didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;

    self.window.rootViewController = [DynamicViewController viewControllerForDynamicView:
        ^UIView *() {
            return [[DynamicView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    }] ;

    self.window.backgroundColor = [UIColor whiteColor] ;
    [self.window makeKeyAndVisible] ;
    return YES ;
}

// Sent when the application is about to move from active to inactive state.
// This can occur for certain types of temporary interruptions (such as an
// incoming phone call or SMS message) or when the user quits the application
// and it begins the transition to the background state.
// Use this method to pause ongoing tasks, disable timers, and throttle down
// OpenGL ES frame rates. Games should use this method to pause the game.

- (void) applicationWillResignActive: (UIApplication *) application {
    NSLog(@"applicationWillResignActive: %@", application) ;
}

// Use this method to release shared resources, save user data, invalidate
// timers, and store enough application state information to restore your
// application to its current state in case it is terminated later.
// If your application supports background execution, this method is called
// instead of applicationWillTerminate: when the user quits.

- (void) applicationDidEnterBackground: (UIApplication *) application {
    NSLog(@"applicationDidEnterBackground: %@", application) ;
}

// Called as part of the transition from the background to the inactive state;
// here you can undo many of the changes made on entering the background.

- (void) applicationWillEnterForeground: (UIApplication *) application {
    NSLog(@"applicationWillEnterForeground: %@", application) ;
}

// Restart any tasks that were paused (or not yet started) while the application
// was inactive. If the application was previously in the background, optionally
// refresh the user interface.

- (void) applicationDidBecomeActive: (UIApplication *) application {
    NSLog(@"applicationDidBecomeActive: %@", application) ;
}

// Called when the application is about to terminate. Save data if appropriate.
// See also applicationDidEnterBackground.

- (void) applicationWillTerminate: (UIApplication *) application {
    NSLog(@"applicationWillTerminate: %@", application) ;
}

@end
