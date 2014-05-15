//
//  DynamicViewController.m
//  Host
//
//  Created by verec on 15/05/2014.
//  Copyright (c) 2014 CantabiLabs. All rights reserved.
//

#import "DynamicViewController.h"

@interface DynamicViewController ()

@property (nonatomic, copy) DynamicViewControllerCreatorBlock   viewCreatorBlock ;

@end

@implementation DynamicViewController

+ (instancetype) viewControllerForDynamicView: (DynamicViewControllerCreatorBlock) viewCreatorBlock {

    DynamicViewController * controller = [[self alloc] initWithNibName:nil bundle:nil] ;

    controller.viewCreatorBlock = viewCreatorBlock ;

    return controller ;
}

- (void) loadView {
    if (self.viewCreatorBlock) {
        self.view = self.viewCreatorBlock() ;
        self.viewCreatorBlock = nil ;
    }
}

- (BOOL) shouldAutorotate {
    return YES ;
}

@end
