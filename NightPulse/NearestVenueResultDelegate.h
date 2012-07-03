//
//  VenueListEventDelegate.h
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NearestVenueResultDelegate

- (void)onNearestVenueResult:(NSMutableArray *)venues;

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues;


@end
