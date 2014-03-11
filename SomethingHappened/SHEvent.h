//
//  SHEvent.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHApiObject.h"
#import <CoreLocation/CoreLocation.h>
//#import <RestKit/RestKit.h>

@interface SHEvent : SHApiObject

@property (nonatomic) NSUInteger eventId;
@property (nonatomic) NSUInteger userId;
@property (nonatomic) NSDate *reportedAt;
@property (nonatomic) CLLocationDegrees reportedLocationLatitude;
@property (nonatomic) CLLocationDegrees reportedLocationLongitude;
@property (nonatomic) CLLocationDegrees eventLocationLatitude;
@property (nonatomic) CLLocationDegrees eventLocationLongitude;
@property (nonatomic) NSUInteger eventTypeId;
@property (nonatomic) NSString *comments;

@end
