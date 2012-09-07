//
//  Annotation.m
//  NightPulse
//
//  Created by Bobby Ren on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//
//  Annotation.m
//  Gym-Pact
//
//  Created by Geoff Oberhofer on 6/6/11.
//  Copyright 2011 Harvard University. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize name;
@synthesize address;
@synthesize coordinate;

-(id) initWithName:(NSString *)_name address:(NSString *)_address coordinate:(CLLocationCoordinate2D)_coordinate
{
    if ((self = [super init])) {
        self.name = _name;
        self.address = _address;
        coordinate = _coordinate;
    }
    return self;
}

- (NSString *)title {
    return name;
}

- (NSString *)subtitle {
    return address;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

- (void)dealloc
{
    [name release];
    name = nil;
    [address release];
    address = nil;    
    [super dealloc];
}

@end

