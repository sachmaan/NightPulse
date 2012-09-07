//
//  CameraViewController.h
//  NightPulse
//
//  Created by Bobby Ren on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"

@protocol CameraDelegate <NSObject>

-(void)didCaptureImage:(UIImage*)image;

@end

@interface CameraViewController : UIViewController

@property (retain) CaptureSessionManager *captureManager;
@property (nonatomic, assign) BOOL isCapturing;
@property (nonatomic, retain) IBOutlet UIButton * buttonCamera;
@property (nonatomic, assign) id delegate;

-(IBAction)didClickTakePicture:(id)sender;
@end
