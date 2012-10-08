//
//  FeedTableCell.m
//  NightPulse
//
//  Created by Sachin Nene on 10/4/12.
//
//

#import "FeedTableCell.h"

@implementation FeedTableCell

@synthesize venueNameLabel;
@synthesize pulsePhotoImageView;
@synthesize distanceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
