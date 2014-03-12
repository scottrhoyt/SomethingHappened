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

//#define EVENT_TYPE_NAME_KEY @"name"
//#define EVENT_TYPE_DESCRIPTION_KEY @"description"
//
//#define EVENT_PKEY @"event"
//#define EVENT_USER_ID_KEY @"user_id"
//#define EVENT_REPORTED_DATE_KEY @"reported_at"
//#define EVENT_REPORTED_LAT_KEY @"reported_location_latitude"
//#define EVENT_REPORTED_LONG_KEY @"reported_location_longitude"
//#define EVENT_LAT_KEY @"event_location_latitude"
//#define EVENT_LONG_KEY @"event_location_longitude"
//#define EVENT_EVENT_TYPE_ID_KEY @"event_type_id"
//#define EVENT_COMMENTS_KEY @"comments"

typedef void (^SHWeApiFetcherCompleteionHandler)(id result, NSError *error);

@interface SHWebApiFetcher : NSObject

- (NSArray *)getEventTypes;
- (NSArray *)getEvents;
- (void)getReportZonesWithHandler:(SHWeApiFetcherCompleteionHandler)handler;
- (void)getReportZonesWithCoordinate:(CLLocationCoordinate2D)coordinate andHandler:(SHWeApiFetcherCompleteionHandler)handler;
- (void)createNewEvent:(SHEvent *)event;

@end
