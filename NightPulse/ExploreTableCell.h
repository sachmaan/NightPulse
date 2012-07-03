//
//  ExploreTableCell.h
//  NightPulse
//
//  Created by Sachin Nene on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreTableCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel *venueName;
@property(nonatomic, retain) IBOutlet UILabel *venueMaleFemale;
@property(nonatomic, retain) IBOutlet UILabel *venueCrowd;
@property(nonatomic, retain) IBOutlet UILabel *venueLine;
@property(nonatomic, retain) IBOutlet UILabel *pulseAge;


@end
