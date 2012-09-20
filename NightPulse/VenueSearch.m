//
//  VenueSearch.m
//  NightPulse
//
//  Created by Sachin Nene on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VenueSearch.h"
#import "FourSquareVenueSearchOperation.h"

@implementation VenueSearch

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

- (void)searchForSpecificVenuesNearby:(id <NearestVenueResultDelegate>)delegate_ searchTerm:(NSString *)searchTerm_ {
    delegate = delegate_;
    searchTerm = searchTerm_;


}

- (void)onLocation:(id)location {
    DebugLog(@"Creating 4sq operation, searchTerm=%@", searchTerm);
    FourSquareVenueSearchOperation *endpoint = [[FourSquareVenueSearchOperation alloc] initWithLocation:location searchTerm:searchTerm venueListEventDelegate:delegate];
    [operationQueue addOperation:endpoint];
    DebugLog(@"Added %@ to operation queue", endpoint);
    [endpoint release];
    
    NSLog(@"location: %@", location);
}

@end
