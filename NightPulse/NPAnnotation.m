//
//  NPAnnotation.m
//  NightPulse
//
//  Created by Bobby Ren on 9/30/12.
//
//

#import "NPAnnotation.h"

@interface NPAnnotation ()

// Redefine these properties to make them read/write for internal class accesses and mutations.
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) int NPAnnotationType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) PFObject *object;
@property (nonatomic, strong) PFGeoPoint *geopoint;
@property (nonatomic, assign) MKPinAnnotationColor pinColor;

@end

@implementation NPAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

@synthesize object;
@synthesize geopoint;
@synthesize animatesDrop;
@synthesize pinColor;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle {
	self = [super init];
	if (self) {
		self.coordinate = aCoordinate;
		self.title = aTitle;
		self.subtitle = aSubtitle;
		self.animatesDrop = NO;
	}
	return self;
}

- (id)initWithPFObject:(PFObject *)anObject {
	self.object = anObject;
	self.geopoint = [anObject objectForKey:@"pfGeoPoint"];
    
	[anObject fetchIfNeeded];
	CLLocationCoordinate2D aCoordinate = CLLocationCoordinate2DMake(self.geopoint.latitude, self.geopoint.longitude);
	NSString *aTitle = [anObject objectForKey:@"venueName"];
	NSString *aSubtitle = @""; //[[anObject objectForKey:kPAWParseUserKey] objectForKey:kPAWParseUsernameKey];
    
	return [self initWithCoordinate:aCoordinate andTitle:aTitle andSubtitle:aSubtitle];
}

- (BOOL)equalTo:(NPAnnotation *) anot {
	if (anot == nil) {
		return NO;
	}
    
	if (anot.object && anot.object) {
		// We have a PFObject inside the PAWPost, use that instead.
		if ([anot.object.objectId compare:self.object.objectId] != NSOrderedSame) {
			return NO;
		}
		return YES;
	} else {
		// Fallback code:
		NSLog(@"%s Testing equality of PAWPosts where one or both objects lack a backing PFObject", __PRETTY_FUNCTION__);
        
		if (anot.NPAnnotationType != self.NPAnnotationType ||
            [anot.title    compare:self.title]    != NSOrderedSame ||
			[anot.subtitle compare:self.subtitle] != NSOrderedSame ||
			anot.coordinate.latitude  != self.coordinate.latitude ||
			anot.coordinate.longitude != self.coordinate.longitude ) {
			return NO;
		}
        
		return YES;
	}
}
@end
