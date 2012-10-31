//
//  PulseTabBarController.h
//  NightPulse
//
//  Created by Sachin Nene on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PulseTabBarControllerDelegate

-(void)didPressTabButton:(int)pos;
-(void)didFinishRewardAnimation:(int)amount;
-(void)didCloseFirstTimeMessage;
//-(void)didCloseFirstTimeInstructions;
-(BOOL)canDisplayNewsCount;
-(BOOL)tabBarIsVisible;
-(int)getFirstTimeUserStage;
@end

enum {
    TABBAR_BUTTON_EXPLORE = 0,
    TABBAR_BUTTON_FEED,
    TABBAR_BUTTON_PULSE,
    TABBAR_BUTTON_FRIENDS,
    TABBAR_BUTTON_PROFILE,
    TABBAR_BUTTON_MAX
};

@interface PulseTabBarController : UITabBarController
{
    NSObject<PulseTabBarControllerDelegate> *__unsafe_unretained myDelegate;
    
    UIButton * button[TABBAR_BUTTON_MAX];
    UIImage * bgNormal[TABBAR_BUTTON_MAX];
    UIImage * bgSelected[TABBAR_BUTTON_MAX];
    
    int selectedIndex;
}

- (IBAction)buttonPressed:(id)sender;

@property(atomic, retain) IBOutlet UINavigationController *pulseNavController;

@end


