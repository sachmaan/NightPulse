//
//  PulseTabBarController.h
//  NightPulse
//
//  Created by Sachin Nene on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PulseTabBarController : UITabBarController

- (IBAction)buttonPressed:(id)sender;

@property(atomic, retain) IBOutlet UINavigationController *pulseNavController;

@end
