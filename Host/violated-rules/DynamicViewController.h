//
//  DynamicViewController.h
//  Host
//
//  Created by verec on 15/05/2014.
//  Copyright (c) 2014 CantabiLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView * (^DynamicViewControllerCreatorBlock)() ;

@interface DynamicViewController : UIViewController

+ (instancetype) viewControllerForDynamicView: (DynamicViewControllerCreatorBlock) viewCreatorBlock ;

@end
