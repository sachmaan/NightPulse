//
//  ParseWrapperObject.m
//  MetWorkingLite
//
//  Created by Bobby Ren on 10/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParseWrapperObject.h"

@implementation ParseWrapperObject
@synthesize className;

-(id)init {
    self = [super init];
    if (self)
    {
        self.className = @"GenericParseObject";
    }
    return self;
}

-(id)initWithPFObject:(PFObject *)object {
    self = [super init];
    if (self) {
        self = [self fromPFObject:object];
    }
    return self;
}

-(id)initWithClassName:(NSString *)_className{
    self = [super init];
    if (self) {
        [self setClassName:_className];
    }
    return self;
}

#pragma mark Implement/extend these for your Parse compatible object

- (PFObject *)toPFObject {
    PFObject *memberObj = [[PFObject alloc] initWithClassName:className];
    [memberObj setObject:self.className forKey:@"className"];
    
    return memberObj;
}

- (id)fromPFObject:(PFObject *)pObject {
    self.className= [pObject objectForKey:@"className"];
    return self;
}

@end
