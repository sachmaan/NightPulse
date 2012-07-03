//
//  LabelMaker.h
//  NightPulse
//
//  Created by Sachin Nene on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelMaker : NSObject

+ (NSString *)crowdLabel:(NSInteger)crowdRatio;

+ (NSString *)sexLabel:(NSInteger)sexRatio;

+ (NSString *)intervalLabel:(NSTimeInterval)interval;

+ (NSString *)lineLabel:(NSInteger)lineSize;


@end
