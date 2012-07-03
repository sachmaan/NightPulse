//
//  FirstViewController.h
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearestVenueResultDelegate.h"
#import "CurrentVenueCache.h"
#import "LocationFinder.h"

@interface ExploreViewController : UITableViewController <NearestVenueResultDelegate> {
    NSMutableArray *pulses;
    NSMutableArray *venues;
    CurrentVenueCache *currentVenueCache;
    LocationFinder *locationManager;
    int pulseCount;
}

- (void)findPulses;

- (void)refresh;

- (void)getResults:(NSArray *)objects error:(NSError *)error;

@end
