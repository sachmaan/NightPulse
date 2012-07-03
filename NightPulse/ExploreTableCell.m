//
//  ExploreTableCell.m
//  NightPulse
//
//  Created by Sachin Nene on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExploreTableCell.h"

@implementation ExploreTableCell

@synthesize venueName;
@synthesize venueMaleFemale;
@synthesize venueCrowd;
@synthesize venueLine;
@synthesize pulseAge;


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
