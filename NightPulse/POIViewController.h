//
//  POIViewController.h
//  NightPulse
//
//  Created by Bobby Ren on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Annotation.h"

#define METERS_PER_MILE 1609.344
#define MILES_PER_DEGREE 69

@interface POIViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, retain) CLLocation * location;
@property (nonatomic, retain) IBOutlet MKMapView *_mapView;
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UILabel * titleLabel;
@property (nonatomic, retain) IBOutlet UILabel * addressLabel;
@property (nonatomic, retain) IBOutlet UIImageView * imageView;

@property (nonatomic, retain) Venue * venue;
@property (nonatomic, retain) UIImage * venueImage;
-(void)initWithVenue:(Venue*)venue;
@end
