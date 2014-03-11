//
//  SHReportingZone.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/11/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHReportingZone.h"

#define REPORTING_ZONE_PKEY @"id"
#define REPORTING_ZONE_NAME_KEY @"name"
#define REPORTING_ZONE_DESCRIPTION_KEY @"description"
#define REPORTING_ZONE_LOCATION_LATITUDE_KEY @"location_latitude"
#define REPORTING_ZONE_LOCATION_LONGITUDE_KEY @"location_longitude"
#define REPORTING_ZONE_RADIUS_KEY @"radius"

@implementation SHReportingZone

//@synthesize coordinate;

#pragma mark - Getters/Setters

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.locationLatitude, self.locationLongitude);
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    self.locationLongitude = coordinate.longitude;
    self.locationLatitude = coordinate.latitude;
}

#pragma mark - SHApiObject method overrides

+ (RKObjectMapping *)getResponseMapping
{
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[SHReportingZone class]];
    
    [objectMapping addAttributeMappingsFromDictionary:@{
                                                        REPORTING_ZONE_PKEY: @"reportingZoneId",
                                                        REPORTING_ZONE_NAME_KEY : @"name",
                                                        REPORTING_ZONE_DESCRIPTION_KEY : @"description",
                                                        REPORTING_ZONE_LOCATION_LATITUDE_KEY : @"locationLatitude",
                                                        REPORTING_ZONE_LOCATION_LONGITUDE_KEY : @"locationLongitude",
                                                        REPORTING_ZONE_RADIUS_KEY : @"radius"
                                                        }];
    
    return objectMapping;
}

//+ (RKObjectMapping *)getRequestMapping
//{
//    return [[SHReportingZone getResponseMapping] inverseMapping];
//}

@end
