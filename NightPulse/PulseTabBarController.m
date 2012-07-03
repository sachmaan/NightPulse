//
//  PulseTabBarController.m
//  NightPulse
//
//  Created by Sachin Nene on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PulseTabBarController.h"

@implementation PulseTabBarController

@synthesize pulseNavController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedIndex:2];

    UIImage *buttonImage = [UIImage imageNamed:@"tab_pulse.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:nil forState:UIControlStateHighlighted];

    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];


    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    CGPoint center = self.tabBar.center;
    center.y = center.y - heightDifference / 2.0 - 15;
    button.center = center;

    [self.view addSubview:button];

    UINavigationBar *navBar = [self.pulseNavController navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"NightPulseNavBar.png"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)buttonPressed:(id)sender {
    [self setSelectedIndex:2];
}


@end
