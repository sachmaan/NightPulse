//
//  CurrentVenueCacheRetrieval.h
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearestVenueResultDelegate.h"


@protocol NearestVenueLookup <NSObject>

- (void)findNearestVenues:(id <NearestVenueResultDelegate>)delegate;


@end
