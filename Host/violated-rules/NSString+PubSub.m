//
//  NSString+PubSub.m
//  violated-rules
//
//  Created by verec on 10/06/2013.
//  Copyright (c) 2014 CantabiLabs. All rights reserved.
//

#import "NSString+PubSub.h"

@interface NSStringSubscription : NSObject

+ (id) subscriptionWithTopic: (NSString *) topic listener: (id) listener ;

@property (nonatomic, strong) NSString *    topic ;
@property (nonatomic, strong) id            listener ;

@end

@implementation NSString (PubSub)

- (void) publish: (id) value {
    [[NSNotificationCenter defaultCenter] postNotificationName: self object:value] ;
}

- (void) publish: (id) value userInfo: (NSDictionary *) info {
    [[NSNotificationCenter defaultCenter] postNotificationName: self object:value userInfo:info] ;
}

- (id) subscribe: (void (^)(NSNotification *)) notification {
    return [[NSNotificationCenter defaultCenter] addObserverForName: self
                                                             object: nil
                                                              queue: nil
                                                         usingBlock: notification] ;
}

- (NSStringSubscription *) addSubscription: (void (^)(NSNotification *)) notification {
    return [NSStringSubscription subscriptionWithTopic:self
                                              listener:[self subscribe:notification]] ;
}

- (void) unsubscribe: (id) token {
    [[NSNotificationCenter defaultCenter] removeObserver:token] ;
}

@end

@implementation NSStringSubscription

+ (id) subscriptionWithTopic: (NSString *) topic listener: (id) listener {
    NSStringSubscription * s = [NSStringSubscription new] ;
    s.topic = topic ;
    s.listener = listener ;
    return s ;
}

@end

@implementation NSStringSubscriptionList

#ifdef TRACE_DEALLOC
- (void) dealloc {
    ::NSLog(@"subscriptions going away for topics: %@", self.subscriptions) ;
    [self unsubscribeAll] ;
}
#endif

- (id) init {
    if ((self = [super init])) {
        self.subscriptions = [@[] mutableCopy] ;
    }
    return self ;
}

- (instancetype) addSubscription: (NSStringSubscription *) subscription {
    [self.subscriptions addObject:subscription] ;
    return self ;
}

- (instancetype) addSubscriptionsFromArray: (NSArray *) subscriptions {
    [self.subscriptions addObjectsFromArray: subscriptions] ;
    return self ;
}

- (instancetype) unsubscribeAll {
    for (NSStringSubscription * subscription in self.subscriptions) {
        [subscription.topic unsubscribe:subscription.listener] ;
    }

    [self.subscriptions removeAllObjects] ;

    return self ;
}

@end

