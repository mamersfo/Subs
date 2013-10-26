//
//  SchemeViewController.h
//  Subs
//
//  Created by Martin van Amersfoorth on 9/18/12.
//  Copyright (c) 2012 Martin van Amersfoorth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchemeViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSArray *players;
@property (nonatomic) int numOutfield;
@property (nonatomic) int numSubs;
@property (nonatomic) int numMinutes;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

- (IBAction)replace:(id)sender;
- (IBAction)edit:(id)sender;
- (IBAction)timer:(id)sender;

@end
