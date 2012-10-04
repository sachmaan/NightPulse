//
//  UserInfo.h
//  CrowdDynamics
//
//  Created by Bobby Ren on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseUserInfo : NSObject

@property (nonatomic) NSString * username;
@property (nonatomic) NSString * password;
@property (nonatomic) NSString * email;
@property (nonatomic) PFUser * pfUser;

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
