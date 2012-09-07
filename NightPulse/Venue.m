//
//  Venue.m
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Venue.h"

@implementation Venue

@synthesize name;
@synthesize venueId;
@synthesize distance;
@synthesize location;
@synthesize address;
- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }

    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Venue *venue = [[Venue allocWithZone:zone] init];
    venue.name = name;
    venue.venueId = venueId;
    venue.distance = distance;
    venue.address = address;
    venue.location = location;
    return venue;
}


@end
