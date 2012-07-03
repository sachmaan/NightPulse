//
//  main.m
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Parse/Parse.h"

int main(int argc, char *argv[]) {
    [Parse setApplicationId:@"D9HqTJrBXJEk2hxY0BepW4CL4GUa39GwWQgifN0H"
                  clientKey:@"mTMLtcCStmqiZlOyabpp3kiOR8GEDpMU9fk5BNlo"];


    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
