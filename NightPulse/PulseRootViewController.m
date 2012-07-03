//
//  PulseRootViewController.m
//  NightPulse
//
//  Created by Sachin Nene on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PulseRootViewController.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "CheckInViewController.h"
#import "NearbyVenueTableCell.h"

//#import "TempController.h"
@interface PulseRootViewController ()

- (void)refresh:(NSString *)searchTerm;

- (Venue *)getVenue:(NSIndexPath *)indexPath;

@end


@implementation PulseRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    DebugLog(@"initWithNibName");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    DebugLog(@"Loading Pulse Root");
    currentVenueCache = [CurrentVenueCache getCache];
    [currentVenueCache registerDelegate:self];
    venueSearch = [[VenueSearch alloc] init];

}

- (void)viewDidUnload {
    [super viewDidUnload];
    [currentVenueCache release];
    [venueSearch release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh:nil];
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

    [self.tableView reloadData];
}

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues_ {
    DebugLog(@"calling onNearestVenueSearchResult");
    venues = venues_;
    [self.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NearbyVenueTableCell *cell = (NearbyVenueTableCell *) [self.tableView dequeueReusableCellWithIdentifier:@"NearbyVenueTableCell"];
    if (cell == nil) {
        cell = [[NearbyVenueTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NearbyVenueTableCell"];

        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NearbyVenueTableCell" owner:nil options:nil];

        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[NearbyVenueTableCell class]]) {
                cell = (NearbyVenueTableCell *) currentObject;
            }
        }
    }

//    cell.textLabel.text = [NSString stringWithFormat:@"Row %f", indexPath.row];
    if (indexPath.row < venues.count) {
//        cell.textLabel.text = [self getVenue:indexPath].name;
        Venue *venue = [self getVenue:indexPath];
        cell.venueName.text = venue.name;
        cell.venueDistance.text = [NSString stringWithFormat:@"%ld m", venue.distance];
    }

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return venues.count;
//    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CheckInViewController *checkInViewController = [[CheckInViewController alloc] init];
    checkInViewController.checkIn.userId = @"nenes";
    checkInViewController.checkIn.venue = [self getVenue:indexPath];
    [[self navigationController] pushViewController:checkInViewController animated:YES];

//    [self presentModalViewController:checkInViewController animated:YES];    

    [checkInViewController release];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDisclosureIndicator;
}

#pragma Search Delegate Methods


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
    DebugLog(@"searchBarSearchButtonClicked : %@", searchBar.text);
    [self refresh:searchBar.text];
}
@end
