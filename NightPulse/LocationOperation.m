#import "Location.h"
#import "CoreLocation/CoreLocation.h"

@implementation LocationOperation


- (void)initWithLocationManager:(CLLocationManager *)locationManager delegate:(id <CLLocationManagerDelegate>)delegate {

}

- (Location *)findLocation {

}

- (void)main {
    DebugLog(@"Entered main");
    [self findLocation];
}


@end
