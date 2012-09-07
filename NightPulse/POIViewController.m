//
//  POIViewController.m
//  NightPulse
//
//  Created by Bobby Ren on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "POIViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface POIViewController ()

@end

@implementation POIViewController
@synthesize _mapView, scrollView;
@synthesize titleLabel, addressLabel, imageView;
@synthesize location;
@synthesize venue;
@synthesize venueImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self populateVenueInfo];
    [imageView setImage:venueImage];
}

-(void)populateVenueInfo {
    [titleLabel setText:[venue name]];
    [addressLabel setText:[venue address]];
    CLLocation * loc = venue.location;
    [_mapView setCenterCoordinate:loc.coordinate];
    NSLog(@"loc: %f %f", loc.coordinate.latitude, loc.coordinate.longitude);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(loc.coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];

    Annotation * annotation = [[Annotation alloc] initWithName:venue.name address:venue.address coordinate:loc.coordinate];
    [_mapView addAnnotation:annotation];
    [_mapView setShowsUserLocation:YES];
    
    [imageView setBackgroundColor:[UIColor blackColor]];
    [imageView.layer setBorderWidth:3];
    [imageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

@end
