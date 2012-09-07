//
//  PulseViewController.m
//  NightPulse
//
//  Created by Sachin Nene on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInViewController.h"
#import "LabelMaker.h"

@implementation CheckInViewController

@synthesize venueNameLabel;
@synthesize femaleRatioLabel;
@synthesize crowdRatioLabel;
@synthesize lineRatioLabel;
@synthesize checkIn;
@synthesize maleFemaleSlider;
@synthesize crowdSlider;
@synthesize lineSlider;
@synthesize pulseSentLabel;
@synthesize sendPulseButton;
@synthesize delegate;

#pragma Helper Methods

+ (int)sliderIntValue:(id)sender {
    UISlider *slider = (UISlider *) sender;
    return (int) (slider.value + 0.5f);
}


#pragma General

- (void)dealloc {
    [femaleRatioLabel release];
    [maleFemaleSlider release];
    [lineSlider release];
    [crowdSlider release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.checkIn = [[[CheckIn alloc] init] autorelease];
        self.checkIn.sexRatio = [NSNumber numberWithInt:50];
        self.checkIn.crowdRatio = [NSNumber numberWithInt:50];
        self.checkIn.lineRatio = [NSNumber numberWithInt:50];



        DebugLog(@"CheckIn obj created =%@", self.checkIn);
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DebugLog(@"CheckIn View Did Load");


    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"CheckInBackground.png"]];
    self.view.backgroundColor = background;
    [background release];

//    UIImage *navBar = [UIImage imageNamed:@"NightPulseNavBar.png"];
//    UIImageView *navBarView = [[UIImageView alloc] initWithImage:navBar];
//    self.navigationItem.titleView = navBarView;
//    
//    [navBar release];
//    [navBarView release];


    UIImage *sliderLineImage = [UIImage imageNamed:@"slider_line.png"];
    UIImage *thumbImage = [UIImage imageNamed:@"slider.png"];

    [maleFemaleSlider setMinimumTrackImage:sliderLineImage forState:UIControlStateNormal];
    [maleFemaleSlider setMaximumTrackImage:sliderLineImage forState:UIControlStateNormal];
    [maleFemaleSlider setThumbImage:thumbImage forState:UIControlStateNormal];

    [crowdSlider setMinimumTrackImage:sliderLineImage forState:UIControlStateNormal];
    [crowdSlider setMaximumTrackImage:sliderLineImage forState:UIControlStateNormal];
    [crowdSlider setThumbImage:thumbImage forState:UIControlStateNormal];

    [lineSlider setMinimumTrackImage:sliderLineImage forState:UIControlStateNormal];
    [lineSlider setMaximumTrackImage:sliderLineImage forState:UIControlStateNormal];
    [lineSlider setThumbImage:thumbImage forState:UIControlStateNormal];

    [sliderLineImage release];
    [thumbImage release];

    self.venueNameLabel.text = self.checkIn.venue.name;

    self.femaleRatioLabel.text = [LabelMaker sexLabel:self.checkIn.sexRatio.integerValue];
    self.crowdRatioLabel.text = [LabelMaker crowdLabel:self.checkIn.crowdRatio.integerValue];
    self.lineRatioLabel.text = [LabelMaker lineLabel:self.checkIn.lineRatio.integerValue];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma Event Handling

- (IBAction)sexRatioSliderChanged:(id)sender {
    //UISlider *slider = (UISlider*) sender;
    int value = [CheckInViewController sliderIntValue:sender];
//    int femaleValue = 100 - maleValue;
//    DebugLog(@"Progress Int = %d, %d", maleValue, femaleValue);

//    NSString *maleTextStr = [[NSString alloc] initWithFormat:@"%d%% Male",maleValue];
//    NSString *femaleTextStr = [[NSString alloc] initWithFormat:@"%d%% Female",femaleValue];
//    self.maleRatioLabel.text = maleTextStr;
//    self.femaleRatioLabel.text = femaleTextStr;

    self.femaleRatioLabel.text = [LabelMaker sexLabel:value];

//    [maleTextStr release];
//    [femaleTextStr release];

    self.checkIn.sexRatio = [NSNumber numberWithInt:value];

}

- (IBAction)crowdRatioChanged:(id)sender {
    int crowdRatio = [CheckInViewController sliderIntValue:sender];

    self.crowdRatioLabel.text = [LabelMaker crowdLabel:crowdRatio];

    self.checkIn.crowdRatio = [NSNumber numberWithInt:crowdRatio];

}

- (IBAction)lineRatioChanged:(id)sender {
    int lineRatio = [CheckInViewController sliderIntValue:sender];
    self.lineRatioLabel.text = [LabelMaker lineLabel:lineRatio];
    self.checkIn.lineRatio = [NSNumber numberWithInt:lineRatio];
}

- (IBAction)sexRatioSliderReleased:(id)sender {
    DebugLog(@"Slider released!");
}

- (IBAction)checkIn:(id)sender {
    DebugLog(@"CheckInObj=%@", self.checkIn);
    CheckIn *checkInObj = self.checkIn;
    PFObject *pfObj = [checkInObj toPFObject];
    [pfObj saveInBackground];

    sendPulseButton.hidden = true;
    pulseSentLabel.hidden = false;

    NSNumber *boolYes = [[NSNumber alloc] initWithBool:YES];
//    [[self navigationController] performSelector:@selector(popViewControllerAnimated:) withObject:boolYes afterDelay:1];

    [boolYes release];
//    [[self navigationController] popViewControllerAnimated:YES];
    
    [delegate didCheckIn];
}

@end
