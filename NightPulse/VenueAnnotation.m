//
//  VenueAnnotation.m
//  NightPulse
//
//  Created by Bobby Ren on 9/30/12.
//
//

#import "VenueAnnotation.h"

@interface VenueAnnotation ()

@property (nonatomic, strong) Venue * venue;
@end

@implementation VenueAnnotation

@synthesize venue;

-(id)initWithVenue:(Venue *)_venue {
    [self setVenue:_venue];
    NSString * title = [venue name];
    NSString * subtitle = @"";
    CLLocationCoordinate2D coord = venue.location.coordinate;
    return [super initWithCoordinate:coord andTitle:title andSubtitle:subtitle];
}

- (BOOL)equalTo:(NPAnnotation *) anot {
    VenueAnnotation * va = (VenueAnnotation*) anot;
    if (![va.venue.name isEqualToString:self.venue.name] ||
        ![va.venue.location isEqual:self.venue.location])
        return NO;
    return [super equalTo:anot];
}
@end
