//
//  ParseHelper.h
//  MetWorkingLite
//
//  Created by Bobby Ren on 9/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//#import "UserInfo.h"
/*
@protocol ParseDelegate <NSObject>

-(void)didCreateParseUser;
-(void)didLoginParseUser;

@end
*/

@interface ParseHelper : NSObject

//@property (nonatomic, assign) id delegate;/
/*
+ (void)signup:(UserInfo*)userInfo withBlock:(void (^)(BOOL bDidSignupUser))didSignup;
+ (void)login:(UserInfo*) userInfo withBlock:(void (^)(BOOL bDidLoginUser))didLogin;
+ (BOOL)validateCachedUser:(UserInfo *)userInfo;
*/

+ (void)queryNearLocation:(CLLocation *)currentLocation withNearbyDistance:(CLLocationAccuracy)nearbyDistance forClassName:(NSString*)className withResultsBlock:(void(^)(NSArray* results))queriedResults;
@end
