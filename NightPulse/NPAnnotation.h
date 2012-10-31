//
//  NPAnnotation.h
//  NightPulse
//
//  Created by Bobby Ren on 9/30/12.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

enum NPAnnotationType {
    ANNOTATION_TYPE_PULSE = 0,
    ANNOTATION_TYPE_VENUE = 1
};

@interface NPAnnotation : NSObject <MKAnnotation>

// Center latitude and longitude of the annotion view.
// The implementation of this property must be KVO compliant.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, assign) int NPAnnotationType;
// @optional
// Title and subtitle for use by selection UI.
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
// @end

// Other properties:
@property (nonatomic, readonly, strong) PFObject *object;
@property (nonatomic, readonly, strong) PFGeoPoint *geopoint;
@property (nonatomic, assign) BOOL animatesDrop;
@property (nonatomic, readonly) MKPinAnnotationColor pinColor;

// Designated initializer.
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title andSubtitle:(NSString *)subtitle;
- (id)initWithPFObject:(PFObject *)object;

//- (void)setTitleAndSubtitleOutsideDistance:(BOOL)outside;

@end
