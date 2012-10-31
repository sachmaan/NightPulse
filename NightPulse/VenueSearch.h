//
//  VenueSearch.h
//  NightPulse
//
//  Created by Sachin Nene on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenueSearchDelegate.h"
#import "NearestVenueResultDelegate.h"
#import "LocationFinderDelegate.h"

@interface VenueSearch : NSObject {
    NSMutableArray *venues;
    NSMutableArray *venueListEventDelegates;
    NSOperationQueue *operationQueue;
    id <NearestVenueResultDelegate> delegate;
    NSString *searchTerm;
}

- (void)searchForSpecificVenuesNearby:(id <NearestVenueResultDelegate>)delegate searchTerm:(NSString *)searchTerm;


@end
