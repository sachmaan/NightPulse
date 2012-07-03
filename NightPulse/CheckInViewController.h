//
//  PulseViewController.h
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckIn.h"

@interface CheckInViewController : UIViewController


@property(nonatomic, retain) IBOutlet UILabel *venueNameLabel;
@property(nonatomic, retain) IBOutlet UILabel *femaleRatioLabel;
@property(nonatomic, retain) IBOutlet UILabel *crowdRatioLabel;
@property(nonatomic, retain) IBOutlet UILabel *lineRatioLabel;
@property(nonatomic, retain) IBOutlet UISlider *maleFemaleSlider;
@property(nonatomic, retain) IBOutlet UISlider *crowdSlider;
@property(nonatomic, retain) IBOutlet UISlider *lineSlider;
@property(nonatomic, retain) IBOutlet UILabel *pulseSentLabel;
@property(nonatomic, retain) IBOutlet UIButton *sendPulseButton;

@property(nonatomic, retain) CheckIn *checkIn;

- (IBAction)sexRatioSliderChanged:(id)sender;

- (IBAction)sexRatioSliderReleased:(id)sender;

- (IBAction)crowdRatioChanged:(id)sender;

- (IBAction)lineRatioChanged:(id)sender;

- (IBAction)checkIn:(id)sender;


@end
