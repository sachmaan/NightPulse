//
//  LabelMaker.m
//  NightPulse
//
//  Created by Sachin Nene on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LabelMaker.h"

const int secondsInMin = 60;
const int secondsInHour = secondsInMin * 60;
const int secondsInDay = secondsInHour * 24;

@implementation LabelMaker

+ (NSString *)crowdLabel:(NSInteger)crowdRatio {

    NSString *newStr;
    if (crowdRatio < 20) {
        newStr = @"Empty";
    } else if (crowdRatio >= 20 && crowdRatio < 40) {
        newStr = @"Moderate";
    } else if (crowdRatio >= 40 && crowdRatio < 65) {
        newStr = @"Half Full";
    } else if (crowdRatio >= 65 && crowdRatio < 85) {
        newStr = @"Pretty Crowded";
    } else {
        newStr = @"No Room to Breathe";
    }

    return newStr;
}

+ (NSString *)sexLabel:(NSInteger)sexRatio {
    NSString *newStr;
    if (sexRatio < 20) {
        newStr = @"Sausage Fest";
    } else if (sexRatio >= 20 && sexRatio < 40) {
        newStr = @"Way more guys";
    } else if (sexRatio >= 40 && sexRatio < 65) {
        newStr = @"Half guys, half girls";
    } else if (sexRatio >= 65 && sexRatio < 95) {
        newStr = @"Plenty of chicks";
    } else {
        newStr = @"Clambake!";
    }

    return newStr;
}

+ (NSString *)intervalLabel:(NSTimeInterval)interval {
    NSString *newStr;
    if (interval < secondsInMin) {
        newStr = [[[NSString alloc] initWithFormat:@"%i Sec Ago", interval] autorelease];
    } else if (interval < secondsInHour) {
        int min = interval / secondsInMin;
        newStr = [[[NSString alloc] initWithFormat:@"%i Min Ago", min] autorelease];
    } else if (interval < secondsInDay) {
        int hour = interval / secondsInHour;
        newStr = [[[NSString alloc] initWithFormat:@"%i Hr Ago", hour] autorelease];
    } else {
        int days = interval / secondsInDay;
        if (days <= 200) {
            newStr = [[[NSString alloc] initWithFormat:@"%i Days Ago", days] autorelease];
        } else {
            newStr = @">200 Days Ago";
        }
    }

    return newStr;
}

+ (NSString *)lineLabel:(NSInteger)lineSize {
    NSString *newStr;
    if (lineSize < 25) {
        newStr = @"No Line";
    } else if (lineSize < 50) {
        newStr = @"A few people in line";
    } else if (lineSize < 75) {
        newStr = @"10 min wait, at least";
    } else {
        newStr = @"Line is around the block!";
    }

    return newStr;
}

@end
