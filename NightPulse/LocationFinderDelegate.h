//
//  LocationFinderDelegate.h
//  NightPulse
//
//  Created by Sachin Nene on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@protocol LocationFinderDelegate <NSObject>

- (void)onLocation:(Location *)location;

@end
