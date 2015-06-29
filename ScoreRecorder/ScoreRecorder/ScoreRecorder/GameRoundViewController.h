//
//  GameRoundViewController.h
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/22/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundData.h"

@interface GameRoundViewController : UIViewController

@property (strong, nonatomic) NSMutableArray* players;
@property (strong, nonatomic) NSMutableArray *history;
@property (strong, nonatomic) RoundData *currentRoundTotal;
@property (nonatomic) BOOL firstRound;

@end
