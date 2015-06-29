//
//  ScoreHelper.h
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/28/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoundData.h"

@interface ScoreHelper : NSObject

+ (int) getHighestScore:(RoundData *)data;

@end
