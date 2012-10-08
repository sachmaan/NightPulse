//
//  FeedViewController.m
//  NightPulse
//
//  Created by Sachin Nene on 10/4/12.
//
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "FeedTableCell.h"
#import "CheckIn.h"
#import "LabelMaker.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DebugLog(@"FeedViewController loaded");

    pulses = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)viewWillAppear:(BOOL)animated {
    DebugLog(@"viewWillAppear called");
    [self findPulses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NightPulseNavBar"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pulses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DebugLog(@"Loading cell at position %d", indexPath.row);
    FeedTableCell *cell = (FeedTableCell *) [self.tableView dequeueReusableCellWithIdentifier:@"FeedTableCell"];
    if (cell == nil) {
        //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StandardCell"] autorelease];
        
        cell = [[[FeedTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedTableCell"] autorelease];
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FeedTableCell" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[FeedTableCell class]]) {
                cell = (FeedTableCell *) currentObject;
            }
        }
         
    }
    
    UIImage *defaultImage = [UIImage imageNamed:@"tab_pulse"];
    
    
    if (indexPath.row < pulses.count) {
        CheckIn *checkIn = [pulses objectAtIndex:indexPath.row];
        cell.venueNameLabel.text = checkIn.venue.name;
        cell.distanceLabel.text = @"20 miles";
        cell.userNameLabel.text = checkIn.userId;
        cell.pulseAgeLabel.text = [LabelMaker intervalLabel:checkIn.age];
        
        if (checkIn.pulseImage != nil)
            [cell.pulsePhotoImageView setImage:checkIn.pulseImage];
        else
            [cell.pulsePhotoImageView setImage:defaultImage];
//        cell.venueMaleFemale.text = [LabelMaker sexLabel:checkIn.sexRatio.integerValue];
//        cell.venueCrowd.text = [LabelMaker crowdLabel:checkIn.crowdRatio.integerValue];
//        cell.venueLine.text = [LabelMaker lineLabel:checkIn.lineRatio.integerValue];
//        cell.pulseAge.text = [LabelMaker intervalLabel:checkIn.age];
        
    } else {
        cell.venueNameLabel.text = @"Unknown Venue";
    }
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}



#pragma mark - Other methods

-(void)updateNearbyPulses {
/*
    CLLocation * location = [_mapView.userLocation location];
    //    CLLocationDistance radiusInMeters = 200;
    CLLocationAccuracy radiusInMeters = 200;
    NSString * parseQueryClassName = @"CheckIn";
    [ParseHelper queryNearLocation:location withNearbyDistance:radiusInMeters forClassName:parseQueryClassName withResultsBlock:^(NSArray *results) {
        NSLog(@"Received %d results!", [results count]);
        for (PFObject * k in results) {
            DebugLog(@"%@\n", k);
            NSString * objectID = [k objectId];
            if (![pulses objectForKey:objectID]) {
                
            }
        }
        NSLog(@"That's all folks");
    }];
 */
    
}

- (void)findPulses {
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:37.78583400 longitude:-122.40641700];
    CLLocationAccuracy radiusInMeters = 200;
    NSString * parseQueryClassName = @"CheckIn";
    
    [ParseHelper queryNearLocation:location withNearbyDistance:radiusInMeters forClassName:parseQueryClassName withResultsBlock:^(NSArray *results) {
        NSLog(@"Received %d results!", [results count]);        
        int resultCount = [results count];
        pulses = [[NSMutableArray alloc] initWithCapacity:resultCount];
        if (resultCount == 0) {
            DebugLog(@"No results!");
        } else {
            for (int k = 0; k < resultCount; k++) {
                PFObject *pfObj = (PFObject *) [results objectAtIndex:k];
                
                CheckIn *checkIn = [[CheckIn alloc] fromPFObject:pfObj];                
                [pulses addObject:checkIn];
                
            }
        }
        
        [self.tableView reloadData];
    }
     ];

    
    
}



@end
