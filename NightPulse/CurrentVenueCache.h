//
//  CurrentVenueCache.h
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "NearestVenueLookup.h"
#import "NearestVenueResultDelegate.h"
#import "LocationFinderDelegate.h"

@interface CurrentVenueCache : NSObject <NearestVenueLookup, NearestVenueResultDelegate, LocationFinderDelegate> {
    Location *location;
    NSMutableArray *venues;
    NSMutableArray *venueListEventDelegates;
    NSOperationQueue *operationQueue;
    id <NearestVenueResultDelegate> delegate;
}

+ (CurrentVenueCache *)getCache;

- (void)registerDelegate:(id <NearestVenueResultDelegate>)delegate;

- (NSMutableArray *)getCurrentVenues;


@end
