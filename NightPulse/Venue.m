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
    return venue;
}


@end
