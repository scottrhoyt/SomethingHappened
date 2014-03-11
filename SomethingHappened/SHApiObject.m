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

+ (RKObjectMapping *)getResponseMapping
{
    return nil;
}

+ (RKObjectMapping *)getRequestMapping
{
    return [[self getResponseMapping] inverseMapping];
}

@end
