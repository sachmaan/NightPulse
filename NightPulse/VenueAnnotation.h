//
//  PulseAnnotation.h
//  NightPulse
//
//  Created by Bobby Ren on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "PulseAnnotation.h"
#import "Venue.h"
#import "ParseLocationAnnotation.h"

@interface VenueAnnotation : ParseLocationAnnotation //NSObject <MKAnnotation>

@property (nonatomic, readonly, strong) Venue * venue;

- (id)initWithVenue:(Venue *)_venue;

@end
