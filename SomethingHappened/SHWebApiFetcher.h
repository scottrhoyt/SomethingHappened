//
//  SHWebApiFetcher.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHEvent.h"
#import "SHEventType.h"
#import "SHReportZone.h"

typedef void (^SHWeApiFetcherCompletionHandler)(id result, NSError *error);

@interface SHWebApiFetcher : NSObject

- (void)getObjectsForClass:(Class)class usingParameters:(NSDictionary *)parameters withCompletion:(SHWeApiFetcherCompletionHandler)completion;
- (void)createNewObject:(SHApiObject *)object withCompletion:(SHWeApiFetcherCompletionHandler)completion;

@end
