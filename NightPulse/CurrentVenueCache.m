//
//  CurrentVenueCache.m
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrentVenueCache.h"
#import "FourSquareVenueSearchOperation.h"
#import "NightPulseAppDelegate.h"

@interface CurrentVenueCache () {
    NightPulseAppDelegate *appDelegate;
    NSObject *lock;
}
@end


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
        venues = [[NSMutableArray alloc] init];
        
        appDelegate = (NightPulseAppDelegate*) [UIApplication sharedApplication].delegate;
        
        lock = [[NSObject alloc] init];
    }

    return self;
}

- (void)dealloc {
    [super dealloc];
    [location release];
    [operationQueue release];
    [cache release];
    [venues release];
    [lock release];
}

- (void)submitVenueSearchRequest:(CLLocation *)newLocation {
    NSLog(@"Calling submitVenueSearchRequest");
    while ([operationQueue operationCount] != 0) {

    }
    
    @synchronized(lock) {
        

        CLLocationDegrees newLongitude = newLocation.coordinate.longitude;
        CLLocationDegrees newLatitude = newLocation.coordinate.latitude;
        
        CLLocationDegrees currentLongitude = location == nil ? -1000 : location.coordinate.longitude;
        CLLocationDegrees currentLatitude = location == nil ? -1000 : location.coordinate.latitude;
        
        
        NSLog(@"new location: %f %f cached location: %f %f", newLatitude, newLongitude, currentLatitude, currentLongitude);
        if (currentLongitude == newLongitude && currentLatitude == newLatitude) {
            
            DebugLog(@"Location is same, returning cached venues, count = %i", [venues count]);
    //        [delegate onNearestVenueResult:venues];
            
            [appDelegate onNearestVenueResult:venues];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReceivedVenues object:self userInfo:nil];

            return;
        } else {
            DebugLog(@"Location not same as location_ ! %@ != %@", location, newLocation);
            
            [newLocation retain];
            if (nil != location)
                [location release];
    
            location = newLocation;
            DebugLog(@"Creating 4sq operation, searchTerm=nil");
            FourSquareVenueSearchOperation *endpoint = [[FourSquareVenueSearchOperation alloc] initWithLocation:location searchTerm:nil venueListEventDelegate:self];
            [operationQueue addOperation:endpoint];
            DebugLog(@"Added %@ to operation queue", endpoint);
            [endpoint release];
        }
        
    }
}

//
//- (NSArray *)getCurrentVenues {
//    DebugLog(@"getCurrentVenues: Venue count = %i", [venues count]);
//    return venues;
//}

- (void)onNearestVenueResult:(NSMutableArray *)venues_ {
    venues = venues_;
    DebugLog(@"onNearestVenueResult: Venue count = %i", [venues count]);
//    for (int k = 0; k < [venueListEventDelegates count]; k++) {
//        [(id <NearestVenueResultDelegate>) [venueListEventDelegates objectAtIndex:k] onNearestVenueResult:venues_];
//    }
    
    [appDelegate onNearestVenueResult:venues];
}

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues_ {
//    for (int k = 0; k < [venueListEventDelegates count]; k++) {
//        [(id <NearestVenueResultDelegate>) [venueListEventDelegates objectAtIndex:k] onNearestVenueSearchResult:venues_];
//    }
}

-(void)onNearestVenueFailed {
    // search failed; clear cache/location
//    location = nil;
}

@end
