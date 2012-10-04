//
//  ParseHelper.m
//  MetWorkingLite
//
//  Created by Bobby Ren on 9/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParseHelper.h"
#import "ParseUserInfo.h"
//#import "LinkedInHelper.h"

@implementation ParseHelper

//@synthesize delegate;

+ (BOOL)ParseHelper_validateCachedUser:(ParseUserInfo *)userInfo {
    // checks if the username in myUserInfo is the same as the username in [PFUser currentUser]
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        NSString * username = currentUser.username;
        //NSString * password = currentUser.password;
        //NSString * email = currentUser.email;
        NSLog(@"saved pfuser: %@ myUserInfo: %@", username, userInfo.username);
        
        if ([userInfo.username isEqualToString:username])
            return YES;
        return NO;
    }
    else {
        return NO;
    }
}
+ (void)ParseHelper_signup:(ParseUserInfo*)userInfo withBlock:(void (^)(BOOL bDidSignupUser, NSError * error))didSignup {
    PFUser *user = [PFUser user];
    user.username = userInfo.username;
    user.password = userInfo.password;
    user.email = userInfo.email;
#if 1
    [user signUpInBackgroundWithBlock:didSignup];
#else
    [user signUpInBackgroundWithBlock:
     ^(BOOL succeeded, NSError *error)
     {
         if (error) // Something went wrong
         {
             NSLog(@"ParseHelper signup received error: %@", error);
             didSignup(NO, error);
         }
         else {
             // Success!
             didSignup(YES, nil);
         }
     }];
#endif
}

+ (void)ParseHelper_login:(ParseUserInfo*) userInfo withBlock:(void (^)(PFUser* user, NSError * error))didLogin {
    NSString * username = userInfo.username;
    NSString * password = userInfo.password; // should send in the encoded password to parse
    [PFUser logInWithUsernameInBackground:username
                                 password:password
#if 1
                                    block:didLogin];
#else
                                    block:^(PFUser *user, NSError *error)
     {
         if (user) // Login successful
         {
             // Create next view controller to show
             didLogin(YES, nil);
         }
         else // Login failed
         {
             NSLog(@"ParseHelper login received error: %@", error);
             didLogin(NO, error);
         }
     }];
#endif
}

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
    //[wallPostQuery includeKey:@"userId"];
    
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

+(void)addParseObjectToParse:(PFObject*)pfObject withBlock:(void(^)(BOOL, NSError*))addObjectCompletedWithResults {
    // Set the access control list on the postObject to restrict future modifications
    // to this object
    PFACL *readOnlyACL = [PFACL ACL];
    [readOnlyACL setPublicReadAccess:YES]; // Create read-only permissions
    [readOnlyACL setPublicWriteAccess:NO];
    [pfObject setACL:readOnlyACL]; // Set the permissions on the postObject
    
    [pfObject saveInBackgroundWithBlock:addObjectCompletedWithResults];
}

+(void)queryForAllParseObjectsWithClass:(NSString*)className withBlock:(void (^)(NSArray *, NSError *))queryCompletedWithResults {
    
    PFCachePolicy policy = kPFCachePolicyCacheThenNetwork;
    PFQuery * query = [PFQuery queryWithClassName:className];
    [query setCachePolicy:policy];
    
    //[memberQuery whereKeyExists:@"memberID"];
    [query findObjectsInBackgroundWithBlock:queryCompletedWithResults];
}

+(void)updateParseObject:(PFObject*)pfObject forUser:(PFUser*)pfUser withBlock:(void(^)(BOOL, NSError*))parseObjectUpdatedWithResults {
    // Set the access control list on the postObject to restrict future modifications
    // to this object
    PFACL *readOnlyACL = [PFACL ACL];
    [readOnlyACL setPublicReadAccess:YES]; // Create read-only permissions
    [readOnlyACL setPublicWriteAccess:NO];
    [pfObject setACL:readOnlyACL]; // Set the permissions on the postObject
    
    // for now, add new object
    // todo: make this data a one-to-one with the pfUser
    [pfObject saveInBackgroundWithBlock:parseObjectUpdatedWithResults];
}
@end
