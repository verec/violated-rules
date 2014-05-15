//
//  NSString+PubSub.h
//  violated-rules
//
//  Created by verec on 10/06/2013.
//  Copyright (c) 2014 CantabiLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSStringSubscription ;

@interface NSString (PubSub)

- (void) publish: (id) value ;
- (void) publish: (id) value userInfo: (NSDictionary *) info ;
- (id) subscribe: (void (^)(NSNotification *)) notification ;
- (NSStringSubscription *) addSubscription: (void (^)(NSNotification *)) notification ;
- (void) unsubscribe: (id) token ;

@end

@interface NSStringSubscriptionList : NSObject

@property (nonatomic, strong) NSMutableArray *  subscriptions ;

- (instancetype) addSubscription: (NSStringSubscription *) subscription ;
- (instancetype) addSubscriptionsFromArray: (NSArray *) subscriptions ;
- (instancetype) unsubscribeAll ;

@end
