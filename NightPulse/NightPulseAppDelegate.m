//
//  NightPulseAppDelegate.m
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NightPulseAppDelegate.h"
#import "PulseRootViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "NearbyViewController.h"
//@implementation UINavigationBar (CustomImage)
//- (void)drawRect:(CGRect)rect
//{
//    UIImage *image = [UIImage imageNamed: @"NightPulseNavBar.png"];
//    DebugLog(@"Nav bar image found = %@", image);
//    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    [image release];
//}
//@end

@implementation NightPulseAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize peristentStoreCoordinator = _peristentStoreCoordinator;
@synthesize navController = _navController;

@synthesize currentVenueCache;
@synthesize venues;
@synthesize venueSearch;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // venue data
    currentVenueCache = [CurrentVenueCache getCache];
    [currentVenueCache registerDelegate:self];
    venueSearch = [[VenueSearch alloc] init];
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    
    // use nav controller instead
    /*
    PulseRootViewController * pulseRootViewController = [[PulseRootViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:pulseRootViewController];
    NearbyViewController * nearbyViewController = [[NearbyViewController alloc] init];
//    self.navController = [[UINavigationController alloc] initWithRootViewController:nearbyViewController];
    [self.navController.navigationBar setBarStyle:UIBarStyleBlack];
    self.window.rootViewController = self.navController;
     */
    [self.window makeKeyAndVisible];

    [Crashlytics startWithAPIKey:@"747b4305662b69b595ac36f88f9c2abe54885ba3"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc {
    [currentVenueCache release];
    [venueSearch release];

    [_window release];
    [_tabBarController release];
    [super dealloc];
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark LocationHelper

- (void)refreshVenues:(NSString *)searchTerm {
    
    DebugLog(@"Calling refresh");
    if (nil == searchTerm) {
        [currentVenueCache findNearestVenues:self];
    } else {
        [venueSearch searchForSpecificVenuesNearby:self searchTerm:searchTerm];
    }
}

-(NSArray*)getVenues {
    return venues;
}

- (void)onNearestVenueResult:(NSMutableArray *)venues_ {
    DebugLog(@"calling onNearestVenueResult");
    [venues_ retain];
    if (nil != venues)
        [venues release];
    venues = venues_;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_didGetVenues" object:self userInfo:nil];    
}

- (void)onNearestVenueSearchResult:(NSMutableArray *)venues_ {
    DebugLog(@"calling onNearestVenueSearchResult");
    venues = venues_;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_didGetVenues" object:self userInfo:nil];
}


@end
