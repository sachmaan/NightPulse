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
#import "NightPulseAppDelegate.h"

@interface FeedViewController ()

@end

@implementation FeedViewController


- (void) dealloc
{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kNotificationDidGetLocation
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kNotificationPulseSent
                                                  object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    DebugLog(@"FeedViewController loaded");

    pulses = [[NSMutableArray alloc] initWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findPulses)
                                                 name:kNotificationDidGetLocation
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findPulses)
                                                 name:kNotificationPulseSent
                                               object:nil]; 

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

- (void)findPulses {
    DebugLog(@"findPulses called");
    
    CLLocation *location = ((NightPulseAppDelegate*) [UIApplication sharedApplication].delegate).location;
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
