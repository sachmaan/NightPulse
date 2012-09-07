//
//  Pulse.h
//  NightPulse
//
//  Created by Bobby Ren on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pulse : NSManagedObject

@property (nonatomic, retain) NSString * UserId;
@property (nonatomic, retain) NSString * VenueId;

@end
