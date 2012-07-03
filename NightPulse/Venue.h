//
//  Venue.h
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject <NSCopying>

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *venueId;
@property(nonatomic) long distance;

@end
