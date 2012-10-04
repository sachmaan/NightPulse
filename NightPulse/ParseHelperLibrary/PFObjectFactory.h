//
//  PFObjectFactory.h
//  NightPulse
//
//  Created by Sachin Nene on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol PFObjectFactory

- (PFObject *)toPFObject;
- (id)fromPFObject:(PFObject *)obj;
- (id)initWithPFObject:(PFObject *)object;

@property (nonatomic, retain) NSString * className;

@end
