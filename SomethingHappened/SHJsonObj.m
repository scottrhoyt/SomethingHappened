//
//  SHJsonObj.m
//  SomethingHappened
//
//  Created by Scott Hoyt on 3/6/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHJsonObj.h"

@interface SHJsonObj ()

@property (nonatomic, strong) NSMutableDictionary *data;

@end

@implementation SHJsonObj

- (NSDictionary *)data
{
    if (!_data) {
        _data = [[NSMutableDictionary alloc] init];
    }
    
    return _data;
}

@end
