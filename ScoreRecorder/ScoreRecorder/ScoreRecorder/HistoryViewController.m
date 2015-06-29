//
//  HistoryViewController.m
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/28/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import "HistoryViewController.h"
#import "RoundData.h"
#import "ScoreHelper.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = self.view.bounds;
    float height = rect.size.height;
    float width = rect.size.width;
    
    float rowHeight = height / 20;
    float rowMargin = height / 40;
    float labelWidth = width / 5;
    float x = width / 5;
    float y = height / 5;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(x + labelWidth * (self.history.count + 1), y + (rowHeight + rowMargin) * (self.players.count + 1));
    [self.view addSubview:scrollView];
    
    // Add column titles.
    for (int i = 0; i < self.history.count; i++) {
        x += labelWidth;
        UILabel *roundLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, labelWidth, rowHeight)];
        roundLabel.text = [NSString stringWithFormat:@"Round %@", [@(i + 1) stringValue]];
        [scrollView addSubview:roundLabel];
    }
    
    // Add player names.
    x = width / 5;
    y = height / 5 + rowMargin + rowHeight;
    for (int i = 0; i < self.players.count; i++) {
        NSString *name = self.players[i];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, labelWidth, rowHeight)];
        nameLabel.text = name;
        [scrollView addSubview:nameLabel];
        y += rowHeight + rowMargin;
    }
    
    // Add scores.
    x = width / 5 + labelWidth;
    for (int i = 0; i < self.history.count; i++) {
        y = height / 5 + rowMargin + rowHeight;
        
        RoundData *round = self.history[i];
        int highestScore = [ScoreHelper getHighestScore:round];
        
        for (int j = 0; j < self.players.count; j++) {
            UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, labelWidth, rowHeight)];
            NSString *name = self.players[j];
            NSNumber *score = round.scores[name];
            if (score == [NSNumber numberWithInt:highestScore]) {
                scoreLabel.text = [NSString stringWithFormat:@"%@🌸", [score stringValue]];
            } else {
                scoreLabel.text = [score stringValue];
            }
            [scrollView addSubview:scoreLabel];
            
            y += rowHeight + rowMargin;
        }
        
        x += labelWidth;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
