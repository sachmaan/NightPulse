//
//  NearbyVenueTableCell.m
//  NightPulse
//
//  Created by Sachin Nene on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NearbyVenueTableCell.h"

@implementation NearbyVenueTableCell

@synthesize venueName;
@synthesize venueDistance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
