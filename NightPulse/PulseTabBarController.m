//
//  PulseTabBarController.m
//  NightPulse
//
//  Created by Sachin Nene on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PulseTabBarController.h"

// predefined although the buttons should be the correct size
#define BUTTON_WIDTH_CENTER 71
#define BUTTON_WIDTH 63
#define BUTTON_HEIGHT 40

#define INITIAL_SELECTED_INDEX 0

@implementation PulseTabBarController

@synthesize pulseNavController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedIndex:INITIAL_SELECTED_INDEX];
    selectedIndex = INITIAL_SELECTED_INDEX;
    
    UINavigationBar *navBar = [self.pulseNavController navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"NightPulseNavBar.png"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    
    [self addButtonWithImage:[UIImage imageNamed:@"tab_pulse"] highlightImage:nil atPosition:TABBAR_BUTTON_PULSE];
    
    [self addButtonWithImage:[UIImage imageNamed:@"tab_explore_off"] highlightImage:[UIImage imageNamed:@"tab_explore_on"] atPosition:TABBAR_BUTTON_EXPLORE];
    [self addButtonWithImage:[UIImage imageNamed:@"tab_feed_off"] highlightImage:[UIImage imageNamed:@"tab_feed_on"] atPosition:TABBAR_BUTTON_FEED];
    [self addButtonWithImage:[UIImage imageNamed:@"tab_news_off"] highlightImage:[UIImage imageNamed:@"tab_news_on"] atPosition:TABBAR_BUTTON_FRIENDS];
    [self addButtonWithImage:[UIImage imageNamed:@"tab_profile_off"] highlightImage:[UIImage imageNamed:@"tab_profile_on"] atPosition:TABBAR_BUTTON_PROFILE];
    
}

- (IBAction)buttonPressed:(id)sender {
    DebugLog(@"sender = %@", sender);
    for (int k = 0 ; k < TABBAR_BUTTON_MAX; k++) {
        if (sender == button[k]) {
            DebugLog(@"Found the position! %d", k);
            [self setSelectedIndex:k];
        }
    }
    //[self setSelectedIndex:pos];
}

-(void) addButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage atPosition:(int)pos
{
    if (pos>=TABBAR_BUTTON_MAX)
        return;
    
    button[pos] = [UIButton buttonWithType:UIButtonTypeCustom];
    button[pos].autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button[pos].frame = CGRectMake(0, 0, ceil(buttonImage.size.width), ceil(buttonImage.size.height));
    [button[pos] setBackgroundColor:[UIColor blackColor]];
    //NSLog(@"Button %d: image size %f %f frame %f %f %f %f", pos, buttonImage.size.width, buttonImage.size.height, button[pos].frame.origin.x, button[pos].frame.origin.y, button[pos].frame.size.width, button[pos].frame.size.height);
    bgNormal[pos] = buttonImage;
    bgSelected[pos] = highlightImage;
    [button[pos] setBackgroundImage:bgNormal[pos] forState:UIControlStateNormal];
    if (highlightImage)
        [button[pos] setBackgroundImage:bgSelected[pos] forState:UIControlStateHighlighted];
    
    CGPoint center;
    NSLog(@"Self.frame size: %f %f", self.view.frame.size.width, self.view.frame.size.height);
    float height = self.view.frame.size.height;
    if (pos == TABBAR_BUTTON_FEED) {
        center = CGPointMake(BUTTON_WIDTH * pos + ceil(BUTTON_WIDTH/2.0), height-ceil(BUTTON_HEIGHT/2.0));
    }
    else if (pos == TABBAR_BUTTON_EXPLORE) {
        center = CGPointMake(BUTTON_WIDTH * pos + ceil(BUTTON_WIDTH/2.0), height-ceil(BUTTON_HEIGHT/2.0));
    }
    else if (pos == TABBAR_BUTTON_FRIENDS) {
        center = CGPointMake(320 - BUTTON_WIDTH * (TABBAR_BUTTON_MAX - pos) + ceil(BUTTON_WIDTH/2.0), height - ceil(BUTTON_HEIGHT/2.0));
    }
    else if (pos == TABBAR_BUTTON_PROFILE) {
        center = CGPointMake(320 - BUTTON_WIDTH * (TABBAR_BUTTON_MAX - pos) + ceil(BUTTON_WIDTH/2.0), height - ceil(BUTTON_HEIGHT/2.0));
    }
    if (pos == TABBAR_BUTTON_PULSE)
        center = CGPointMake(161, 480 - (BUTTON_HEIGHT/2));
    
    center.y -= 4; //TABBAR_BUTTON_DIFF_PX - 1;
    
    button[pos].center = center;
    [button[pos] setTag:pos];
    [button[pos] addTarget:self
                    action:@selector(buttonPressed:)
          forControlEvents:UIControlEventTouchDown];
    CGRect frame = button[pos].frame;
    NSLog(@"Button %d: frame %f %f %f %f", pos, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    [self.view addSubview:button[pos]];
}

/*
 -(IBAction)didPressTabButton:(id)sender {
 UIButton * pressedButton = sender;
 [myDelegate didPressTabButton:pressedButton.tag];
 }
 */




@end
