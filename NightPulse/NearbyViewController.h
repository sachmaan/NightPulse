//
//  NearbyViewController.h
//  NightPulse
//
//  Created by Bobby Ren on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Annotation.h"
#import "VenueSearch.h"
#import "NearestVenueResultDelegate.h"
#import "CurrentVenueCache.h"

@interface NearbyViewController : UIViewController <NearestVenueResultDelegate, MKMapViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet MKMapView *_mapView;
@property (nonatomic, retain) NSMutableArray *venues;
@property (nonatomic, retain) CurrentVenueCache *currentVenueCache;
@property (nonatomic, retain) VenueSearch *venueSearch;

@end
