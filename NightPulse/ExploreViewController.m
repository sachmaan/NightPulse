//
//  FirstViewController.m
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExploreViewController.h"
#import "ExploreTableCell.h"
#import "Venue.h"
#import "Parse/Parse.h"
#import "CheckIn.h"
#import "LabelMaker.h"


@implementation ExploreViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    pulses = [[NSMutableArray alloc] initWithCapacity:0];
    currentVenueCache = [CurrentVenueCache getCache];
    [currentVenueCache registerDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    DebugLog(@"viewWillAppear called");
    [self refresh];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [venues release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pulses count];
    //    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ExploreTableCell *cell = (ExploreTableCell *) [self.tableView dequeueReusableCellWithIdentifier:@"ExploreTableCell"];
    if (cell == nil) {
        //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StandardCell"] autorelease];

        cell = [[[ExploreTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExploreTableCell"] autorelease];

        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ExploreTableCell" owner:nil options:nil];

        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[ExploreTableCell class]]) {
                cell = (ExploreTableCell *) currentObject;
            }
        }
    }

    if (indexPath.row < venues.count) {
        CheckIn *checkIn = [pulses objectAtIndex:indexPath.row];
        cell.venueName.text = checkIn.venue.name;
        cell.venueMaleFemale.text = [LabelMaker sexLabel:checkIn.sexRatio.integerValue];
        cell.venueCrowd.text = [LabelMaker crowdLabel:checkIn.crowdRatio.integerValue];
        cell.venueLine.text = [LabelMaker lineLabel:checkIn.lineRatio.integerValue];
        cell.pulseAge.text = [LabelMaker intervalLabel:checkIn.age];

    } else {
        cell.venueName.text = [[NSString alloc] initWithFormat:@"Unknown venue %d% Min", indexPath.row];
    }


    return cell;
}

- (void)onNearestVenueResult:(NSMutableArray *)venues_ {
    [venues_ retain];
    if (nil != venues)
        [venues release];
    venues = venues_;
    [self findPulses];
}

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues {
    //Ignore, never show search results in explore view
    DebugLog(@"onNearestVenueSearchResult called, ignored");
}

- (void)refresh {
    DebugLog(@"Calling refresh");
    [currentVenueCache findNearestVenues:self];
}

- (void)findPulses {
    pulseCount = 0;
    int nearbyVenueCount = [venues count];

    DebugLog(@"Venue count = %d", nearbyVenueCount);
    NSMutableDictionary *venueDict = [[NSMutableDictionary alloc] init];
    NSMutableArray *venueIds = [[NSMutableArray alloc] initWithCapacity:nearbyVenueCount];

    for (int k = 0; k < nearbyVenueCount; k++) {
        Venue *venue = (Venue *) [[venues objectAtIndex:k] copyWithZone:nil];
        NSString *venueId = [venue venueId];
        [venueDict setObject:venue forKey:venueId];
        [venueIds addObject:venueId];
        [venue release];
    }


    PFQuery *query = [PFQuery queryWithClassName:@"CheckIn"];
    [query whereKey:@"venueId" containedIn:venueIds];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        pulseCount++;

        int resultCount = [objects count];
        pulses = [[NSMutableArray alloc] initWithCapacity:resultCount];
        if (resultCount == 0) {
            DebugLog(@"No results!");
        } else {
            for (int k = 0; k < resultCount; k++) {
                PFObject *pfObj = (PFObject *) [objects objectAtIndex:k];
                NSString *venueId = [pfObj objectForKey:@"venueId"];
                NSDate *createdAt = pfObj.createdAt;
                NSDate *current = [NSDate date];
                NSTimeInterval interval = [current timeIntervalSinceDate:createdAt];
                NSNumber *sexRatio = [pfObj objectForKey:@"sex"];
                NSNumber *crowdRatio = [pfObj objectForKey:@"crowd"];
                NSNumber *lineRatio = [pfObj objectForKey:@"line"];
                NSNumber *coverCharge = [pfObj objectForKey:@"cover"];

                DebugLog(@"VenueId=%@, CreatedAt=%@, SexRatio=%@, Interval=%f", venueId, createdAt, sexRatio, interval);
                CheckIn *checkIn = [[CheckIn alloc] init];
                checkIn.sexRatio = sexRatio;
                checkIn.crowdRatio = crowdRatio;
                checkIn.lineRatio = lineRatio;
                checkIn.coverCharge = coverCharge;
                checkIn.venue = [venueDict objectForKey:venueId];
                checkIn.age = interval;

                [pulses addObject:checkIn];

            }
        }

        [self.tableView reloadData];
    }
    ];
    [venueIds release];
    [venueDict release];


}

- (void)getResults:(NSArray *)objects error:(NSError *)error {
    //    pulseCount++;
    //    
    //    DebugLog(@"Received result %d, objects size=%d, error=%@!", pulseCount, [objects count], error);
    //    
    //    for (int k= 0 ; k < [objects count]; k++) {
    //        PFObject* pfObj = (PFObject*)[objects objectAtIndex:k];
    //        NSString* venueId = [pfObj objectForKey:@"venueId"];
    //        DebugLog(@"VenueId=%@", venueId);
    //    }

}
@end
