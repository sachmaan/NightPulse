//
//  CheckIn.m
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckIn.h"

@implementation CheckIn

@synthesize userId;
@synthesize venue;
@synthesize sexRatio;
@synthesize crowdRatio;
@synthesize lineRatio;
@synthesize coverCharge;
@synthesize age;
@synthesize pfGeoPoint;

- (id)init {
    self = [super init];
    if (self) {
//        self.venue = [[[Venue alloc] init] autorelease];
        // Initialization code here.
        self.coverCharge = [NSNumber numberWithInt:100];
        self.age = 0;
    }

    return self;
}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"CheckIn: UserId=%@ SexRatio=%@ CrowdRatio=%@",name,author];
//}

- (PFObject *)toPFObject {
    PFObject *venueCheckIn = [[[PFObject alloc] initWithClassName:@"CheckIn"] autorelease];
    [venueCheckIn setObject:self.venue.venueId forKey:@"venueId"];
    [venueCheckIn setObject:self.venue.name forKey:@"venueName"];
    [venueCheckIn setObject:self.userId forKey:@"userId"];
    [venueCheckIn setObject:self.sexRatio forKey:@"sex"];
    [venueCheckIn setObject:self.crowdRatio forKey:@"crowd"];
    [venueCheckIn setObject:self.lineRatio forKey:@"line"];
    [venueCheckIn setObject:self.coverCharge forKey:@"cover"];
    [venueCheckIn setObject:self.pfGeoPoint forKey:@"pfGeoPoint"];

    return venueCheckIn;
}

- (id)fromPFObject:(PFObject *)pObject {
    self.venue = [[Venue alloc] init];
    self.venue.venueId = [pObject objectForKey:@"venueId"];
    self.venue.name = [pObject objectForKey:@"venueName"];

    self.userId = [pObject objectForKey:@"userId"];
    self.sexRatio = [pObject objectForKey:@"sex"];
    self.crowdRatio = [pObject objectForKey:@"crowd"];
    self.lineRatio = [pObject objectForKey:@"line"];
    self.coverCharge = [pObject objectForKey:@"cover"];

    self.pfGeoPoint = [pObject objectForKey:@"pfGeoPoint"];
    return self;
}

@end
