//
//  VenueEndpoint.m
//  NightPulse
//
//  Created by Sachin Nene on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FourSquareVenueSearchOperation.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "FourSquareConstants.h"
#import "Venue.h"

//#define VENUES_SEARCH_URL @"https://api.foursquare.com/v2/venues/search?v=20111011&ll=%f,%f&categoryId=%@&client_id=%@&client_secret=%@"
//#define VENUES_SEARCH_URL_WITH_TERM @"https://api.foursquare.com/v2/venues/search?v=20111011&ll=%f,%f&client_id=%@&client_secret=%@&query=%@"


@implementation FourSquareVenueSearchOperation


- (void)dealloc {
    [searchTerm release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }

    return self;
}

- (id)initWithLocation:(Location *)location_ searchTerm:(NSString *)searchTerm_ venueListEventDelegate:(id <NearestVenueResultDelegate>)delegate_ {
    self = [super init];
    location = location_;
    delegate = delegate_;
    if (nil != searchTerm_) {
        searchTerm = [[NSString alloc] initWithString:searchTerm_];
    }
    DebugLog(@"init searchTerm=%@", searchTerm);
    return self;

}

- (void)doVenueQuery {
    NSString *urlString;

//    NSString *VENUES_SEARCH_URL = @"https://api.foursquare.com/v2/venues/search?v=20111011&ll=%f,%f&categoryId=%@&client_id=%@&client_secret=%@";
    NSString *VENUES_SEARCH_URL = @"https://api.foursquare.com/v2/venues/search?v=20111011&ll=%f,%f&client_id=%@&client_secret=%@";

    NSString *VENUES_SEARCH_URL_WITH_TERM = @"https://api.foursquare.com/v2/venues/search?v=20111011&ll=%f,%f&client_id=%@&client_secret=%@&query=%@";

    DebugLog(@"doVenueQuery searchTerm=%@", searchTerm);

    bool searchTermExists = (nil != searchTerm);
    if (!searchTermExists) {
        urlString = [NSString stringWithFormat:VENUES_SEARCH_URL, location.latitude, location.longitude, /*FOURSQ_NIGHTLIFE_CAT_ID, */FOURSQ_CLIENT_ID, FOURSQ_CLIENT_SECRET];
    } else {
        urlString = [NSString stringWithFormat:VENUES_SEARCH_URL_WITH_TERM, location.latitude, location.longitude, /*FOURSQ_NIGHTLIFE_CAT_ID,*/ FOURSQ_CLIENT_ID, FOURSQ_CLIENT_SECRET, searchTerm];
    }

    DebugLog (@"Search URL = %@", urlString);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlString]];

    [request startSynchronous];

    NSError *error = [request error];
    if (error) {
        DebugLog (@"ERROR =  %@", error.description);
        [delegate onNearestVenueFailed];
        return;
    }

    DebugLog(@"Response Str = %@", [request responseString]);
    NSDictionary *venues = [[request responseData] objectFromJSONData];
//    DebugLog (@"Received response = %@", venues);


    NSString *errorStr = [[venues objectForKey:@"meta"] objectForKey:@"errorDetail"];

    if (nil != errorStr) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }


    NSArray *nearbyVenuesDicts = [[venues objectForKey:@"response"] objectForKey:@"venues"];

//    Venue* venueList[[nearbyVenuesDicts count] + 1];


    NSMutableArray *venueList = [[NSMutableArray alloc] initWithCapacity:[nearbyVenuesDicts count] + 1];

    //Remove later
    /*
    Venue *testVenue = [[[Venue alloc] init] autorelease];
    testVenue.name = @"Test Venue";
    testVenue.venueId = @"100000000000";
    testVenue.distance = 345;
     */
    //    venueList[0] = testVenue;

    
    //[venueList addObject:testVenue];
//    int count = 1;
    for (NSDictionary *venueDict in nearbyVenuesDicts) {
        Venue *venue = [[Venue alloc] init];
        venue.name = ((NSString *) [venueDict objectForKey:@"name"]);
        venue.venueId = [venueDict objectForKey:@"id"];
        venue.distance = [[[venueDict objectForKey:@"location"] objectForKey:@"distance"] longValue];
        
        // address and location
        NSDictionary * locationDict = [venueDict objectForKey:@"location"];
        NSLog(@"Venue: %@", locationDict);
        
        NSString * address = [locationDict objectForKey:@"address"];
        NSString * city = [locationDict objectForKey:@"city"];
        NSString * state = [locationDict objectForKey:@"state"];
        NSString * country = [locationDict objectForKey:@"country"];
        NSString * lat = [locationDict objectForKey:@"lat"];
        NSString * lon = [locationDict objectForKey:@"lng"];
        
        if ([country isEqualToString:@"United States"]) {
            address = [NSString stringWithFormat:@"%@\n%@, %@", address, city, state];
        }
        else {
            address = [NSString stringWithFormat:@"%@\n%@, %@", address, state, country];
        }
        NSLog(@"Venue address: %@", address);
        [venue setAddress:address];
        CLLocation * loc = [[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lon floatValue]];
        [venue setLocation:loc];

        [venueList addObject:venue];
        [venue release];
    }

    if (searchTermExists) {
        [delegate onNearestVenueSearchResult:venueList];
    } else {
        [delegate onNearestVenueResult:venueList];
    }

    [venueList release];
}

- (void)main {
    DebugLog(@"Entered main, searchTerm=%@", searchTerm);
    [self doVenueQuery];
}


@end
