//
//  SubsDetailViewController.m
//  Subs
//
//  Created by Martin van Amersfoorth on 9/18/12.
//  Copyright (c) 2012 Martin van Amersfoorth. All rights reserved.
//

#import "ParamsViewController.h"
#import "SchemeViewController.h"

@interface ParamsViewController ()
- (void)updateView;
@end

@implementation ParamsViewController

#pragma mark - Managing the fields

@synthesize totalField;
@synthesize squadField;
@synthesize substField;
@synthesize speedField;

- (void)setPlayers:(NSArray *)players
{
    _players = players;
    [self updateView];
}

- (void)updateView
{
    int totalCount = [_players count];
    int squadCount = [[squadField text] integerValue];
    int substCount = totalCount - squadCount;
    
    totalField.text = [[NSNumber numberWithInt:totalCount] stringValue];
    substField.text = [[NSNumber numberWithInt:substCount] stringValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
}

- (void)viewDidUnload
{
    [self setTotalField:nil];
    [self setSquadField:nil];
    [self setSubstField:nil];
    [self setSpeedField:nil];
    [super viewDidUnload];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if ( theTextField == self.squadField || theTextField == self.speedField )
    {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ( textField == self.squadField )
    {
        [self updateView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"setParams"])
    {
        [[segue destinationViewController] setPlayers:_players];
        [[segue destinationViewController] setSquadSize:[[squadField text] integerValue]];
        [[segue destinationViewController] setRotationSpeed:[[speedField text] integerValue] * 60.0];
    }
}

@end
