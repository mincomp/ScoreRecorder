//
//  RoundData.m
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/28/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import "RoundData.h"

@implementation RoundData

- (id)init
{
    self = [super init];
    if (self)
    {
        self.scores = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
