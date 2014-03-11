//
//  SHReportingZone.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/11/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHApiObject.h"
#import <CoreLocation/CoreLocation.h>

@interface SHReportingZone : SHApiObject

@property (nonatomic) NSUInteger reportingZoneId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) CLLocationDegrees locationLatitude;
@property (nonatomic) CLLocationDegrees locationLongitude;
@property (nonatomic) CLLocationDistance radius;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
