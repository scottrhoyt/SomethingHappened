//
//  SHReportingZone.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/11/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#define REPORT_ZONES_SUB_URL @"/report_zones"

#import "SHReportZone.h"

@implementation SHReportZone

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
    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[SHReportZone class]];
    
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

+ (NSString *)getSubUrl
{
    return REPORT_ZONES_SUB_URL;
}

@end
