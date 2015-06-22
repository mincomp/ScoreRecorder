//
//  AddPlayerTableViewController.h
//  ScoreRecorder
//
//  Created by Yunfeng Bai on 6/21/15.
//  Copyright (c) 2015 Yunfeng Bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPlayerTableViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) UIBarButtonItem* addButton;
@property (strong, nonatomic) NSMutableArray* values;

@end
