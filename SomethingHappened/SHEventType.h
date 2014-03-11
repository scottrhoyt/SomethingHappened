//
//  SHEventType.h
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/11/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHApiObject.h"

@interface SHEventType : SHApiObject

@property (nonatomic) NSUInteger eventTypeId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;

@end
