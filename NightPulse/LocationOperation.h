//
//  LocationOperation.h
//  NightPulse
//
//  Created by Sachin Nene on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "CoreLocation/CoreLocation.h"

@interface LocationOperation : NSObject

- (void)initWithLocationManager:(CLLocationManager *)locationManager delegate:(id <CLLocationManagerDelegate>)delegate;

- (Location *)findLocation;

@end
