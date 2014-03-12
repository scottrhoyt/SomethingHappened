//
//  SHJsonObj.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHApiObject.h"

@interface SHApiObject ()

@end

@implementation SHApiObject

+ (RKObjectMapping *)getRequestMapping
{
    return [[self getResponseMapping] inverseMapping];
}

+ (NSArray *)getResponseDiscriptors
{
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self getResponseMapping]
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:[self getSubUrl]
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    return [NSArray arrayWithObject:responseDescriptor];
}

+ (NSArray *)getRequestDiscriptors
{
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[self getRequestMapping]
                                                                                   objectClass:[self class]
                                                                                   rootKeyPath:[self getRootKey]
                                                                                        method:RKRequestMethodPOST];
    
    return [NSArray arrayWithObject:requestDescriptor];
}

#pragma mark - Must Override in subclass

+ (RKObjectMapping *)getResponseMapping
{
    assert([NSException exceptionWithName:@"Missing Override Exception" reason:@"A subclass of SHApiObject did not override all required methods" userInfo:nil]);
    return nil;
}

+ (NSString *)getSubUrl
{
    assert([NSException exceptionWithName:@"Missing Override Exception" reason:@"A subclass of SHApiObject did not override all required methods" userInfo:nil]);
    return nil;
}

+ (NSString *)getRootKey
{
    assert([NSException exceptionWithName:@"Missing Override Exception" reason:@"A subclass of SHApiObject did not override all required methods" userInfo:nil]);
    return nil;
}

@end
