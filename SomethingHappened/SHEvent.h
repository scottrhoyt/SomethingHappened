//
//  SHEvent.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHJsonObj.h"

@interface SHEvent : SHJsonObj

@property (nonatomic) NSUInteger event;
@property (nonatomic) NSUInteger user_id;
@property (nonatomic) NSDate *reported_at;
@property (nonatomic) NSInteger reported_location_latitude;
@property (nonatomic) NSInteger reported_location_longitude;
@property (nonatomic) NSInteger event_location_latitude;
@property (nonatomic) NSInteger event_location_longitude;
@property (nonatomic) NSUInteger event_type_id;
@property (nonatomic) NSString *comments;

@end
