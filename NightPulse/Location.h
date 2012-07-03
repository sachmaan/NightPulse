//
//  Location.h
//  NightPulse
//
//  Created by Sachin Nene on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

- (BOOL)isEqualToLocation:(Location *)other;

@property(nonatomic) double latitude;
@property(nonatomic) double longitude;


@end
