//
//  SHEvent.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHEvent.h"

#define EVENTS_SUB_URL @"/events"

#define EVENT_PKEY @"id"
#define EVENT_USER_ID_KEY @"user_id"
#define EVENT_REPORTED_DATE_KEY @"reported_at"
#define EVENT_REPORTED_LAT_KEY @"reported_location_latitude"
#define EVENT_REPORTED_LONG_KEY @"reported_location_longitude"
#define EVENT_LAT_KEY @"event_location_latitude"
#define EVENT_LONG_KEY @"event_location_longitude"
#define EVENT_EVENT_TYPE_ID_KEY @"event_type_id"
#define EVENT_COMMENTS_KEY @"comments"
#define EVENT_REPORT_ZONE_ID @"report_zone_id"

@implementation SHEvent

+ (RKObjectMapping *)getResponseMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[SHEvent class]];
    
    [objectMapping addAttributeMappingsFromDictionary:@{
                                                        EVENT_PKEY: @"eventId",
                                                        EVENT_USER_ID_KEY : @"userId",
                                                        EVENT_REPORTED_DATE_KEY : @"reportedAt",
                                                        EVENT_REPORTED_LAT_KEY : @"reportedLocationLatitude",
                                                        EVENT_REPORTED_LONG_KEY : @"reportedLocationLongitude",
                                                        EVENT_LAT_KEY : @"eventLocationLatitude",
                                                        EVENT_LONG_KEY : @"eventLocationLongitude",
                                                        EVENT_EVENT_TYPE_ID_KEY : @"eventTypeId",
                                                        EVENT_COMMENTS_KEY : @"comments",
                                                        EVENT_REPORT_ZONE_ID : @"reportZoneId"
                                                        }];
    
    return objectMapping;
}

//+ (RKObjectMapping *)getRequestMapping
//{
//    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
//
//    return [[SHEvent getResponseMapping] inverseMapping];
//}

+ (NSString *)getSubUrl
{
    return EVENTS_SUB_URL;
}

@end
