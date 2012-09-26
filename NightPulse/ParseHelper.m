//
//  ParseHelper.m
//  MetWorkingLite
//
//  Created by Bobby Ren on 9/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParseHelper.h"
#import <Parse/Parse.h>
//#import "UserInfo.h"
//#import "LinkedInHelper.h"

@implementation ParseHelper

/*
+ (BOOL)validateCachedUser:(UserInfo *)userInfo {
    // checks if the username in myUserInfo is the same as the username in [PFUser currentUser]
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) 
    {
        NSString * username = currentUser.username;
        NSString * password = currentUser.password;
        NSString * email = currentUser.email;
        NSLog(@"saved pfuser: %@ %@ %@ myUserInfo: %@ %@ %@", username, password, email, userInfo.username, userInfo.passwordMD5, userInfo.email);
        
        if ([userInfo.username isEqualToString:username])
            return YES;
        return NO;
    }
    else {
        return NO;
    }
}
+ (void)signup:(UserInfo*)userInfo withBlock:(void (^)(BOOL bDidSignupUser))didSignup {
    PFUser *user = [PFUser user];
    user.username = userInfo.username;
    user.password = [NSString stringWithFormat:@"test"]; //userInfo.password;
    user.email = userInfo.email;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) 
     {
         if (error) // Something went wrong
         { 
             didSignup(NO);
         }
         else {
             // Success!
             didSignup(YES);
         }
     }];
}
+ (void)login:(UserInfo*) userInfo withBlock:(void (^)(BOOL bDidLoginUser))didLogin {
    NSString * username = userInfo.username;
    NSString * password = [NSString stringWithFormat:@"test"];
    [PFUser logInWithUsernameInBackground:username 
                                 password:password 
                                    block:^(PFUser *user, NSError *error) 
     {
         if (user) // Login successful
         {
             // Create next view controller to show
             didLogin(YES);
         } 
         else // Login failed
         {
             didLogin(NO);
        }
     }];
}
*/

+ (void)queryNearLocation:(CLLocation *)currentLocation withNearbyDistance:(CLLocationAccuracy)nearbyDistance forClassName:(NSString*)className withResultsBlock:(void(^)(NSArray* results))queriedResults 
{
    NSLog(@"Querying class %@ near location %@ for distance %f", className, currentLocation, nearbyDistance);
    
    PFQuery *wallPostQuery = [PFQuery queryWithClassName:className];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    wallPostQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    // Create a PFGeoPoint using the current location (to use in our query)
    PFGeoPoint *userLocation = 
    [PFGeoPoint geoPointWithLatitude:currentLocation.coordinate.latitude
                           longitude:currentLocation.coordinate.longitude];
    
    // Create a PFQuery asking for all wall posts 100km of the user
    // We won't be showing all of the posts returned, 100km is our buffer
    [wallPostQuery whereKey:@"pfGeoPoint" // specifies key for the PFGeoPoint of this class
               nearGeoPoint:userLocation 
           withinKilometers:100];
    
    // Include the associated PFUser objects in the returned data
    [wallPostQuery includeKey:@"userId"];
    
    // Limit the number of wall posts returned to 20
    wallPostQuery.limit = 20;

    //Run the query in background with completion block
    [wallPostQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) 
     {
         if (error) // The query failed
         {
             NSLog(@"Error in geo query!"); 
         } 
         else // The query is successful
         {
             queriedResults(objects);
         }
     }];
}
@end
