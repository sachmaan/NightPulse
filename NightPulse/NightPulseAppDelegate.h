//
//  NightPulseAppDelegate.h
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NightPulseAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, retain) IBOutlet UIWindow *window;

// views for root controller
@property(nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property(nonatomic, retain) IBOutlet UINavigationController * navController;

@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) NSManagedObjectModel *managedObjectModel;

@property(nonatomic, retain) NSPersistentStoreCoordinator *peristentStoreCoordinator;


@end
