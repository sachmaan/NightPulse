//
//  Location.m
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize latitude;
@synthesize longitude;


- (BOOL)isEqualToLocation:(Location *)other {

    BOOL latEqual = (other.latitude == self.latitude);
    BOOL longEqual = (other.longitude == self.longitude);
    BOOL bothEqual = latEqual && longEqual;

//    DebugLog(@"self.latitude=%f, self.longtitude=%f, other.lat=%f, other.lon=%f", self.latitude, self.longitude, other.latitude, other.longitude);
//    DebugLog(@"lat=%i, long=%i, together=%i", latEqual, longEqual, bothEqual);
//    return (other.latitude == self.latitude) & (other.longitude == self.latitude);
    return bothEqual;

}

@end
