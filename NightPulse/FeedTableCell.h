//
//  FeedTableCell.h
//  NightPulse
//
//  Created by Sachin Nene on 10/4/12.
//
//

#import <UIKit/UIKit.h>

@interface FeedTableCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel *venueNameLabel;
@property(nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property(nonatomic, retain) IBOutlet UIImageView * pulsePhotoImageView;
@property(nonatomic, retain) IBOutlet UILabel *userNameLabel;
@property(nonatomic, retain) IBOutlet UILabel *pulseAgeLabel;
@end
