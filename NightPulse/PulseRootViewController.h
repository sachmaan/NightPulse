//
//  PulseRootViewController.h
//  NightPulse
//
//  Created by Sachin Nene on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POIViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "CameraViewController.h"
#import "CheckInViewController.h"

#define USE_PULL_TO_REFRESH 1

@protocol PulseDelegate <NSObject>

-(void)refreshVenues:(NSString*)searchTerm;
-(NSArray*)getVenues;
@end

@interface PulseRootViewController : UITableViewController < UISearchBarDelegate, UINavigationControllerDelegate, CameraDelegate, CheckInDelegate> {
#if USE_PULL_TO_REFRESH
	EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
#endif
    
    id delegate;
}

#if USE_PULL_TO_REFRESH
@property(assign,getter=isReloading) BOOL reloading;
@property(nonatomic,readonly) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic, retain) UIImage * venueImage;
@property(nonatomic, retain) NSIndexPath * currentVenueIndexPath;
@property(nonatomic, assign) id delegate;
#endif

@end
