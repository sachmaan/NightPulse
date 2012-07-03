//
//  VenueSearchDelegate.h
//  NightPulse
//
//  Created by Sachin Nene on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VenueSearchDelegate <NSObject>

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues;

@end
