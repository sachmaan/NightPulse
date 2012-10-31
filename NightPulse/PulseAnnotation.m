//
//  PulseAnnotation.m
//  NightPulse
//
//  Created by Bobby Ren on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PulseAnnotation.h"

@interface PulseAnnotation ()

@property (nonatomic, strong) PFUser *user;

@end

@implementation PulseAnnotation

@synthesize user;

- (id)initWithPFObject:(PFObject *)anObject {
    self.user = [anObject objectForKey:@"userId"];
    return [super initWithPFObject:anObject];
}

- (BOOL)equalTo:(ParseLocationAnnotation *) anot {
    if ([[[(PulseAnnotation*)anot user] username] isEqualToString:self.user.username])
        return YES;
    
    return [super equalTo:anot];
}
@end
