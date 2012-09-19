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
#import "CheckInViewController.h"

@protocol CameraDelegate <NSObject>

-(void)didCaptureImage:(UIImage*)image;
-(void)didCancelCaptureImage;
@end

@interface CameraViewController : UIViewController <UINavigationControllerDelegate>

@property (retain) CaptureSessionManager *captureManager;
@property (nonatomic, assign) BOOL isCapturing;
@property (nonatomic, retain) IBOutlet UIButton * buttonCamera;
@property (nonatomic, assign) id delegate;

-(IBAction)didClickTakePicture:(id)sender;
@end
