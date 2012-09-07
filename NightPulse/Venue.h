//
//  Venue.h
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Venue : NSObject <NSCopying>

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *venueId;
@property(nonatomic) long distance;
@property(nonatomic, retain) CLLocation * location;
@property(nonatomic, retain) NSString *address;
@end
