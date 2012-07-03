//
//  LocationP.h
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "CoreLocation/CoreLocation.h"
#import "LocationFinderDelegate.h"


@interface LocationFinder : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    id <LocationFinderDelegate> delegate;
}

//+ (LocationFinder*) getLocationFinder;

- (id)initWithDelegate:(id <LocationFinderDelegate>)delegate;

- (void)startUpdatingLocation;

//- (Location*) getCurrentLocation;


@end
