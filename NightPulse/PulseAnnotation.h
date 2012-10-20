//
//  PulseAnnotation.h
//  NightPulse
//
//  Created by Bobby Ren on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "ParseLocationAnnotation.h"

@interface PulseAnnotation : ParseLocationAnnotation

@property (nonatomic, readonly, strong) PFUser *user;

@end