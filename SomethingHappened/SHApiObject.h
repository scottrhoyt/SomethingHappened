//
//  SHJsonObj.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface SHApiObject : NSObject

+ (RKObjectMapping *)getResponseMapping;
+ (RKObjectMapping *)getRequestMapping;

@end
