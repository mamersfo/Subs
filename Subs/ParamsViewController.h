//
//  SubsDetailViewController.h
//  Subs
//
//  Created by Martin van Amersfoorth on 9/18/12.
//  Copyright (c) 2012 Martin van Amersfoorth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParamsViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSArray *players;

@property (weak, nonatomic) IBOutlet UITextField *totalField;
@property (weak, nonatomic) IBOutlet UITextField *squadField;
@property (weak, nonatomic) IBOutlet UITextField *substField;
@property (weak, nonatomic) IBOutlet UITextField *speedField;

@end
