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

@synthesize outfieldPlayersField;
@synthesize substitutePlayersField;
@synthesize minutesField;

- (void)setPlayers:(NSArray *)players
{
    _players = players;
    [self updateView];
}

- (void)updateView
{
    int totalCount = [_players count];
    int outfieldPlayersCount = [[outfieldPlayersField text] integerValue];
    int substitutePlayersCount = totalCount - outfieldPlayersCount - 1;
    
    substitutePlayersField.text = [[NSNumber numberWithInt:substitutePlayersCount] stringValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
}

- (void)viewDidUnload
{
    [self setOutfieldPlayersField:nil];
    [self setSubstitutePlayersField:nil];
    [self setMinutesField:nil];
    [super viewDidUnload];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if ( theTextField == self.outfieldPlayersField || theTextField == self.minutesField )
    {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ( textField == self.outfieldPlayersField )
    {
        [self updateView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"setParams"])
    {
        [[segue destinationViewController] setPlayers:_players];
        [[segue destinationViewController] setNumOutfield:[[outfieldPlayersField text] integerValue]];
        [[segue destinationViewController] setNumSubs:[[substitutePlayersField text] integerValue]];
        [[segue destinationViewController] setNumMinutes:[[minutesField text] integerValue]];
    }
}

@end
