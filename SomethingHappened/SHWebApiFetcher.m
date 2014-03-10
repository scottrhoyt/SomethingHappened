//
//  SHWebApiFetcher.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHWebApiFetcher.h"

#define BASE_API_URl @"http://wildonion-api.herokuapp.com"
#define EVENTS_SUB_URL @"events"
#define EVENT_TYPES_SUB_URL @"event_types"
#define JSON_EXTENSION @"json"

@implementation SHWebApiFetcher

-(NSArray *)executeQuery:(NSString *)query
{
    NSURL *queryUrl = [NSURL URLWithString:BASE_API_URl];
    queryUrl = [queryUrl URLByAppendingPathComponent:query];
    queryUrl = [queryUrl URLByAppendingPathExtension:JSON_EXTENSION];
    NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSData *queryData = [NSData dataWithContentsOfURL:queryUrl];
    NSLog(@"%@", queryData);
    NSError *error;
    NSArray *results = queryData ? [NSJSONSerialization JSONObjectWithData:queryData options:0 error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    
    NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    
    return results;
    
}

-(NSArray *)getEventTypes
{
    return [self executeQuery:EVENT_TYPES_SUB_URL];
}

-(NSArray *)getEvents
{
    return [self executeQuery:EVENTS_SUB_URL];
}

-(void)createNewEvent:(NSDictionary *)newEvent
{
    [newEvent ]
}

@end
