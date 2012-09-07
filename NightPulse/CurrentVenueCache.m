//
//  CurrentVenueCache.m
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrentVenueCache.h"
#import "FourSquareVenueSearchOperation.h"
#import "LocationFinder.h"

@implementation CurrentVenueCache

static CurrentVenueCache *cache;

+ (CurrentVenueCache *)getCache {
    @synchronized (self) {
        if (nil == cache) {
            cache = [[CurrentVenueCache alloc] init];
        }

        return cache;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue setMaxConcurrentOperationCount:1];
        venueListEventDelegates = [[NSMutableArray alloc] init];
        venues = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void)dealloc {
    [location release];
    [operationQueue release];
    [venueListEventDelegates release];
    [cache release];
    [venues release];
}

- (void)registerDelegate:(id <NearestVenueResultDelegate>)delegate_ {
    bool delegateFound = false;
    for (int k = 0; k < [venueListEventDelegates count]; k++) {
        if ([venueListEventDelegates objectAtIndex:k] == delegate_) {
            delegateFound = true;
            break;
        }
    }
    if (!delegateFound) {
        [venueListEventDelegates addObject:delegate_];
    }
}

- (void)findNearestVenues:(id <NearestVenueResultDelegate>)delegate_ {
    DebugLog(@"findNearestVenues called");
    delegate = delegate_;
    LocationFinder *locationFinder = [[LocationFinder alloc] initWithDelegate:self];
    [locationFinder startUpdatingLocation];
}

- (void)onLocation:(Location *)location_ {
    while ([operationQueue operationCount] != 0) {

    }
    NSLog(@"new location: %f %f cached location: %f %f", location_.latitude, location_.longitude, location.latitude, location.longitude);
    if ([location_ isEqualToLocation:location]) {
        DebugLog(@"Location is same, returning cached venues, count = %i", [venues count]);
        [delegate onNearestVenueResult:venues];
        return;
    } else {
        DebugLog(@"Location not same as location_ ! %@ != %@", location, location_);
        location = location_;
        DebugLog(@"Creating 4sq operation, searchTerm=nil");
        FourSquareVenueSearchOperation *endpoint = [[FourSquareVenueSearchOperation alloc] initWithLocation:location searchTerm:nil venueListEventDelegate:self];
        [operationQueue addOperation:endpoint];
        DebugLog(@"Added %@ to operation queue", endpoint);
        [endpoint release];
    }
}


- (NSArray *)getCurrentVenues {
    DebugLog(@"getCurrentVenues: Venue count = %i", [venues count]);
    return venues;
}

- (void)onNearestVenueResult:(NSMutableArray *)venues_ {
    venues = venues_;
    DebugLog(@"onNearestVenueResult: Venue count = %i", [venues count]);
    for (int k = 0; k < [venueListEventDelegates count]; k++) {
        [(id <NearestVenueResultDelegate>) [venueListEventDelegates objectAtIndex:k] onNearestVenueResult:venues_];
    }
}

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues_ {
    for (int k = 0; k < [venueListEventDelegates count]; k++) {
        [(id <NearestVenueResultDelegate>) [venueListEventDelegates objectAtIndex:k] onNearestVenueSearchResult:venues_];
    }
}

-(void)onNearestVenueFailed {
    // search failed; clear cache/location
    location = nil;
}

@end
