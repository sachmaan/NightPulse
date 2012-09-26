//
//  NightPulseAppDelegate.h
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NearestVenueResultDelegate.h"
#import "CurrentVenueCache.h"
#import "VenueSearch.h"

static NSString * const kNotificationPulseSent = @"kNotificationPulseSent";
static NSString * const kNotificationDidGetLocation = @"kNotificationDidGetLocation";
@interface NightPulseAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate, NearestVenueResultDelegate>

@property(nonatomic, retain) IBOutlet UIWindow *window;

// views for root controller
@property(nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property(nonatomic, retain) IBOutlet UINavigationController * navController;

@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) NSManagedObjectModel *managedObjectModel;

@property(nonatomic, retain) NSPersistentStoreCoordinator *peristentStoreCoordinator;

// venue and search
@property(nonatomic, retain) NSMutableArray *venues;
@property(nonatomic, retain) CurrentVenueCache *currentVenueCache;
@property(nonatomic, retain) VenueSearch *venueSearch;

-(void)refreshVenues:(NSString*)searchTerm;
-(NSArray*)getVenues;

@end
