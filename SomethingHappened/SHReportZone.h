//
//  SHReportingZone.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/11/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHApiObject.h"
#import <CoreLocation/CoreLocation.h>

#define REPORTING_ZONE_PKEY @"id"
#define REPORTING_ZONE_NAME_KEY @"name"
#define REPORTING_ZONE_DESCRIPTION_KEY @"description"
#define REPORTING_ZONE_LOCATION_LATITUDE_KEY @"location_latitude"
#define REPORTING_ZONE_LOCATION_LONGITUDE_KEY @"location_longitude"
#define REPORTING_ZONE_RADIUS_KEY @"radius"

@interface SHReportZone : SHApiObject

@property (nonatomic) NSUInteger reportingZoneId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) CLLocationDegrees locationLatitude;
@property (nonatomic) CLLocationDegrees locationLongitude;
@property (nonatomic) CLLocationDistance radius;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
