//
//  DetailViewController.h
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/21/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

