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
@synthesize pulseImage;

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

-(id)initWithPFObject:(PFObject *)object {
    self = [super init];
    if (self) {
        self = [self fromPFObject:object];
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
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.venue.location.coordinate.latitude longitude:self.venue.location.coordinate.longitude];
    
    [venueCheckIn setObject:geoPoint forKey:@"pfGeoPoint"];
    
    NSData *imageData = UIImageJPEGRepresentation(self.pulseImage, 0.05f);
    PFFile *imageFile = [PFFile fileWithName:@"photo.jpg" data:imageData];
    
    [venueCheckIn setObject:imageFile forKey:@"photo"];

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

    
    PFGeoPoint *pfGeoPoint = [pObject objectForKey:@"pfGeoPoint"];
    self.venue.location = [[CLLocation alloc] initWithLatitude:pfGeoPoint.latitude longitude:pfGeoPoint.longitude];
    
    PFFile *image = [pObject objectForKey:@"photo"];
    
    if (image != nil) {
        NSData *imageData = [image getData];     
        self.pulseImage = [UIImage imageWithData:imageData];
    } else {
        self.pulseImage = [UIImage imageNamed:@"tab_pulse"];
    }
    
    return self;
}

@end
