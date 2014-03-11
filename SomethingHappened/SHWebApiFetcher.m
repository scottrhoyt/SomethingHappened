//
//  SHWebApiFetcher.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHWebApiFetcher.h"
#import <RestKit/RestKit.h>

#define BASE_API_URl @"http://wildonion-api.herokuapp.com"
#define EVENTS_SUB_URL @"/events"
#define EVENT_TYPES_SUB_URL @"/event_types"
//#define JSON_EXTENSION @"json"

@implementation SHWebApiFetcher

- (id)init
{
    self = [super init];
    [self initRestKit];
    
    return self;
}

//-(NSArray *)executeQuery:(NSString *)query
//{
//    NSURL *queryUrl = [NSURL URLWithString:BASE_API_URl];
//    queryUrl = [queryUrl URLByAppendingPathComponent:query];
//    queryUrl = [queryUrl URLByAppendingPathExtension:JSON_EXTENSION];
//    NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
//    NSData *queryData = [NSData dataWithContentsOfURL:queryUrl];
//    NSLog(@"%@", queryData);
//    NSError *error;
//    NSArray *results = queryData ? [NSJSONSerialization JSONObjectWithData:queryData options:0 error:&error] : nil;
//    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
//    
//    NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
//    
//    return results;
//    
//}

-(NSArray *)getEventTypes
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager getObjectsAtPath:EVENT_TYPES_SUB_URL
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSArray* statuses = [mappingResult array];
                                NSLog(@"Loaded statuses: %@", statuses);
                                //_statuses = statuses;
                                //if(self.isViewLoaded)
                                //    [_tableView reloadData];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                message:[error localizedDescription]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil];
                                [alert show];
                                NSLog(@"Hit error: %@", error);
                            }];
    
    return nil;
    //return [self executeQuery:EVENT_TYPES_SUB_URL];
}

-(NSArray *)getEvents
{
    //return [self executeQuery:EVENTS_SUB_URL];
    // Load the object model via RestKit
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager getObjectsAtPath:EVENTS_SUB_URL
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSArray* statuses = [mappingResult array];
                                NSLog(@"Loaded statuses: %@", statuses);
                                //_statuses = statuses;
                                //if(self.isViewLoaded)
                                //    [_tableView reloadData];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                message:[error localizedDescription]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil];
                                [alert show];
                                NSLog(@"Hit error: %@", error);
                            }];
    
    return nil;
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
                                                                                       pathPattern:EVENTS_SUB_URL
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
                                                                 pathPattern:EVENT_TYPES_SUB_URL
                                                                     keyPath:nil
                                                                 statusCodes:[NSIndexSet indexSetWithIndex:200]];
    requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[SHEventType getRequestMapping]
                                                              objectClass:[SHEventType class]
                                                              rootKeyPath:@"event_type"
                                                                   method:RKRequestMethodPOST];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addRequestDescriptor:requestDescriptor];
    
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
}

@end
