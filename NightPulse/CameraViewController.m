//
//  CameraViewController.m
//  NightPulse
//
//  Created by Bobby Ren on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
@synthesize captureManager;
@synthesize isCapturing;
@synthesize buttonCamera;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NightPulseNavBar"]];
        [self.navigationItem setTitleView:logo];
        [logo release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setCaptureManager:[[CaptureSessionManager alloc] init]];
    int flashMode = [captureManager initializeCamera];

	CGRect layerRect = [[[self view] layer] bounds];
	[[[self captureManager] previewLayer] setBounds:layerRect];
	[[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect))];
    [[self.view layer] insertSublayer:[self.captureManager previewLayer] below: [self.buttonCamera layer]];
    // add a notification for completion of capture
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCaptureImage) name:kImageCapturedSuccessfully object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureImageDidFail:) name:kImageCaptureFailed object:nil];
    
    [self startCamera];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)startCamera {
    captureManager.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    [[captureManager captureSession] startRunning];
}

-(void)stopCamera {
    [[captureManager captureSession] stopRunning];
}


-(IBAction)didClickTakePicture:(id)sender {
    if (isCapturing)
        return;
    
#if !TARGET_IPHONE_SIMULATOR
    [[self captureManager] captureStillImage];
    isCapturing = YES;
#else
    [delegate didCaptureImage:[UIImage imageNamed:@"cwsf.jpg"]];
#endif
}

- (void)didCaptureImage 
{
    //    [[self scanningLabel] setHidden:YES];
    UIImage * originalImage = [self.captureManager stillImage];
    
    // for AVCapture, it seems that the original image is 1936x2592 == 3:4. the iphone at 320x480 == 1728x2592
    // so there is content to the sides that isn't captured
    
    //UIImageOrientation or = [baseImage imageOrientation];
    // orientation 3 is normal (vertical) camera use, orientation 0 is landscape mode
    UIImageOrientation or = [UIDevice currentDevice].orientation;
    // 1 = vertical/normal
    // 2 = upside down
    // 3 = landscape left
    // 4 = landscape right
    BOOL landscape = (or >= 3);
    UIImage * result;
    UIImage * scaled;
    CGRect croppedFrame;
    
    float original_height = originalImage.size.height;
    float original_width = originalImage.size.width;
    
    // for AVCapture, there is no automatic rotation for landscape.
    // the raw image is 1936x2592 for high res photo setting == 358x480  //720x1280.
    // we want an image at 320x480, so we have to crop the SIDES
    
    float scaled_width = original_width / original_height * 480; //320;
    float scaled_height = 480; ////original_height/original_width*320;
    scaled = [originalImage resizedImage:CGSizeMake(scaled_width, scaled_height) interpolationQuality:kCGInterpolationHigh];
    //float offsetY = (scaled_height - 480)/2;
    float offsetX = (scaled_width - 320) / 2;
    NSLog(@"originalWidth %f originalHeight %f", original_width, original_height);
    NSLog(@"scaledWidth %f scaledHeight %f offset %f", scaled_width, scaled_height, offsetX);
    // target_height is smaller than scaled_height so we only take the middle
    //croppedFrame = CGRectMake(0, offset, 320, 480);
    croppedFrame = CGRectMake(offsetX, 0, 320, 480);        
    result = [scaled croppedImage:croppedFrame];
    
    // result2 should be the exact same image as what the user sees in the camera view,
    // scaled down to the actual 320x480 size
    isCapturing = NO;
    
    [delegate didCaptureImage:result];
}

-(void)captureImageDidFail:(NSNotification*)notification {
    if ([[notification.userInfo objectForKey:@"code"] intValue] == -11801) {
        NSLog(@"Code=-11801 Cannot Complete Action UserInfo=0xe8b2480 {NSLocalizedRecoverySuggestion=Try again later., NSLocalizedDescription=Cannot Complete Action");
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Error!" message:@"Image couldn't be captured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}
@end
