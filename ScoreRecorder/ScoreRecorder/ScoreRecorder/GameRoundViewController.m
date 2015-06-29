//
//  GameRoundViewController.m
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/22/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import "GameRoundViewController.h"
#import "HistoryViewController.h"
#import "AddPlayerTableViewController.h"
#import "ScoreHelper.h"

@interface GameRoundViewController ()

@property (strong, nonatomic) NSMutableArray* scoreFields;

@end

@implementation GameRoundViewController

- (void) viewDidLayoutSubviews{
}

- (void) viewDidLoad {
    self.navigationItem.hidesBackButton = YES;
    [super viewDidLoad];
    
    if (self.firstRound) {
        // Reset scores.
        self.currentRoundTotal = [[RoundData alloc] init];
        for (NSString *player in self.players) {
            [self.currentRoundTotal.scores setObject:[NSNumber numberWithInt:0] forKey:player];
        }
        
        self.history = [[NSMutableArray alloc] init];
    }

    CGRect rect = self.view.bounds;
    float height = rect.size.height;
    float width = rect.size.width;
    
    float rowHeight = height / 20;
    float rowMargin = height / 40;
    float labelWidth = width / 5;
    float scoreWidth = width / 4;
    float x = width / 5;
    float y = height / 5;
    
    // Add column titles.
    UILabel *playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, labelWidth, rowHeight)];
    playerNameLabel.text = @"Player";
    [self.view addSubview:playerNameLabel];
    
    UILabel *cumulativeScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + labelWidth, y, labelWidth, rowHeight)];
    cumulativeScoreLabel.text = @"Total";
    [self.view addSubview:cumulativeScoreLabel];

    UILabel *currentRoundScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + labelWidth * 2, y, labelWidth, rowHeight)];
    currentRoundScoreLabel.text = @"Score";
    [self.view addSubview:currentRoundScoreLabel];
    
    y += rowHeight + rowMargin;
    
    self.scoreFields = [[NSMutableArray alloc] init];
    int highestScore = [ScoreHelper getHighestScore:self.currentRoundTotal];
    // Add player names and score fields.
    for (NSString* player in self.players) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, labelWidth, rowHeight)];
        nameLabel.text = player;
        [self.view addSubview:nameLabel];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + labelWidth, y, labelWidth, rowHeight)];
        NSNumber *score = self.currentRoundTotal.scores[player];
        if (score == [NSNumber numberWithInt:highestScore]) {
            scoreLabel.text = [NSString stringWithFormat:@"%@🌸", [score stringValue]];
        } else {
            scoreLabel.text = [score stringValue];
        }
        
        [self.view addSubview:scoreLabel];
        
        UITextField *scoreField = [[UITextField alloc] initWithFrame:CGRectMake(x + labelWidth * 2, y, scoreWidth, rowHeight)];
        scoreField.borderStyle = UITextBorderStyleLine;
        [self.view addSubview:scoreField];
        [self.scoreFields addObject:scoreField];
        
        y += rowHeight + rowMargin;
    }
    
    // Add "Next Round" button on the next row.
    UIButton* nextRound = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextRound setTitle:@"Next Round" forState:UIControlStateNormal];
    nextRound.frame = CGRectMake(x + labelWidth * 2, y, scoreWidth, rowHeight);
//    nextRound.layer.cornerRadius = 10;
//    nextRound.layer.borderWidth = 1.0;
//    nextRound.layer.borderColor = [UIColor grayColor].CGColor;
//    nextRound.clipsToBounds = YES;
    [nextRound addTarget:self action:@selector(nextRoundClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextRound];
}

- (void) nextRoundClicked:(UIButton*)sender {
    GameRoundViewController *nextRoundVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GameRound"];

    nextRoundVC.players = self.players;
    nextRoundVC.history = self.history;
    nextRoundVC.currentRoundTotal = [[RoundData alloc] init];
    nextRoundVC.currentRoundTotal.scores = [[NSMutableDictionary alloc] initWithDictionary:self.currentRoundTotal.scores copyItems:YES];
    RoundData *currentRound = [[RoundData alloc] init];
    for (int i = 0; i < self.scoreFields.count; i++) {
        NSString *name = self.players[i];
        UITextField *scoreField = self.scoreFields[i];
        int value = [scoreField.text intValue];
        currentRound.scores[name] = [NSNumber numberWithInt:value];
        int cv = [nextRoundVC.currentRoundTotal.scores[name] intValue];
        nextRoundVC.currentRoundTotal.scores[name] = [NSNumber numberWithInt:value + cv];
    }
    [nextRoundVC.history addObject:currentRound];
    nextRoundVC.firstRound = NO;
    
    [self.navigationController showViewController:nextRoundVC sender:self];
}

- (IBAction)restartGame:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"ShowHistory"]) {
        HistoryViewController *hvc = [segue destinationViewController];
        hvc.history = self.history;
        hvc.players = self.players;
    }
}

@end
