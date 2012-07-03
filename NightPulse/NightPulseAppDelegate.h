//
//  NightPulseAppDelegate.h
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NightPulseAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property(nonatomic, retain) IBOutlet UIWindow *window;

@property(nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) NSManagedObjectModel *managedObjectModel;

@property(nonatomic, retain) NSPersistentStoreCoordinator *peristentStoreCoordinator;


@end
