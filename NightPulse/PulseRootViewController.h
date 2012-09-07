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
#import "POIViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "CameraViewController.h"
#import "CheckInViewController.h"

#define USE_PULL_TO_REFRESH 1

@interface PulseRootViewController : UITableViewController <NearestVenueResultDelegate, UISearchBarDelegate, UINavigationControllerDelegate, CameraDelegate, CheckInDelegate> {
    NSMutableArray *venues;
    CurrentVenueCache *currentVenueCache;
    VenueSearch *venueSearch;
#if USE_PULL_TO_REFRESH
	EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
#endif
    
}

#if USE_PULL_TO_REFRESH
@property(assign,getter=isReloading) BOOL reloading;
@property(nonatomic,readonly) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic, retain) UIImage * venueImage;
@property(nonatomic, retain) NSIndexPath * currentVenueIndexPath;

#endif

@end
