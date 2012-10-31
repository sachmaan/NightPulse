//
//  ParseHelper.h
//  MetWorkingLite
//
//  Created by Bobby Ren on 9/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseUserInfo.h"
#import <Parse/Parse.h>
/*
 @protocol ParseDelegate <NSObject>
 
 -(void)didCreateParseUser;
 -(void)didLoginParseUser;
 
 @end
 */

@interface ParseHelper : NSObject

//@property (nonatomic, assign) id delegate;
+ (void)ParseHelper_signup:(ParseUserInfo*)userInfo withBlock:(void (^)(BOOL bDidSignupUser, NSError * error))didSignup;
+ (void)ParseHelper_login:(ParseUserInfo*) userInfo withBlock:(void (^)(PFUser * user, NSError * error))didLogin;
+ (BOOL)ParseHelper_validateCachedUser:(ParseUserInfo *)userInfo;

+ (void)queryNearLocation:(CLLocation *)currentLocation withNearbyDistance:(CLLocationAccuracy)nearbyDistance forClassName:(NSString*)className withResultsBlock:(void(^)(NSArray* results))queriedResults;
+(void)addParseObjectToParse:(PFObject*)pfObject withBlock:(void(^)(BOOL, NSError*))addObjectCompletedWithResults;
+(void)queryForAllParseObjectsWithClass:(NSString*)className withBlock:(void (^)(NSArray *, NSError *))queryCompletedWithResults;
+(void)updateParseObject:(PFObject*)pfObject forUser:(PFUser*)pfUser withBlock:(void(^)(BOOL, NSError*))parseObjectUpdatedWithResults;
@end
