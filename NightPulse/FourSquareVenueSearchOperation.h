//
//  VenueEndpoint.h
//  NightPulse
//
//  Created by Sachin Nene on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearestVenueResultDelegate.h"
#import "PulseRootViewController.h"
#import "Location.h"

@interface FourSquareVenueSearchOperation : NSOperation {
    Location *location;
    id <NearestVenueResultDelegate> delegate;
    NSString *searchTerm;
}

//- (NSMutableArray* ) doVenueQuery:(double)latitude longitude:(double)longitude;

- (id)initWithLocation:(Location *)location searchTerm:(NSString *)searchTerm venueListEventDelegate:(id <NearestVenueResultDelegate>)delegate;

- (void)doVenueQuery;

//@property (nonatomic) double latitude;
//@property (nonatomic) double longitude;
//@property (nonatomic, retain) id <VenueListEventDelegate> delegate;
@end
