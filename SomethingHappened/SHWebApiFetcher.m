//
//  SHWebApiFetcher.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHWebApiFetcher.h"
#import "SHApiObject.h"
#import <RestKit/RestKit.h>

//#define BASE_API_URl @"http://wildonion-api.herokuapp.com"
#define BASE_API_URl @"http://10.0.1.29:8080"
//#define JSON_EXTENSION @"json"

@implementation SHWebApiFetcher

- (id)init
{
    self = [super init];
    [self initRestKit];
    
    return self;
}

-(NSArray *)getEventTypes
{
    [self getObjectsForClass:[SHEventType class] usingParameters:nil withCompletion:nil];
    
    return nil;
}

-(NSArray *)getEvents
{
    [self getObjectsForClass:[SHEvent class] usingParameters:nil withCompletion:nil];
    
    return nil;
}

- (void)getReportZonesWithHandler:(SHWeApiFetcherCompleteionHandler)handler
{
    [self getObjectsForClass:[SHReportZone class] usingParameters:nil withCompletion:handler];
}

- (void)getReportZonesWithCoordinate:(CLLocationCoordinate2D)coordinate andHandler:(SHWeApiFetcherCompleteionHandler)handler
{
    NSDictionary *parameters = @{
                                 REPORTING_ZONE_LOCATION_LATITUDE_KEY : [NSString stringWithFormat:@"%f", coordinate.latitude],
                                 REPORTING_ZONE_LOCATION_LONGITUDE_KEY : [NSString stringWithFormat:@"%f", coordinate.longitude]
                                 };
    [self getObjectsForClass:[SHReportZone class] usingParameters:parameters withCompletion:handler];
}

- (void)getObjectsForClass:(Class)class usingParameters:(NSDictionary *)parameters withCompletion:(SHWeApiFetcherCompleteionHandler)completion
{
    if ([class isSubclassOfClass:[SHApiObject class]]) {
        NSString *subUrl = [class performSelector:@selector(getSubUrl)];
        
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        [objectManager getObjectsAtPath:subUrl
                             parameters:parameters
                                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                    NSArray* statuses = [mappingResult array];
                                    NSLog(@"Loaded statuses: %@", statuses);
                                    if (completion) {
                                        completion(nil, nil);
                                    }
                                }
                                failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                    message:[error localizedDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil];
                                    [alert show];
                                    NSLog(@"Hit error: %@", error);
                                    if (completion) {
                                        completion(nil, nil);
                                    }
                                }];
    }
}

-(void)createNewEvent:(SHEvent *)event
{
    [[RKObjectManager sharedManager] postObject:event
                                           path:@"/events"
                                     parameters:nil
                                        success: ^(RKObjectRequestOperation *sender, RKMappingResult *result){
                                            int i = 0;
                                        }
                                        failure:^(RKObjectRequestOperation *sender, NSError *error){
                                            int i = 0;
                                        }
     ];
}

- (void)initRestKit
{
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    //let AFNetworking manage the activity indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize HTTPClient
    NSURL *baseURL = [NSURL URLWithString:BASE_API_URl];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    //we want to work with JSON-Data
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    // Initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // Update date format so that we can parse Twitter dates properly
    // Wed Sep 29 15:31:08 +0000 2010
//    [RKObjectMapping addDefaultDateFormatterForString:@"E MMM d HH:mm:ss Z y" inTimeZone:nil];
    
    // Register our mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[SHEvent getResponseMapping]
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:[SHEvent getSubUrl]
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SHEvent getRequestMapping]
                                                                                   objectClass:[SHEvent class]
                                                                                   rootKeyPath:@"event"
                                                                                        method:RKRequestMethodPOST];

    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addRequestDescriptor:requestDescriptor];
    
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[SHEventType getResponseMapping]
                                                                      method:RKRequestMethodGET
                                                                 pathPattern:[SHEventType getSubUrl]
                                                                     keyPath:nil
                                                                 statusCodes:[NSIndexSet indexSetWithIndex:200]];
    requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SHEventType getRequestMapping]
                                                              objectClass:[SHEventType class]
                                                              rootKeyPath:@"event_type"
                                                                   method:RKRequestMethodPOST];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addRequestDescriptor:requestDescriptor];
    
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[SHReportZone getResponseMapping]
                                                                      method:RKRequestMethodGET
                                                                 pathPattern:[SHReportZone getSubUrl]
                                                                     keyPath:nil
                                                                 statusCodes:[NSIndexSet indexSetWithIndex:200]];
    requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SHReportZone getRequestMapping]
                                                              objectClass:[SHReportZone class]
                                                              rootKeyPath:@"report_zone"
                                                                   method:RKRequestMethodPOST];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addRequestDescriptor:requestDescriptor];
    
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
}

@end
