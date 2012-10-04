//
//  UserInfo.m
//  CrowdDynamics
//
//  Created by Bobby Ren on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParseUserInfo.h"

@implementation ParseUserInfo
@synthesize username;
@synthesize password;
@synthesize email;
@synthesize pfUser;

-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:username forKey:@"username"];
    [aCoder encodeObject:password forKey:@"password"];
    [aCoder encodeObject: email forKey:@"email"];
    
    // do not encode pfUser
}

-(id)initWithCoder:(NSCoder *)aDecoder {    
    
    if ((self = [super init])) {
        [self setUsername:[aDecoder decodeObjectForKey:@"username"]];
        [self setPassword:[aDecoder decodeObjectForKey:@"password"]];
        [self setEmail:[aDecoder decodeObjectForKey:@"email"]];
    }
    
    // do not decode pfUser
    return self;
}


@end
