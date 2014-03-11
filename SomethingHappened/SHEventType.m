//
//  SHEventType.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/11/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHEventType.h"

#define EVENT_TYPE_PKEY @"id"
#define EVENT_TYPE_NAME_KEY @"name"
#define EVENT_TYPE_DESCRIPTION_KEY @"description"

@implementation SHEventType

+ (RKObjectMapping *)getResponseMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[SHEventType class]];
    
    [objectMapping addAttributeMappingsFromDictionary:@{
                                                        EVENT_TYPE_PKEY: @"eventTypeId",
                                                        EVENT_TYPE_NAME_KEY : @"name",
                                                        EVENT_TYPE_DESCRIPTION_KEY : @"description",
                                                        }];
    
    return objectMapping;
}

//+ (RKObjectMapping *)getRequestMapping
//{
//    return [[SHEventType getResponseMapping] inverseMapping];
//}

@end
