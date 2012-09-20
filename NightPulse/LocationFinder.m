//
//  LocationFinder.m
//  NightPulse
//
//  Created by Sachin Nene on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationFinder.h"

@implementation LocationFinder

//static LocationFinder* locationFinder;

//+ (LocationFinder*) getLocationFinder {
//    @synchronized(self) {
//        if (nil == locationFinder) {
//            locationFinder = [[LocationFinder alloc] init];
//        }
//        
//        return locationFinder;
//    }
//}

- (id)initWithDelegate:(id <LocationFinderDelegate>)delegate_ {
    DebugLog(@"initWithDelegate");
    [super init];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    [locationManager startUpdatingLocation];

    DebugLog(@"LocationManager = %@", locationManager);
    delegate = delegate_;

    return self;
}

- (void)dealloc {
    [locationManager setDelegate:nil];
    [super dealloc];
}

- (void)startUpdatingLocation {
    DebugLog(@"startUpdatingLocation");
    [locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    DebugLog(@"Received Location");
    Location *location = [[Location alloc] init];
    
    //NEW YORK
//    location.latitude = 40.730223;
//    location.longitude = -73.988564;
    
    //ANDALA COFFEE HOUSE, CENTRAL SQUARE
    //    location.latitude = 42.364838;
    //    location.longitude = -71.106222;
    
    //ACTUAL LAT/LONG FROM GPS
    location.latitude = newLocation.coordinate.latitude;
    location.longitude = newLocation.coordinate.longitude;
    DebugLog(@"GOT LOCATION! %@", newLocation);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_didGetLocation" object:self userInfo:nil];

    [locationManager stopUpdatingLocation];

    [delegate onLocation:location];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    DebugLog(@"COULD NOT FIND LOCATION!");
}
@end
