//
//  PFObjectFactory.h
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Parse/Parse.h"

@protocol PFObjectFactory

- (PFObject *)toPFObject;

- (id)fromPFObject:(PFObject *)obj;


@end

