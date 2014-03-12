//
//  SHJsonObj.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

/*
 This is an abstract superclass for RestKit loaded objects.  Must implement certain public api.
*/
@interface SHApiObject : NSObject

+ (RKObjectMapping *)getRequestMapping;
+ (NSArray *)getResponseDiscriptors;
+ (NSArray *)getRequestDiscriptors;

// Must implement the following

+ (RKObjectMapping *)getResponseMapping;
+ (NSString *)getSubUrl;
+ (NSString *)getRootKey;

@end
