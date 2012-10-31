//
//  CurrentVenueCache.h
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "NearestVenueLookup.h"
#import "NearestVenueResultDelegate.h"
#import "LocationFinderDelegate.h"

@interface CurrentVenueCache : NSObject <NearestVenueResultDelegate> {
    CLLocation *location;
    NSMutableArray *venues;
//    NSMutableArray *venueListEventDelegates;
    NSOperationQueue *operationQueue;
//    id <NearestVenueResultDelegate> delegate;
}

+ (CurrentVenueCache *)getCache;

//- (void)registerDelegate:(id <NearestVenueResultDelegate>)delegate;

//- (NSMutableArray *)getCurrentVenues;

- (void)submitVenueSearchRequest:(CLLocation *)location;

@end
