//
//  NearbyViewController.m
//  NightPulse
//
//  Created by Bobby Ren on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NearbyViewController.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

@synthesize _mapView, scrollView;
@synthesize currentVenueCache, venues, venueSearch;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(updateLocation) 
                                                 name:@"notification_didGetLocation" 
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(updateNearbyVenues) 
                                                 name:@"notification_didGetVenues" 
                                               object:nil];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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



@end
