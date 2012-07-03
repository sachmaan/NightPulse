//
//  PulseRootViewController.h
//  NightPulse
//
//  Created by Sachin Nene on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearestVenueResultDelegate.h"
#import "CurrentVenueCache.h"
#import "VenueSearch.h"

@interface PulseRootViewController : UITableViewController <NearestVenueResultDelegate, UISearchBarDelegate> {
    NSMutableArray *venues;
    CurrentVenueCache *currentVenueCache;
    VenueSearch *venueSearch;
}

@end
