//
//  CheckIn.h
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObjectFactory.h"
#import "Venue.h"
#import <Parse/Parse.h>

@interface CheckIn : NSObject //<PFObjectFactory>

@property(nonatomic, retain) NSString *userId;
@property(nonatomic, retain) Venue *venue;
@property(nonatomic, retain) NSNumber *sexRatio;
@property(nonatomic, retain) NSNumber *crowdRatio;
@property(nonatomic, retain) NSNumber *lineRatio;
@property(nonatomic, retain) NSNumber *coverCharge;
@property(nonatomic, retain) PFGeoPoint * pfGeoPoint; // used for easy querying
@property(nonatomic) NSTimeInterval age;

- (PFObject *)toPFObject;

@end
