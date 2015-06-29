//
//  ScoreHelper.m
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/28/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import "ScoreHelper.h"
#import "RoundData.h"

@implementation ScoreHelper

+ (int) getHighestScore:(RoundData *)data {
    BOOL assigned = NO;
    int highestScore = 0;
    for (NSNumber *score in [data.scores allValues]) {
        int value = [score intValue];
        if (assigned == NO) {
            assigned = YES;
            highestScore = value;
        } else {
            if (value > highestScore) {
                highestScore = value;
            }
        }
    }
    
    return highestScore;
}

@end
