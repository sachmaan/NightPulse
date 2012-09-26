//
//  NearbyViewController.m
//  NightPulse
//
//  Created by Bobby Ren on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NearbyViewController.h"
#import "NightPulseAppDelegate.h"
#import <Parse/Parse.h>
#import "PulseAnnotation.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

@synthesize _mapView, scrollView;
@synthesize currentVenueCache, venues, venueSearch;
@synthesize isFirstUpdate;
@synthesize pulses;

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
    DebugLog(@"Loading Pulse Root");
    currentVenueCache = [CurrentVenueCache getCache];
    [currentVenueCache registerDelegate:self];
    venueSearch = [[VenueSearch alloc] init];
    
    isFirstUpdate = YES;
    
    pulses = [[NSMutableDictionary alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(updateLocation) 
                                                 name:kNotificationDidGetLocation
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(updateNearbyVenues) 
                                                 name:kNotificationDidGetLocation 
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateNearbyPulses) 
                                                 name:kNotificationPulseSent 
                                               object:nil];    // set initial default region for mapview
    
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(37.761317, -122.412593);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(loc, 0.1*METERS_PER_MILE, 0.1*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];    
    [_mapView setRegion:adjustedRegion animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc {
    // remove observers
    [[NSNotificationCenter defaultCenter] removeObserver:self    
                                                    name:kNotificationDidGetLocation  
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self    
                                                    name:kNotificationPulseSent  
                                                  object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma Helper

- (Venue *)getVenue:(NSIndexPath *)indexPath {
    return ((Venue *) [venues objectAtIndex:indexPath.row]);
}


- (void)refresh:(NSString *)searchTerm {
    
    DebugLog(@"Calling refresh");
    if (nil == searchTerm) {
        [currentVenueCache findNearestVenues:self];
    } else {
        [venueSearch searchForSpecificVenuesNearby:self searchTerm:searchTerm];
    }
    
    [self updateNearbyPulses];
}

- (void)onNearestVenueResult:(NSMutableArray *)venues_ {
    DebugLog(@"calling onNearestVenueResult");
    [venues_ retain];
    if (nil != venues)
        [venues release];
    venues = venues_;
    NSLog(@"Venues: %@", venues);
    
//    [self.tableView reloadData];
}

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues_ {
    DebugLog(@"calling onNearestVenueSearchResult");
    venues = venues_;
//    [self.tableView reloadData];
    NSLog(@"Venues: %@", venues);
}

-(void)updateLocation {
    NSLog(@"UpdateLocation");
    // update venues etc
//    [self centerOnUser];
}

-(void)updateNearbyVenues {
    
}

-(void)updateNearbyPulses {
    CLLocation * location = [_mapView.userLocation location];
    CLLocationAccuracy radiusInMeters = 200;
    NSString * parseQueryClassName = @"CheckIn"; 
    [ParseHelper queryNearLocation:location withNearbyDistance:radiusInMeters forClassName:parseQueryClassName withResultsBlock:^(NSArray *results) {
        NSMutableArray * newAnnotations = [[NSMutableArray alloc] init];
        NSLog(@"Received %d results!", [results count]);
        for (PFObject * k in results) {
            NSLog(@"New annotation: %@\n", k);
            NSString * objectID = [k objectId];
            if (![pulses objectForKey:objectID]) {
                PulseAnnotation * annotation = [[PulseAnnotation alloc] initWithPFObject:k];
                [newAnnotations addObject:annotation];
                [pulses setObject:annotation forKey:objectID];
            }
        }
        NSLog(@"Adding %d new annotations!", [newAnnotations count]);
        if ([newAnnotations count] > 0) {
            [_mapView addAnnotations:newAnnotations];
            [newAnnotations release];
        }
    }];
}

#pragma mark MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // update venues that are visible?
}

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (isFirstUpdate) {
        [self centerOnUser]; 
        isFirstUpdate = NO;
    }
}

-(void)centerOnUser{
    // resets view to user if we have dragged map away
    if (self._mapView.userLocation && self._mapView.userLocation.coordinate.latitude > -90.0 && self._mapView.userLocation.coordinate.latitude < 90.0 && self._mapView.userLocation.coordinate.longitude >-180.0 && self._mapView.userLocation.coordinate.longitude < 180.0 && (self._mapView.userLocation.coordinate.latitude != 0 && self._mapView.userLocation.coordinate.longitude != 0)) {
        [self._mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self._mapView.userLocation.coordinate, 0.1*METERS_PER_MILE, 0.1*METERS_PER_MILE);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];    
        [_mapView setRegion:adjustedRegion animated:YES];
    }
}
/*
-(void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (view.annotation == gymCenter) {
        view.selected = YES;
    }
}

-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view   {
    if (view.annotation != gymCenter) {
        view.selected = NO;
        annotationView.selected = YES;
    }
}
-(void) recenterPlacemark {
    [gymCenter setCoordinate:_mapView.userLocation.coordinate];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[Annotation class]]) {
        Annotation *location = (Annotation *) annotation;
        
        annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
        } 
        else {
            annotationView.annotation = annotation;
        }
        UIImage *image = [UIImage imageNamed: @"mapmarkergp"];
        annotationView.image = image;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [annotationView addSubview:imageView];
        [imageView release];
        annotationView.annotation = location;
        annotationView.draggable = YES;
        annotationView.enabled = YES;
        annotationView.canShowCallout = NO;
        annotationView.selected = YES;
        return annotationView;
    }
    return nil;    
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    if (((Annotation*) view.annotation).coordinate.latitude > mapView.region.center.latitude + 0.5*mapView.region.span.latitudeDelta) {
        [((Annotation*) view.annotation) setCoordinate:CLLocationCoordinate2DMake(mapView.region.center.latitude +0.4*mapView.region.span.latitudeDelta, ((Annotation *) view.annotation).coordinate.longitude)];
    }
    else if (((Annotation*) view.annotation).coordinate.latitude < mapView.region.center.latitude - 0.5*mapView.region.span.latitudeDelta) {
        [((Annotation*) view.annotation) setCoordinate:CLLocationCoordinate2DMake(mapView.region.center.latitude - 0.4*mapView.region.span.latitudeDelta, ((Annotation *) view.annotation).coordinate.longitude)];
    }
    
    if (((Annotation*) view.annotation).coordinate.longitude > mapView.region.center.longitude + 0.5*mapView.region.span.longitudeDelta) {
        [((Annotation*) view.annotation) setCoordinate:CLLocationCoordinate2DMake(((Annotation *) view.annotation).coordinate.latitude, mapView.region.center.longitude +0.4*mapView.region.span.longitudeDelta)];
    }
    else if (((Annotation*) view.annotation).coordinate.longitude < mapView.region.center.longitude - 0.5*mapView.region.span.longitudeDelta) {
        [((Annotation*) view.annotation) setCoordinate:CLLocationCoordinate2DMake(((Annotation *) view.annotation).coordinate.latitude, mapView.region.center.longitude - 0.4*mapView.region.span.longitudeDelta)];
    }
    didMoveAnnotation = YES;
    view.selected = YES;
}
 */

/*
-(void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    gymPlacemark = [placemark retain];
    [geocoder release];
}

-(void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    gymPlacemark = nil;
    [geocoder release];
}
*/

@end
