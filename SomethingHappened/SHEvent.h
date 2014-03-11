//
//  SHEvent.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHJsonObj.h"
#import <RestKit/RestKit.h>

@interface SHEvent : SHJsonObj

@property (nonatomic) NSUInteger eventId;
@property (nonatomic) NSUInteger userId;
@property (nonatomic) NSDate *reportedAt;
@property (nonatomic) double reportedLocationLatitude;
@property (nonatomic) double reportedLocationLongitude;
@property (nonatomic) double eventLocationLatitude;
@property (nonatomic) double eventLocationLongitude;
@property (nonatomic) NSUInteger eventTypeId;
@property (nonatomic) NSString *comments;

+ (RKObjectMapping *)getObjectMapping;
+ (RKObjectMapping *)getRequestMapping;

@end
