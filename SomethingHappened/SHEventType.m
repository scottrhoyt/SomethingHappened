//
//  SHEventType.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/11/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHEventType.h"

#define EVENT_TYPES_SUB_URL @"/event_types"

#define EVENT_TYPE_ROOT_KEY @"event_type"

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

+ (NSString *)getSubUrl
{
    return EVENT_TYPES_SUB_URL;
}

+ (NSString *)getRootKey
{
    return EVENT_TYPE_ROOT_KEY;
}

@end
